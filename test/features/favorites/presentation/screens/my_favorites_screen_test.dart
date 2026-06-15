import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_snapshot_entity.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:youpass/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_widget.dart';
import 'package:youpass/features/favorites/presentation/screens/my_favorites_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late MockFavoritesRepository mockFavoritesRepository;

  setUp(() async {
    await sl.reset();
    mockFavoritesRepository = MockFavoritesRepository();

    when(() => mockFavoritesRepository.fetchAllFavorites()).thenAnswer(
      (_) async => const FavoritesSnapshotEntity(
        producers: [],
        events: [
          EventEntity(
            id: 'event-1',
            title: 'Summer Festival',
            dateTimeLabel: '15 Jul 2026 · 8:00 PM',
            dateLabel: '15 Jul 2026',
            locationLabel: 'Santiago, Chile',
            countryCode: 'CL',
            eventTypeSlug: 'concerts',
            imageUrl: 'https://example.com/summer-festival.jpg',
            isFavorite: true,
          ),
        ],
        eventsCount: 1,
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

  testWidgets('MyFavoritesScreen shows saved events only (promoters hidden)',
      (tester) async {
    final strings = lookupAppLocalizations(AppLocale.spanish);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MyFavoritesScreen(),
      ),
    );

    await tester.pumpAndSettle();

    verify(() => mockFavoritesRepository.fetchAllFavorites()).called(1);
    expect(find.text(strings.drawerMyFavorites), findsWidgets);
    expect(find.text(strings.favoritesEventsSubtitle), findsOneWidget);
    expect(find.text(strings.favoritesEventsSearchHint), findsOneWidget);
    expect(find.text(strings.favoritesSectionSavedEvents), findsOneWidget);
    expect(find.text(strings.favoritesSectionFollowedPromoters), findsNothing);
    expect(find.text(strings.favoritesViewEvents), findsNothing);
    expect(find.byType(EventBrowseCardWidget), findsOneWidget);
    expect(find.text(strings.favoritesSavedEventsCount(1)), findsOneWidget);
    expect(find.text(strings.favoritesSavedProducersCount(1)), findsNothing);
  });
}
