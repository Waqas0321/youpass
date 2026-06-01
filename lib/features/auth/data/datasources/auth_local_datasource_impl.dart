import 'dart:convert';

import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';

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
  Future<void> cacheToken(String token) async {
    await storageService.saveString(AppConstants.tokenKey, token);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final raw = storageService.getString(AppConstants.userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<String?> getCachedToken() async {
    return storageService.getString(AppConstants.tokenKey);
  }

  @override
  Future<void> clearCache() async {
    await storageService.remove(AppConstants.userKey);
    await storageService.remove(AppConstants.tokenKey);
  }
}
