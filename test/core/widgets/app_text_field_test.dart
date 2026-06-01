import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/widgets/app_text_field.dart';

void main() {
  testWidgets('AppTextField accepts input', (tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppTextField(
            controller: controller,
            hintText: 'Enter phone',
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '912345678');
    expect(controller.text, '912345678');
  });
}
