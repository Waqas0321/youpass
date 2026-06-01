import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/widgets/app_button.dart';

void main() {
  testWidgets('AppButton shows label and triggers onPressed', (tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Submit',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Submit'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(pressed, isTrue);
  });

  testWidgets('AppButton shows loader when isLoading is true', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Submit',
            onPressed: null,
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Submit'), findsNothing);
  });
}
