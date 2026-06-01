import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/utils/phone_validators.dart';

void main() {
  group('PhoneValidators', () {
    group('chileMobile', () {
      test('returns error when empty', () {
        expect(PhoneValidators.chileMobile(null), isNotNull);
        expect(PhoneValidators.chileMobile(''), isNotNull);
      });

      test('returns error for invalid length', () {
        expect(PhoneValidators.chileMobile('91234'), isNotNull);
      });

      test('returns error when not starting with 9', () {
        expect(PhoneValidators.chileMobile('812345678'), isNotNull);
      });

      test('returns null for valid number', () {
        expect(PhoneValidators.chileMobile('912345678'), isNull);
      });
    });
  });
}
