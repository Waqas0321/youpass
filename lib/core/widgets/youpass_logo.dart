import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class YouPassLogo extends StatelessWidget {
  const YouPassLogo({
    super.key,
    this.fontStyle = FontStyle.normal,
  });

  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: layout.logoFontSize,
          fontWeight: FontWeight.w700,
          fontStyle: fontStyle,
          color: AppColors.primaryMustard,
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(text: AppConstants.appName),
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Transform.translate(
              offset: Offset(layout.spacing(2), -layout.spacing(8)),
              child: AppText(
                '®',
                variant: AppTextVariant.body,
                fontSize: layout.fontSize(14),
                fontWeight: FontWeight.w600,
                color: AppColors.primaryMustard,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
