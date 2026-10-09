import 'package:flutter/foundation.dart';
import 'package:youpass/staff_app/features/scan/data/staff_recent_scans_cache.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/storage/staff_token_store.dart';
import 'package:youpass/staff_app/core/utils/app_logger.dart';
import 'package:youpass/staff_app/features/auth/data/models/staff_lookup_response.dart';
import 'package:youpass/staff_app/features/auth/data/models/staff_send_code_response.dart';
import 'package:youpass/staff_app/features/auth/data/models/staff_session.dart';
import 'package:youpass/staff_app/features/auth/data/staff_auth_api_service.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';

class StaffAuthProvider extends ChangeNotifier {
  StaffAuthProvider({
    StaffAuthApiService? apiService,
    StaffTokenStore? tokenStore,
  }) : _apiService = apiService ?? StaffAuthApiService(ApiClient()),
       _tokenStore = tokenStore ?? StaffTokenStore();

  final StaffAuthApiService _apiService;
  final StaffTokenStore _tokenStore;

  StaffProfile? _profile;
  bool _isSubmitting = false;
  String? _errorMessage;
  String? _errorCode;
  int? _retryAfterSeconds;

  StaffProfile? get profile => _profile;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  String? get errorCode => _errorCode;
  int? get retryAfterSeconds => _retryAfterSeconds;
  bool get isAuthenticated => _profile != null;

  void _setError(Object error) {
    if (error is ApiException) {
      _errorCode = error.code;
      _errorMessage = error.message;
      _retryAfterSeconds = error.retryAfterSeconds;
    } else {
      _errorCode = 'REQUEST_FAILED';
      _errorMessage = error.toString();
      _retryAfterSeconds = null;
    }
  }

  void _clearError() {
    _errorCode = null;
    _errorMessage = null;
    _retryAfterSeconds = null;
  }

  Future<void> _persistProfile(StaffProfile profile) {
    return _tokenStore.saveProfileJson(profile.toJson());
  }

  Future<StaffProfile?> _readCachedProfile() async {
    final json = await _tokenStore.readProfileJson();
    if (json == null) {
      return null;
    }
    return StaffProfile.fromJson(json);
  }

  bool _isNetworkFailure(Object error) {
    if (error is ApiException) {
      return error.code == 'NETWORK_ERROR';
    }
    final message = error.toString().toLowerCase();
    return message.contains('socket') ||
        message.contains('network') ||
        message.contains('failed host lookup') ||
        message.contains('connection') ||
        message.contains('timeout') ||
        message.contains('unreachable');
  }

  Future<StaffLookupResponse?> lookup({
    required String phone,
    required String countryCode,
  }) async {
    _clearError();
    try {
      return await _apiService.lookup(phone: phone, countryCode: countryCode);
    } catch (error) {
      _setError(error);
      return null;
    }
  }

  Future<bool> isStaffPhone({
    required String phone,
    required String countryCode,
  }) async {
    final result = await lookup(phone: phone, countryCode: countryCode);
    return result?.isStaff == true;
  }

  Future<StaffSendCodeResponse?> sendCode({
    required String phone,
    required String countryCode,
  }) async {
    _isSubmitting = true;
    _clearError();
    notifyListeners();

    try {
      final result = await _apiService.sendCode(
        phone: phone,
        countryCode: countryCode,
      );
      if (result.devOtpCode != null && result.devOtpCode!.isNotEmpty) {
        AppLogger.devOtp(
          phone: result.phone,
          purpose: 'staff_login',
          code: result.devOtpCode!,
        );
      }
      return result;
    } catch (error) {
      _setError(error);
      return null;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<StaffSendCodeResponse?> resendCode({
    required String phone,
    required String countryCode,
  }) async {
    _isSubmitting = true;
    _clearError();
    notifyListeners();

    try {
      return await _apiService.resendCode(
        phone: phone,
        countryCode: countryCode,
      );
    } catch (error) {
      _setError(error);
      return null;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> login({
    required String phone,
    required String countryCode,
    required String code,
  }) async {
    _isSubmitting = true;
    _clearError();
    notifyListeners();

    try {
      final session = await _apiService.login(
        phone: phone,
        countryCode: countryCode,
        code: code,
      );
      await _tokenStore.saveToken(session.accessToken);
      final offlineSecret = session.offlineSigningSecret;
      if (offlineSecret != null && offlineSecret.isNotEmpty) {
        await _tokenStore.saveOfflineSigningSecret(offlineSecret);
      }
      _profile = session.staff;
      await _persistProfile(session.staff);
      try {
        await StaffScanApiService(ApiClient()).syncOfflineQueue();
      } catch (_) {}
      return true;
    } catch (error) {
      _setError(error);
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  /// Restores staff session for offline scan work.
  /// Network failure keeps the local token + cached profile (do not force logout).
  Future<bool> restoreSession() async {
    final hasSession = await _tokenStore.hasSession();
    if (!hasSession) {
      return false;
    }

    try {
      _profile = await _apiService.fetchMe();
      if (_profile != null) {
        await _persistProfile(_profile!);
      }
      notifyListeners();
      try {
        await StaffScanApiService(ApiClient()).syncOfflineQueue();
      } catch (_) {}
      return true;
    } catch (error) {
      if (_isNetworkFailure(error)) {
        final cached = await _readCachedProfile();
        if (cached != null) {
          AppLogger.debug(
            'Offline restore: using cached staff profile',
            tag: 'StaffAuth',
          );
          _profile = cached;
          notifyListeners();
          return true;
        }
        // Token exists but no cached profile yet — still allow offline scan
        // if signing secret is present (permissions default empty until online).
        final secret = await _tokenStore.readOfflineSigningSecret();
        if (secret != null && secret.isNotEmpty) {
          _profile = StaffProfile(
            id: 'offline',
            name: 'Staff',
            phone: '',
            status: 'offline',
            permissionIds: const ['scan_tickets', 'scan_products'],
          );
          notifyListeners();
          return true;
        }
      }

      final code = error is ApiException ? error.code : null;
      if (code == 'UNAUTHORIZED' ||
          code == 'SESSION_INVALID' ||
          code == 'STAFF_INACTIVE') {
        await _tokenStore.clearSession();
        _profile = null;
        notifyListeners();
        return false;
      }

      // Unknown error while offline-ish: prefer keep session if we have cache.
      final cached = await _readCachedProfile();
      if (cached != null) {
        _profile = cached;
        notifyListeners();
        return true;
      }

      await _tokenStore.clearSession();
      _profile = null;
      notifyListeners();
      return false;
    }
  }

  Future<bool> refreshProfile() async {
    try {
      _profile = await _apiService.fetchMe();
      if (_profile != null) {
        await _persistProfile(_profile!);
      }
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (_) {}
    await _tokenStore.clearSession();
    await StaffRecentScansCache().clear();
    _profile = null;
    notifyListeners();
  }
}
