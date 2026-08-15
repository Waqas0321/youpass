import 'package:flutter/material.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_back_button_widget.dart';
import 'package:youpass/core/widgets/auth_content_container.dart';
import 'package:youpass/core/widgets/auth_scaffold.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';

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
    final topSpacing = logoTopSpacing ?? layout.spacing(40);
    final afterLogoSpacing = headerSpacing ??
        (showVolterBackButton
            ? AuthLayoutConstants.headerAfterLogo(layout)
            : AuthLayoutConstants.headerAfterLogo(layout));

    final scrollBody = SingleChildScrollView(
      padding: layout.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Keep logo/form spacing as before — BACK is not part of this column.
          SizedBox(height: showVolterBackButton ? 0 : topSpacing),
          Center(
            child: YouPassBrandLogo(
              // ~50% larger than the default auth mark (client request).
              width: (layout.width * 0.82).clamp(270.0, 360.0),
            ),
          ),
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
    );

    return AuthScaffold(
      showBackButton: showScaffoldBackButton,
      onBackPressed: onBackPressed,
      // Only BACK moves to the top; logo + form stay centered as before.
      topBar: showVolterBackButton
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: layout.horizontalPadding),
              child: AuthBackButtonWidget(onPressed: onBackPressed),
            )
          : null,
      body: AuthContentContainer(child: scrollBody),
    );
  }
}
