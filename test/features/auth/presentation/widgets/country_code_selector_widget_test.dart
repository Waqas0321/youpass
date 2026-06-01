import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/features/auth/presentation/widgets/country_code_selector_widget.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/localization_test_helper.dart';

class CountrySelectorTestHost extends StatefulWidget {
  const CountrySelectorTestHost({super.key});

  @override
  State<CountrySelectorTestHost> createState() => CountrySelectorTestHostState();
}

class CountrySelectorTestHostState extends State<CountrySelectorTestHost> {
  CountryCode selectedCountry = CountryCodeList.defaultCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CountryCodeSelectorWidget(
        selectedCountry: selectedCountry,
        onCountryChanged: (country) {
          setState(() => selectedCountry = country);
        },
      ),
    );
  }
}

void main() {
  testWidgets('CountryCodeSelectorWidget opens picker and selects country',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(child: const CountrySelectorTestHost()),
    );

    expect(find.text('🇨🇱'), findsOneWidget);
    expect(find.text('+56'), findsOneWidget);

    await tester.tap(find.byType(CountryCodeSelectorWidget));
    await tester.pumpAndSettle();

    expect(
      find.text(lookupAppLocalizations(AppLocale.english).selectCountryTitle),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'Argentina');
    await tester.pumpAndSettle();

    expect(find.text('+54'), findsOneWidget);

    await tester.tap(find.text('+54'));
    await tester.pumpAndSettle();

    expect(find.text('🇦🇷'), findsOneWidget);
    expect(find.text('+54'), findsOneWidget);
  });
}
