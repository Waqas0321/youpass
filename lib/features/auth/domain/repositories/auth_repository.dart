import 'package:youpass/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<void> sendVerificationCode({
    required String countryCode,
    required String phoneNumber,
  });

  Future<UserEntity> verifyCode({
    required String countryCode,
    required String phoneNumber,
    required String code,
  });

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}
