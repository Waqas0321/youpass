import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';

class AuthSessionModel extends AuthSessionEntity {
  const AuthSessionModel({
    required super.accessToken,
    required super.user,
    super.sessionId,
    super.isNewUser,
    super.welcome,
    this.loginUserJson,
  });

  /// Raw `user` object from login/register — used to cache profile when `/users/me` fails.
  final Map<String, dynamic>? loginUserJson;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    final token = _readAccessToken(json);

    return AuthSessionModel(
      accessToken: token,
      user: userJson is Map<String, dynamic>
          ? UserModel.fromAuthJson(userJson)
          : const UserModel(id: '', email: '', name: ''),
      sessionId: json['session_id']?.toString(),
      isNewUser: json['is_new_user'] as bool? ?? false,
      welcome: _parseWelcome(json['welcome']),
      loginUserJson: userJson is Map<String, dynamic> ? userJson : null,
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

    final title = value['title'] as String?;
    final subtitle = value['subtitle'] as String?;
    if (title == null || subtitle == null) {
      return null;
    }

    final duration = value['duration_seconds'];
    return WelcomeEntity(
      title: title,
      subtitle: subtitle,
      durationSeconds: duration is int
          ? duration
          : duration is num
              ? duration.toInt()
              : 2,
    );
  }
}
