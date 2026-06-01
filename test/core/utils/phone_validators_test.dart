import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  late AppLocalizations l10n;

  setUp(() {
    l10n = lookupAppLocalizations(AppLocale.english);
  });

  group('PhoneValidators', () {
    group('chileMobile', () {
      test('returns error when value is null or empty', () {
        expect(PhoneValidators.chileMobile(l10n, null), isNotNull);
        expect(PhoneValidators.chileMobile(l10n, ''), isNotNull);
      });

      test('returns error for invalid length', () {
        expect(PhoneValidators.chileMobile(l10n, '91234'), isNotNull);
      });

      test('returns error when not starting with 9', () {
        expect(PhoneValidators.chileMobile(l10n, '812345678'), isNotNull);
      });

      test('returns null for valid number', () {
        expect(PhoneValidators.chileMobile(l10n, '912345678'), isNull);
      });
    });
  });
}
