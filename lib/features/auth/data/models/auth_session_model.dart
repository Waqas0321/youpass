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
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    final token = json['access_token'] as String? ??
        json['accessToken'] as String? ??
        '';

    return AuthSessionModel(
      accessToken: token,
      user: userJson is Map<String, dynamic>
          ? UserModel.fromAuthJson(userJson)
          : const UserModel(id: '', email: '', name: ''),
      sessionId: json['session_id'] as String?,
      isNewUser: json['is_new_user'] as bool? ?? false,
      welcome: _parseWelcome(json['welcome']),
    );
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
