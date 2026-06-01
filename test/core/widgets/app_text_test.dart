import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

void main() {
  testWidgets('AppText renders title variant', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppText('Hello', variant: AppTextVariant.title),
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
    expect(find.byType(AppText), findsOneWidget);
  });
}
