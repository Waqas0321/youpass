import 'package:flutter/material.dart';

class ResponsiveLayout {
  ResponsiveLayout(BuildContext context)
      : mediaQuery = MediaQuery.of(context),
        size = MediaQuery.sizeOf(context);

  final MediaQueryData mediaQuery;
  final Size size;

  static const double designWidth = 390;
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  double get width => size.width;
  double get height => size.height;

  double get scale => (width / designWidth).clamp(0.82, 1.3);

  bool get isTablet => width >= tabletBreakpoint;
  bool get isDesktop => width >= desktopBreakpoint;
  bool get isSmallPhone => width < 360;

  double get contentMaxWidth {
    if (isDesktop) {
      return 520;
    }
    if (isTablet) {
      return 480;
    }
    return width;
  }

  double get horizontalPadding {
    if (isDesktop) {
      return width * 0.12;
    }
    if (isTablet) {
      return width * 0.1;
    }
    return width * 0.072;
  }

  EdgeInsets get screenPadding =>
      EdgeInsets.symmetric(horizontal: horizontalPadding);

  double spacing(double value) => value * scale;

  double fontSize(double value) {
    final scaled = value * scale;
    return scaled.clamp(value * 0.9, value * 1.25);
  }

  double radius(double value) => value * scale;

  double get buttonHeight => spacing(52);

  double get logoFontSize => fontSize(36);

  double get titleFontSize => fontSize(22);

  double get bodyFontSize => fontSize(14);

  double get labelFontSize => fontSize(12);

  double get otpGap => spacing(6);

  double otpBoxWidth(double maxWidth) {
    final gapTotal = otpGap * 5;
    final calculated = (maxWidth - gapTotal) / 6;
    return calculated.clamp(spacing(40), spacing(56));
  }

  double get otpBoxHeight => spacing(56);

  double get curveSize => spacing(220);

  double get iconSize => spacing(28);
}
