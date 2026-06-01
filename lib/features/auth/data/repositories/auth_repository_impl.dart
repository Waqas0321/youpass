import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.login(
      email: email,
      password: password,
    );
    await localDataSource.cacheUser(user);
    await localDataSource.cacheToken('mock_token_${user.id}');
    return user;
  }

  @override
  Future<void> sendVerificationCode({
    required String countryCode,
    required String phoneNumber,
  }) {
    return remoteDataSource.sendVerificationCode(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<UserEntity> verifyCode({
    required String countryCode,
    required String phoneNumber,
    required String code,
  }) async {
    final user = await remoteDataSource.verifyCode(
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      code: code,
    );
    await localDataSource.cacheUser(user);
    await localDataSource.cacheToken('mock_token_${user.id}');
    return user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCache();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return localDataSource.getCachedUser();
  }
}
