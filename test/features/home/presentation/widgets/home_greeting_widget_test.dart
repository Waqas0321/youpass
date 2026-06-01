import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/widgets/home_greeting_widget.dart';

import '../../../../helpers/localization_test_helper.dart';

void main() {
  testWidgets('HomeGreetingWidget displays localized greeting and subtitle',
      (tester) async {
    await tester.pumpWidget(
      LocalizationTestHelper.wrap(
        child: const HomeGreetingWidget(userName: 'Christian'),
      ),
    );

    expect(find.textContaining('Hello'), findsOneWidget);
    expect(find.textContaining('Christian'), findsOneWidget);
    expect(find.textContaining('Discover'), findsOneWidget);
  });
}
