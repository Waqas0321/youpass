import 'package:equatable/equatable.dart';
import 'package:youpass/features/auth/domain/entities/post_registration_navigation_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';

class AuthSessionEntity extends Equatable {
  const AuthSessionEntity({
    required this.accessToken,
    required this.user,
    this.sessionId,
    this.isNewUser = false,
    this.welcome,
    this.navigation,
    this.linkedInvitations = 0,
  });

  final String accessToken;
  final UserEntity user;
  final String? sessionId;
  final bool isNewUser;
  final WelcomeEntity? welcome;
  final PostRegistrationNavigationEntity? navigation;
  final int linkedInvitations;

  @override
  List<Object?> get props => [
        accessToken,
        user,
        sessionId,
        isNewUser,
        welcome,
        navigation,
        linkedInvitations,
      ];
}
