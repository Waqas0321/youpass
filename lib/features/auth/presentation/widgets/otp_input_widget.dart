import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class OtpInputWidget extends StatelessWidget {
  const OtpInputWidget({super.key});

  static const int otpLength = 6;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = layout.otpBoxWidth(constraints.maxWidth);
        final boxHeight = layout.otpBoxHeight;
        final boxRadius = layout.radius(12);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(otpLength, (index) {
            return Container(
              width: boxWidth,
              height: boxHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(boxRadius),
                border: Border.all(color: AppColors.lightGreyBorder),
              ),
              child: const AppText(
                '—',
                variant: AppTextVariant.otpPlaceholder,
              ),
            );
          }),
        );
      },
    );
  }
}
