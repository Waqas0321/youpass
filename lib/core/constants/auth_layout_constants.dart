import 'package:youpass/core/utils/responsive_layout.dart';

class AuthLayoutConstants {
  AuthLayoutConstants._();

  static double screenBottom(ResponsiveLayout layout) => layout.spacing(24);

  static double fieldGap(ResponsiveLayout layout) => layout.spacing(20);

  static double sectionGap(ResponsiveLayout layout) => layout.spacing(32);

  static double headerAfterLogo(ResponsiveLayout layout) => layout.spacing(40);

  static double compactTop(ResponsiveLayout layout) => layout.spacing(8);

  static double backAfterLogo(ResponsiveLayout layout) => layout.spacing(16);
}
