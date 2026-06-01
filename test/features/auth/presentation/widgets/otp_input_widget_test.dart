import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/presentation/widgets/otp_input_widget.dart';

void main() {
  testWidgets('OtpInputWidget accepts six digits', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpInputWidget(
            controller: controller,
            autofocus: false,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), '123456');
    await tester.pump();

    expect(controller.text, '123456');
    expect(find.text('1'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
  });
}
