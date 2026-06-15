import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/services/home_search_history_cache.dart';
import 'package:youpass/core/services/user_location_service.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/home/domain/usecases/get_upcoming_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/search_home_events_usecase.dart';

class MockSearchHomeEventsUseCase extends Mock implements SearchHomeEventsUseCase {}

class MockGetUpcomingHomeEventsUseCase extends Mock
    implements GetUpcomingHomeEventsUseCase {}

class MockHomeSearchHistoryCache extends Mock implements HomeSearchHistoryCache {}

class MockUserLocationService extends Mock implements UserLocationService {}

void registerSearchFallbacks() {
  registerFallbackValue(const HomeEventsQuery());
}
