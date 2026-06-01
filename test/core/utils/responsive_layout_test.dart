import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

void main() {
  testWidgets('ResponsiveLayout adapts padding and breakpoints', (tester) async {
    late ResponsiveLayout phoneLayout;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(360, 800)),
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              phoneLayout = ResponsiveLayout(context);
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(phoneLayout.isTablet, isFalse);
    expect(phoneLayout.horizontalPadding, greaterThan(20));

    late ResponsiveLayout tabletLayout;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(800, 1200)),
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              tabletLayout = ResponsiveLayout(context);
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(tabletLayout.isTablet, isTrue);
    expect(
      tabletLayout.horizontalPadding,
      greaterThan(phoneLayout.horizontalPadding),
    );
    expect(tabletLayout.contentMaxWidth, lessThan(800));
  });
}
