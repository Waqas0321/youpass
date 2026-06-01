import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource_impl.dart';

void main() {
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = AuthRemoteDataSourceImpl();
  });

  test('login returns user with provided email', () async {
    final result = await dataSource.login(
      email: 'john@youpass.com',
      password: 'secret123',
    );

    expect(result.email, 'john@youpass.com');
    expect(result.name, 'john');
    expect(result.id, isNotEmpty);
  });
}
