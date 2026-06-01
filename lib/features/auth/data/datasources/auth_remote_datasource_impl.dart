import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return UserModel(
      id: '1',
      email: email,
      name: email.split('@').first,
    );
  }

  @override
  Future<void> sendVerificationCode({
    required String countryCode,
    required String phoneNumber,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<UserModel> verifyCode({
    required String countryCode,
    required String phoneNumber,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return UserModel(
      id: phoneNumber,
      email: '$phoneNumber@youpass.com',
      name: 'Usuario',
    );
  }
}
