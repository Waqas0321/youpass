import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource_impl.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class MockEventsRepository extends Mock implements EventsRepository {}

void main() {
  late MockEventsRepository mockEventsRepository;
  late HomeRemoteDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(
      const EventCategoryEntity(
        id: AppConstants.categoryIdChile,
        label: 'Chile',
        icon: Icons.location_on_outlined,
        countryCode: 'CL',
      ),
    );
  });

  setUp(() {
    mockEventsRepository = MockEventsRepository();
    dataSource = HomeRemoteDataSourceImpl(
      eventsRepository: mockEventsRepository,
    );
  });

  test('toggleEventFavorite delegates add and remove to events repository',
      () async {
    when(
      () => mockEventsRepository.addEventFavorite('event-1'),
    ).thenAnswer((_) async {});
    when(
      () => mockEventsRepository.removeEventFavorite('event-1'),
    ).thenAnswer((_) async {});

    await dataSource.toggleEventFavorite(
      eventId: 'event-1',
      isFavorite: false,
    );
    await dataSource.toggleEventFavorite(
      eventId: 'event-1',
      isFavorite: true,
    );

    verify(() => mockEventsRepository.addEventFavorite('event-1')).called(1);
    verify(() => mockEventsRepository.removeEventFavorite('event-1')).called(1);
  });
}
