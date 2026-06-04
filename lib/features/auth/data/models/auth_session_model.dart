import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/data/models/welcome_model.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';

class AuthSessionModel extends AuthSessionEntity {
  const AuthSessionModel({
    required super.accessToken,
    required super.user,
    super.sessionId,
    super.isNewUser,
    super.welcome,
    this.cachedLoginProfile,
  });

  /// Profile snapshot from login/register `user` payload when `/users/me` is delayed.
  final UserProfileModel? cachedLoginProfile;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    final token = _readAccessToken(json);
    final cachedProfile = userJson is Map<String, dynamic>
        ? UserProfileModel.fromJson(userJson)
        : null;

    return AuthSessionModel(
      accessToken: token,
      user: userJson is Map<String, dynamic>
          ? UserModel.fromAuthJson(userJson)
          : const UserModel(id: '', email: '', name: ''),
      sessionId: json['session_id']?.toString().trim(),
      isNewUser: json['is_new_user'] as bool? ?? false,
      welcome: _parseWelcome(json['welcome']),
      cachedLoginProfile: cachedProfile,
    );
  }

  static String _readAccessToken(Map<String, dynamic> json) {
    final raw = json['access_token'] ?? json['accessToken'] ?? json['token'];
    if (raw == null) {
      return '';
    }
    return raw.toString().trim();
  }

  static WelcomeEntity? _parseWelcome(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }

    final welcome = WelcomeModel.fromJson(value);
    if (welcome.title.isEmpty || welcome.subtitle.isEmpty) {
      return null;
    }

    return welcome;
  }
}
