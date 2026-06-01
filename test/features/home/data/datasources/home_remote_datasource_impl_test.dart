import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource_impl.dart';

void main() {
  late HomeRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = HomeRemoteDataSourceImpl();
  });

  test('fetchHomeFeed returns categories, featured events, and events', () async {
    final result = await dataSource.fetchHomeFeed();

    expect(result.categories, isNotEmpty);
    expect(result.featuredEvents, isNotEmpty);
    expect(result.events, isNotEmpty);
    expect(result.categories.first.id, AppConstants.categoryIdChile);
    expect(result.events.first.id, AppConstants.eventIdCaribeNight);
  });
}
