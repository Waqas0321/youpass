import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/youpass_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initDependencies();
  });

  tearDownAll(() async {
    await sl.reset();
  });

  testWidgets('shows phone login screen after splash', (tester) async {
    await tester.pumpWidget(const YouPassApp());
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.welcomeBackTitle), findsOneWidget);
    expect(find.text(strings.sendCodeButton), findsOneWidget);
  });

  testWidgets('navigates to verification screen from login', (tester) async {
    await tester.pumpWidget(const YouPassApp());
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final strings = lookupAppLocalizations(AppLocale.english);
    await tester.tap(find.text(strings.sendCodeButton));
    await tester.pumpAndSettle();

    expect(find.text(strings.verificationCodeTitle), findsOneWidget);
    expect(find.text(strings.validateCodeButton), findsOneWidget);
  });
}
