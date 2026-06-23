import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_snapshot_entity.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:youpass/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_widget.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/events/domain/usecases/get_all_events_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/events/presentation/screens/all_events_screen.dart';
import 'package:youpass/features/favorites/presentation/screens/my_favorites_screen.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorite_producer_card_widget.dart';
import 'package:youpass/routes/app_routes.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_feed_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/cancel_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/check_saved_payment_methods_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_detail_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_feed_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_summary_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/l10n/app_localizations.dart';
import '../../../../features/auth/mocks/mock_auth_repository.dart';
import '../../../../features/invitations/mocks/mock_invitations_repository.dart';
import '../../../../helpers/auth_test_helper.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockEventsRepository extends Mock implements EventsRepository {}

void main() {
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() async {
    await sl.reset();
    registerFallbackValue(const HomeEventsQuery());
    mockFavoritesRepository = MockFavoritesRepository();

    when(() => mockFavoritesRepository.fetchAllFavorites()).thenAnswer(
      (_) async => const FavoritesSnapshotEntity(
        producers: [
          FavoriteProducerEntity(
            id: 'producer-1',
            name: 'PK LIVE',
            typeLabel: 'Event producer',
            coverageLabel: 'Events across Chile',
          ),
        ],
        events: [],
        producersCount: 1,
        eventsCount: 0,
      ),
    );

    sl.registerLazySingleton<FavoritesRepository>(() => mockFavoritesRepository);
    sl.registerLazySingleton<FavoritesProvider>(
      () => FavoritesProvider(repository: mockFavoritesRepository),
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('Explore events opens all events screen when favorites empty',
      (tester) async {
    when(() => mockFavoritesRepository.fetchAllFavorites()).thenAnswer(
      (_) async => const FavoritesSnapshotEntity(
        producers: [],
        events: [],
        producersCount: 0,
        eventsCount: 0,
      ),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    final mockAuthRepository = MockAuthRepository();
    final mockInvitationsRepository = MockInvitationsRepository();
    final mockEventsRepository = MockEventsRepository();
    AuthTestHelper.registerFallbacks();
    AuthTestHelper.stubSendCodeSuccess(mockAuthRepository);
    when(() => mockEventsRepository.fetchEventTypes()).thenAnswer((_) async => const []);
    when(() => mockEventsRepository.fetchBrowseCategories())
        .thenAnswer((_) async => const []);
    when(() => mockEventsRepository.fetchAllEvents(any()))
        .thenAnswer((_) async => const []);
    sl.registerLazySingleton<EventsRepository>(() => mockEventsRepository);
    sl.registerLazySingleton<GetAllEventsUseCase>(
      () => GetAllEventsUseCase(mockEventsRepository),
    );
    sl.registerLazySingleton<events_usecases.ToggleEventFavoriteUseCase>(
      () => events_usecases.ToggleEventFavoriteUseCase(mockEventsRepository),
    );

    final invitationsProvider = InvitationsProvider(
      fetchInvitationsFeedUseCase:
          FetchInvitationsFeedUseCase(mockInvitationsRepository),
      fetchInvitationsSummaryUseCase:
          FetchInvitationsSummaryUseCase(mockInvitationsRepository),
      fetchInvitationDetailUseCase:
          FetchInvitationDetailUseCase(mockInvitationsRepository),
      checkSavedPaymentMethodsUseCase:
          CheckSavedPaymentMethodsUseCase(mockInvitationsRepository),
      confirmInvitationUseCase: ConfirmInvitationUseCase(mockInvitationsRepository),
      rejectInvitationUseCase: RejectInvitationUseCase(mockInvitationsRepository),
      cancelInvitationUseCase: CancelInvitationUseCase(mockInvitationsRepository),
      fetchInvitationTicketUseCase:
          FetchInvitationTicketUseCase(mockInvitationsRepository),
      savePaymentMethodUseCase: SavePaymentMethodUseCase(mockInvitationsRepository),
      eventsRepository: mockEventsRepository,
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthTestHelper.buildAuthProvider(mockAuthRepository),
          ),
          ChangeNotifierProvider.value(value: invitationsProvider),
        ],
        child: MaterialApp(
          locale: AppLocale.english,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MyFavoritesScreen(),
          routes: {
            AppRoutes.allEvents: (_) => const AllEventsScreen(),
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text(strings.favoritesExploreCta));
    await tester.pumpAndSettle();

    expect(find.text(strings.allEventsTitle), findsOneWidget);
    expect(find.text(strings.favoritesEventsEmpty), findsNothing);
  });

  testWidgets('MyFavoritesScreen shows followed promoters only',
      (tester) async {
    final strings = lookupAppLocalizations(AppLocale.english);
    final mockAuthRepository = MockAuthRepository();
    final mockInvitationsRepository = MockInvitationsRepository();
    final mockEventsRepository = MockEventsRepository();
    AuthTestHelper.registerFallbacks();
    AuthTestHelper.stubSendCodeSuccess(mockAuthRepository);
    when(() => mockEventsRepository.fetchEventTypes()).thenAnswer((_) async => const []);
    when(() => mockInvitationsRepository.fetchInvitationsFeed()).thenAnswer(
      (_) async => const InvitationsFeedEntity(invitations: [], waitlistEntries: []),
    );
    when(() => mockInvitationsRepository.fetchSummary()).thenAnswer(
      (_) async => const InvitationsSummaryEntity(
        pendingCount: 0,
        newCount: 0,
        totalCount: 0,
      ),
    );

    final invitationsProvider = InvitationsProvider(
      fetchInvitationsFeedUseCase:
          FetchInvitationsFeedUseCase(mockInvitationsRepository),
      fetchInvitationsSummaryUseCase:
          FetchInvitationsSummaryUseCase(mockInvitationsRepository),
      fetchInvitationDetailUseCase:
          FetchInvitationDetailUseCase(mockInvitationsRepository),
      checkSavedPaymentMethodsUseCase:
          CheckSavedPaymentMethodsUseCase(mockInvitationsRepository),
      confirmInvitationUseCase: ConfirmInvitationUseCase(mockInvitationsRepository),
      rejectInvitationUseCase: RejectInvitationUseCase(mockInvitationsRepository),
      cancelInvitationUseCase: CancelInvitationUseCase(mockInvitationsRepository),
      fetchInvitationTicketUseCase:
          FetchInvitationTicketUseCase(mockInvitationsRepository),
      savePaymentMethodUseCase: SavePaymentMethodUseCase(mockInvitationsRepository),
      eventsRepository: mockEventsRepository,
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthTestHelper.buildAuthProvider(mockAuthRepository),
          ),
          ChangeNotifierProvider.value(value: invitationsProvider),
        ],
        child: MaterialApp(
          locale: AppLocale.english,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MyFavoritesScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    verify(() => mockFavoritesRepository.fetchAllFavorites()).called(1);
    expect(find.text(strings.drawerMyFavorites), findsWidgets);
    expect(find.text(strings.favoritesEventsSubtitle), findsOneWidget);
    expect(find.text(strings.favoritesEventsSearchHint), findsOneWidget);
    expect(find.text(strings.favoritesSectionSavedEvents), findsNothing);
    expect(find.text(strings.favoritesSectionFollowedPromoters), findsNothing);
    expect(find.byType(FavoriteProducerCardWidget), findsOneWidget);
    expect(find.text(strings.favoritesViewEvents), findsOneWidget);
    expect(find.byType(EventBrowseCardWidget), findsNothing);
    expect(find.text(strings.favoritesSavedProducersCount(1)), findsOneWidget);
    expect(find.text(strings.favoritesSavedEventsCount(1)), findsNothing);
  });
}
