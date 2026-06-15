import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/widgets/home_greeting_widget.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('HomeGreetingWidget displays greeting text',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: const HomeGreetingWidget(greetingText: 'Hi, Alex!'),
      ),
    );

    expect(find.text('Hi, Alex!'), findsOneWidget);
    expect(find.textContaining('Discover'), findsNothing);
  });

  testWidgets('HomeGreetingWidget renders nothing when greeting is empty',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: const HomeGreetingWidget(),
      ),
    );

    expect(find.byType(HomeGreetingWidget), findsOneWidget);
    expect(find.textContaining('Discover'), findsNothing);
    expect(find.textContaining('Hi'), findsNothing);
  });
}
