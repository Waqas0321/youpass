import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youpass/core/auth/access_token_storage.dart';
import 'package:youpass/core/auth/auth_session_storage.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/network/api_client.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/core/services/storage_service.dart';
import 'package:youpass/core/theme/data/repositories/theme_preference_repository_impl.dart';
import 'package:youpass/core/theme/domain/repositories/theme_preference_repository.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:youpass/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youpass/features/auth/data/services/auth_api_service.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';
import 'package:youpass/features/auth/domain/usecases/check_whatsapp_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/confirm_delete_account_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/request_delete_account_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/upload_profile_photo_usecase.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/events/data/repositories/events_repository_impl.dart';
import 'package:youpass/features/events/data/services/events_api_service.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:youpass/features/events/domain/usecases/get_all_events_usecase.dart';
import 'package:youpass/features/events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/home/data/repositories/home_repository_impl.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';
import 'package:youpass/features/home/domain/usecases/get_filtered_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/domain/usecases/toggle_event_favorite_usecase.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/invitations/data/datasources/invitations_remote_datasource.dart';
import 'package:youpass/features/invitations/data/datasources/invitations_remote_datasource_impl.dart';
import 'package:youpass/features/invitations/data/repositories/invitations_repository_impl.dart';
import 'package:youpass/features/invitations/data/services/invitations_api_service.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';
import 'package:youpass/features/invitations/domain/usecases/check_saved_payment_methods_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_summary_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final preferences = await SharedPreferences.getInstance();
  final storageService = StorageService(preferences);
  final accessTokenStorage = SecureAccessTokenStorage(
    legacyStorage: storageService,
  );
  await AuthSessionStorage.hydrate(accessTokenStorage);

  sl
    ..registerLazySingleton<SharedPreferences>(() => preferences)
    ..registerLazySingleton<StorageService>(() => storageService)
    ..registerLazySingleton<AccessTokenStorage>(() => accessTokenStorage)
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(
        authTokenProvider: () => sl<AccessTokenStorage>().read(),
      ),
    )
    ..registerLazySingleton<ConfigApiService>(
      () => ConfigApiService(sl<ApiClient>()),
    )
    ..registerLazySingleton<AuthApiService>(
      () => AuthApiService(sl<ApiClient>()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<AuthApiService>()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        storageService: sl<StorageService>(),
        accessTokenStorage: sl<AccessTokenStorage>(),
      ),
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
    ..registerLazySingleton<CheckWhatsAppUseCase>(
      () => CheckWhatsAppUseCase(sl<AuthRepository>()),
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
    ..registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<RequestDeleteAccountUseCase>(
      () => RequestDeleteAccountUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<ConfirmDeleteAccountUseCase>(
      () => ConfirmDeleteAccountUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<UploadProfilePhotoUseCase>(
      () => UploadProfilePhotoUseCase(sl<AuthRepository>()),
    )
    ..registerLazySingleton<LocaleProvider>(LocaleProvider.new)
    ..registerLazySingleton<ThemePreferenceRepository>(
      () => ThemePreferenceRepositoryImpl(sl<StorageService>()),
    )
    ..registerFactory<AuthProvider>(
      () => AuthProvider(
        sendCodeUseCase: sl<SendCodeUseCase>(),
        resendCodeUseCase: sl<ResendCodeUseCase>(),
        checkWhatsAppUseCase: sl<CheckWhatsAppUseCase>(),
        loginUseCase: sl<LoginUseCase>(),
        registerUseCase: sl<RegisterUseCase>(),
        logoutUseCase: sl<LogoutUseCase>(),
        getUserProfileUseCase: sl<GetUserProfileUseCase>(),
        requestDeleteAccountUseCase: sl<RequestDeleteAccountUseCase>(),
        confirmDeleteAccountUseCase: sl<ConfirmDeleteAccountUseCase>(),
        uploadProfilePhotoUseCase: sl<UploadProfilePhotoUseCase>(),
        authRepository: sl<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<EventsApiService>(
      () => EventsApiService(sl<ApiClient>()),
    )
    ..registerLazySingleton<EventsRepository>(
      () => createEventsRepository(
        eventsApiService: sl<EventsApiService>(),
        localeProvider: sl<LocaleProvider>(),
      ),
    )
    ..registerLazySingleton<GetAllEventsUseCase>(
      () => GetAllEventsUseCase(sl<EventsRepository>()),
    )
    ..registerLazySingleton<GetFavoriteEventsUseCase>(
      () => GetFavoriteEventsUseCase(sl<EventsRepository>()),
    )
    ..registerLazySingleton<events_usecases.ToggleEventFavoriteUseCase>(
      () => events_usecases.ToggleEventFavoriteUseCase(sl<EventsRepository>()),
    )
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        eventsRepository: sl<EventsRepository>(),
      ),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
    )
    ..registerLazySingleton<GetHomeFeedUseCase>(
      () => GetHomeFeedUseCase(sl<HomeRepository>()),
    )
    ..registerLazySingleton<GetFilteredHomeEventsUseCase>(
      () => GetFilteredHomeEventsUseCase(sl<HomeRepository>()),
    )
    ..registerLazySingleton<ToggleEventFavoriteUseCase>(
      () => ToggleEventFavoriteUseCase(sl<HomeRepository>()),
    )
    ..registerLazySingleton<HomeProvider>(
      () => HomeProvider(
        getHomeFeedUseCase: sl<GetHomeFeedUseCase>(),
        getFilteredHomeEventsUseCase: sl<GetFilteredHomeEventsUseCase>(),
        toggleEventFavoriteUseCase: sl<ToggleEventFavoriteUseCase>(),
      ),
    )
    ..registerLazySingleton<InvitationsApiService>(
      () => InvitationsApiService(sl<ApiClient>()),
    )
    ..registerLazySingleton<InvitationsRemoteDataSource>(
      () => InvitationsRemoteDataSourceImpl(
        apiService: sl<InvitationsApiService>(),
        localeProvider: sl<LocaleProvider>(),
      ),
    )
    ..registerLazySingleton<InvitationsRepository>(
      () => InvitationsRepositoryImpl(sl<InvitationsRemoteDataSource>()),
    )
    ..registerLazySingleton<FetchInvitationsUseCase>(
      () => FetchInvitationsUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<FetchInvitationsSummaryUseCase>(
      () => FetchInvitationsSummaryUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<CheckSavedPaymentMethodsUseCase>(
      () => CheckSavedPaymentMethodsUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<ConfirmInvitationUseCase>(
      () => ConfirmInvitationUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<RejectInvitationUseCase>(
      () => RejectInvitationUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<FetchInvitationTicketUseCase>(
      () => FetchInvitationTicketUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<SavePaymentMethodUseCase>(
      () => SavePaymentMethodUseCase(sl<InvitationsRepository>()),
    )
    ..registerLazySingleton<InvitationsProvider>(
      () => InvitationsProvider(
        fetchInvitationsUseCase: sl<FetchInvitationsUseCase>(),
        fetchInvitationsSummaryUseCase: sl<FetchInvitationsSummaryUseCase>(),
        checkSavedPaymentMethodsUseCase: sl<CheckSavedPaymentMethodsUseCase>(),
        confirmInvitationUseCase: sl<ConfirmInvitationUseCase>(),
        rejectInvitationUseCase: sl<RejectInvitationUseCase>(),
        fetchInvitationTicketUseCase: sl<FetchInvitationTicketUseCase>(),
        savePaymentMethodUseCase: sl<SavePaymentMethodUseCase>(),
      ),
    );

  await CountryCodeList.initialize(sl<ConfigApiService>());
}
