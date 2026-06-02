import 'dart:convert';

import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this.storageService);

  final StorageService storageService;

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
    await storageService.saveString(AppConstants.tokenKey, token);
  }

  @override
  Future<void> cacheSessionId(String sessionId) async {
    await storageService.saveString(AppConstants.sessionIdKey, sessionId);
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
    return storageService.getString(AppConstants.tokenKey);
  }

  @override
  Future<void> clearCache() async {
    AuthTokenStore.clear();
    await storageService.remove(AppConstants.userKey);
    await storageService.remove(AppConstants.userProfileKey);
    await storageService.remove(AppConstants.tokenKey);
    await storageService.remove(AppConstants.sessionIdKey);
  }
}
