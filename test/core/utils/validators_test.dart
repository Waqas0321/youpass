import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('email', () {
      test('returns error when value is null', () {
        expect(Validators.email(null), 'Email is required');
      });

      test('returns error when value is empty', () {
        expect(Validators.email('   '), 'Email is required');
      });

      test('returns error for invalid email', () {
        expect(Validators.email('not-an-email'), 'Enter a valid email');
      });

      test('returns null for valid email', () {
        expect(Validators.email('user@youpass.com'), isNull);
      });
    });

    group('password', () {
      test('returns error when value is null', () {
        expect(Validators.password(null), 'Password is required');
      });

      test('returns error when password is too short', () {
        expect(Validators.password('12345'), 'Password must be at least 6 characters');
      });

      test('returns null for valid password', () {
        expect(Validators.password('123456'), isNull);
      });
    });
  });
}
