import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/screens/register_screen.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/auth_test_helper.dart';

void main() {
  testWidgets('RegisterScreen shows create account UI in English', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(child: const RegisterScreen()),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.backButton), findsOneWidget);
    expect(find.text(strings.createAccountSubtitle), findsOneWidget);
    expect(find.text(strings.fullNameLabel), findsOneWidget);
    expect(find.byType(YouPassPrimaryButton), findsOneWidget);
    expect(find.text(strings.signInLink), findsOneWidget);
  });

  testWidgets('RegisterScreen opens gender picker on tap', (tester) async {
    await tester.pumpWidget(
      AuthTestHelper.wrap(child: const RegisterScreen()),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    final genderField = find.text(strings.genderHint);

    await tester.ensureVisible(genderField);
    await tester.pumpAndSettle();
    await tester.tap(genderField);
    await tester.pumpAndSettle();

    expect(find.text(strings.genderMale), findsOneWidget);
  });
}
