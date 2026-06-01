import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:youpass/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youpass/features/auth/data/services/auth_api_service.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:youpass/features/home/data/repositories/home_repository_impl.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final preferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton<SharedPreferences>(() => preferences)
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(
        authTokenProvider: () async =>
            sl<StorageService>().getString(AppConstants.tokenKey),
      ),
    )
    ..registerLazySingleton<ConfigApiService>(
      () => ConfigApiService(sl<ApiClient>()),
    )
    ..registerLazySingleton<AuthApiService>(
      () => AuthApiService(sl<ApiClient>()),
    )
    ..registerLazySingleton<StorageService>(
      () => StorageService(sl<SharedPreferences>()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<AuthApiService>()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<StorageService>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        localDataSource: sl<AuthLocalDataSource>(),
      ),
    )
    ..registerLazySingleton<SendCodeUseCase>(
      () => SendCodeUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<ResendCodeUseCase>(
      () => ResendCodeUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<LocaleProvider>(LocaleProvider.new)
    ..registerFactory<AuthProvider>(
      () => AuthProvider(
        sendCodeUseCase: sl<SendCodeUseCase>(),
        resendCodeUseCase: sl<ResendCodeUseCase>(),
        loginUseCase: sl<LoginUseCase>(),
        registerUseCase: sl<RegisterUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        authRepository: sl<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<HomeRemoteDataSource>(
      HomeRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
    )
    ..registerLazySingleton<GetHomeFeedUseCase>(
      () => GetHomeFeedUseCase(sl<HomeRepository>()),
    )
    ..registerFactory<HomeProvider>(
      () => HomeProvider(sl<GetHomeFeedUseCase>()),
    );

  await CountryCodeList.initialize(sl<ConfigApiService>());
}
