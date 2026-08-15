import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class AuthBackButtonWidget extends StatelessWidget {
  const AuthBackButtonWidget({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    const color = AppColors.primaryMustard;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ?? () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(layout.radius(8)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: layout.spacing(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.chevron_left,
                  size: layout.fontSize(28),
                  color: color,
                ),
                AppText(
                  context.l10n.backButton,
                  variant: AppTextVariant.bodyEmphasis,
                  color: color,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
