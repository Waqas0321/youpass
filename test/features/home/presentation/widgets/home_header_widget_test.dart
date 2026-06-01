import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/widgets/home_header_widget.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/l10n/app_localizations.dart';

import '../../../../helpers/localization_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  testWidgets('HomeHeaderWidget displays localized title and subtitle',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: Scaffold(
          body: HomeHeaderWidget(homeData: TestFixtures.testHome),
        ),
      ),
    );

    final strings = lookupAppLocalizations(AppLocale.english);
    expect(find.text(strings.homeDashboardTitle), findsOneWidget);
    expect(find.text(strings.homeDashboardSubtitle), findsOneWidget);
  });
}
