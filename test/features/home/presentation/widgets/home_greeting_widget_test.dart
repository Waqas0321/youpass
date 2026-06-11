import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/widgets/home_greeting_widget.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('HomeGreetingWidget displays discover subtitle by default',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: const HomeGreetingWidget(),
      ),
    );

    expect(find.textContaining('Discover'), findsOneWidget);
  });

  testWidgets('HomeGreetingWidget displays custom subtitle when provided',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: const HomeGreetingWidget(subtitle: 'Custom subtitle'),
      ),
    );

    expect(find.text('Custom subtitle'), findsOneWidget);
  });
}
