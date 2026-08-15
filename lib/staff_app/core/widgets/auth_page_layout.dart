import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/constants/auth_layout_constants.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/auth_back_button_widget.dart';
import 'package:youpass/staff_app/core/widgets/auth_content_container.dart';
import 'package:youpass/staff_app/core/widgets/auth_scaffold.dart';
import 'package:youpass/staff_app/core/widgets/youpass_logo.dart';

class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    this.showScaffoldBackButton = false,
    this.showVolterBackButton = false,
    this.onBackPressed,
    this.header,
    required this.body,
    this.footer,
    this.logoTopSpacing,
    this.headerSpacing,
  });

  final bool showScaffoldBackButton;
  final bool showVolterBackButton;
  final VoidCallback? onBackPressed;
  final Widget? header;
  final Widget body;
  final Widget? footer;
  final double? logoTopSpacing;
  final double? headerSpacing;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final topSpacing = logoTopSpacing ??
        (showVolterBackButton
            ? AuthLayoutConstants.compactTop(layout)
            : layout.spacing(24));
    final afterLogoSpacing = headerSpacing ??
        (showVolterBackButton
            ? AuthLayoutConstants.backAfterLogo(layout)
            : AuthLayoutConstants.headerAfterLogo(layout));

    return AuthScaffold(
      showBackButton: showScaffoldBackButton,
      onBackPressed: onBackPressed,
      body: AuthContentContainer(
        child: SingleChildScrollView(
          padding: layout.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: topSpacing),
              if (showVolterBackButton) ...[
                AuthBackButtonWidget(onPressed: onBackPressed),
                SizedBox(height: afterLogoSpacing),
              ],
              const Center(child: YouPassLogo()),
              SizedBox(height: afterLogoSpacing),
              if (header != null) ...[
                header!,
                SizedBox(height: AuthLayoutConstants.sectionGap(layout)),
              ],
              body,
              if (footer != null) ...[
                SizedBox(height: AuthLayoutConstants.sectionGap(layout)),
                footer!,
              ],
              SizedBox(height: AuthLayoutConstants.screenBottom(layout)),
            ],
          ),
        ),
      ),
    );
  }
}
