import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/auth_headers.dart';

void main() {
  test('authHeaders returns Bearer authorization and json content type', () {
    final headers = authHeaders('eyJ.test.token');

    expect(headers['Authorization'], 'Bearer eyJ.test.token');
    expect(headers['Content-Type'], 'application/json');
    expect(headers.containsKey('X-Session-Id'), isFalse);
  });

  test('authHeaders strips accidental Bearer prefix from token', () {
    final headers = authHeaders('  Bearer eyJ.test.token  ');

    expect(headers['Authorization'], 'Bearer eyJ.test.token');
  });

  test('authHeaders returns json content type only when token empty', () {
    final headers = authHeaders('');

    expect(headers.containsKey('Authorization'), isFalse);
    expect(headers['Content-Type'], 'application/json');
  });

  test('authHeadersMultipart returns bearer only', () {
    final headers = authHeadersMultipart('eyJ.test.token');

    expect(headers['Authorization'], 'Bearer eyJ.test.token');
    expect(headers.containsKey('Content-Type'), isFalse);
    expect(headers.containsKey('X-Session-Id'), isFalse);
  });
}
