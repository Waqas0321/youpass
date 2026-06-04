import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/favorites/presentation/screens/my_favorites_screen.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class MockEventsRepository extends Mock implements EventsRepository {}

void main() {
  late MockEventsRepository mockEventsRepository;

  setUp(() async {
    await sl.reset();
    mockEventsRepository = MockEventsRepository();

    when(() => mockEventsRepository.fetchFavoriteEvents()).thenAnswer(
      (_) async => const [
        EventEntity(
          id: 'event-1',
          title: 'Summer Festival',
          dateTimeLabel: '15 Jul 2026',
          dateLabel: '15 Jul',
          locationLabel: 'Santiago, Chile',
          countryCode: 'CL',
          eventTypeSlug: 'concerts',
          isFavorite: true,
        ),
      ],
    );

    when(() => mockEventsRepository.fetchBrowseCategories()).thenAnswer(
      (_) async => const [
        EventCategoryEntity(
          id: AppConstants.categoryIdAll,
          label: 'Todas',
          icon: Icons.apps_outlined,
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdChile,
          label: 'Chile',
          icon: Icons.location_on_outlined,
          countryCode: 'CL',
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdConcerts,
          label: 'Conciertos',
          icon: Icons.music_note_outlined,
          eventTypeSlug: 'concerts',
        ),
      ],
    );

    sl.registerLazySingleton<GetFavoriteEventsUseCase>(
      () => GetFavoriteEventsUseCase(mockEventsRepository),
    );
    sl.registerLazySingleton<events_usecases.ToggleEventFavoriteUseCase>(
      () => events_usecases.ToggleEventFavoriteUseCase(mockEventsRepository),
    );

    sl.registerLazySingleton<EventsRepository>(() => mockEventsRepository);
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('MyFavoritesScreen shows localized favorites UI', (tester) async {
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

    expect(find.text(strings.drawerMyFavorites), findsWidgets);
    expect(find.text(strings.favoritesEventsSubtitle), findsOneWidget);
    expect(find.text('SUMMER FESTIVAL'), findsOneWidget);
    expect(
      find.text(strings.favoritesEventsSearchHint),
      findsOneWidget,
    );
    expect(
      find.text(strings.favoritesSavedEventsCount(1)),
      findsOneWidget,
    );
    expect(find.text(strings.favoritesFiltersLabel), findsOneWidget);
    expect(find.text('Todas'), findsOneWidget);
  });
}
