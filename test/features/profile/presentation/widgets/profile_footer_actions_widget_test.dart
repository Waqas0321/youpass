import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_footer_actions_widget.dart';

void main() {
  testWidgets('ProfileFooterActionsWidget applies bottom safe area clearance', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            padding: EdgeInsets.only(bottom: 34),
            size: Size(390, 844),
          ),
          child: Scaffold(
            body: SingleChildScrollView(
              child: ProfileFooterActionsWidget(
                children: const [
                  SizedBox(height: 48, child: ColoredBox(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final footerRect = tester.getRect(find.byType(ProfileFooterActionsWidget));
    final screenRect = tester.getRect(find.byType(Scaffold));
    expect(screenRect.bottom - footerRect.bottom, greaterThanOrEqualTo(34));
  });

  testWidgets('systemBottomInset falls back on zero reported insets', (tester) async {
    late double inset;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        home: Builder(
          builder: (context) {
            inset = ProfileDesignSpec.systemBottomInset(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(inset, greaterThan(0));
  });
}
