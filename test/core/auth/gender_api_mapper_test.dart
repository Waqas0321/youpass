import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/auth/gender_api_mapper.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  test('maps localized gender labels to API values', () {
    final l10n = lookupAppLocalizations(AppLocale.english);

    expect(GenderApiMapper.toApiValue(l10n.genderMale, l10n), 'male');
    expect(GenderApiMapper.toApiValue(l10n.genderFemale, l10n), 'female');
    expect(
      GenderApiMapper.toApiValue(l10n.genderPreferNotToSay, l10n),
      'prefer_not_to_say',
    );
  });
}
