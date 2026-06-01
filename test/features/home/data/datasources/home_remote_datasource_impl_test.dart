import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource_impl.dart';

void main() {
  late HomeRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = HomeRemoteDataSourceImpl();
  });

  test('fetchHomeData returns dashboard data', () async {
    final result = await dataSource.fetchHomeData();

    expect(result.title, 'Dashboard');
    expect(result.subtitle, isNotEmpty);
  });
}
