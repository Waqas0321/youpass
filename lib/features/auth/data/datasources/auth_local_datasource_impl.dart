import 'dart:convert';

import 'package:youpass/core/auth/access_token_storage.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required this.storageService,
    required this.accessTokenStorage,
  });

  final StorageService storageService;
  final AccessTokenStorage accessTokenStorage;

  @override
  Future<void> cacheUser(UserModel user) async {
    await storageService.saveString(
      AppConstants.userKey,
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<void> cacheUserProfile(UserProfileModel profile) async {
    await storageService.saveString(
      AppConstants.userProfileKey,
      jsonEncode(profile.toJson()),
    );
    await cacheUser(profile.toUserModel());
  }

  @override
  Future<void> cacheToken(String token) async {
    await accessTokenStorage.write(token);
  }

  @override
  Future<void> cacheSessionId(String sessionId) async {
    final normalized = AuthTokenStore.normalizeSessionId(sessionId);
    if (normalized == null) {
      return;
    }
    await storageService.saveString(AppConstants.sessionIdKey, normalized);
  }

  @override
  Future<void> clearSessionId() async {
    await storageService.remove(AppConstants.sessionIdKey);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final raw = storageService.getString(AppConstants.userKey);
    if (raw == null) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<UserProfileModel?> getCachedUserProfile() async {
    final raw = storageService.getString(AppConstants.userProfileKey);
    if (raw == null) {
      return null;
    }

    return UserProfileModel.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  @override
  Future<String?> getCachedToken() async {
    return accessTokenStorage.read();
  }

  @override
  Future<void> clearCache() async {
    AuthTokenStore.clear();
    await accessTokenStorage.delete();
    await storageService.remove(AppConstants.userKey);
    await storageService.remove(AppConstants.userProfileKey);
    await storageService.remove(AppConstants.sessionIdKey);
  }
}
