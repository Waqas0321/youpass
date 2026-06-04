import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/utils/validators.dart';
import 'package:youpass/l10n/app_localizations.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  group('Validators', () {
    group('email', () {
      test('returns error when value is null', () {
        expect(Validators.email(l10n, null), l10n.emailRequired);
      });

      test('returns error when value is empty', () {
        expect(Validators.email(l10n, '   '), l10n.emailRequired);
      });

      test('returns error for invalid email', () {
        expect(Validators.email(l10n, 'not-an-email'), l10n.emailInvalid);
      });

      test('returns null for valid email', () {
        expect(Validators.email(l10n, 'user@youpass.com'), isNull);
      });
    });

    group('password', () {
      test('returns error when value is null', () {
        expect(Validators.password(l10n, null), l10n.passwordRequired);
      });

      test('returns error when password is too short', () {
        expect(
          Validators.password(l10n, '12345'),
          l10n.passwordMinLength,
        );
      });

      test('returns null for valid password', () {
        expect(Validators.password(l10n, '123456'), isNull);
      });
    });
  });
}
