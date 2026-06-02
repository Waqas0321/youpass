import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> cacheUserProfile(UserProfileModel profile);
  Future<void> cacheToken(String token);
  Future<void> cacheSessionId(String sessionId);
  Future<UserModel?> getCachedUser();
  Future<UserProfileModel?> getCachedUserProfile();
  Future<String?> getCachedToken();
  Future<void> clearCache();
}
