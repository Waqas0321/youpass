import 'package:flutter/material.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: layout.spacing(4),
            horizontal: layout.spacing(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                size: layout.fontSize(16),
                color: scheme.onSurface,
              ),
              SizedBox(width: layout.spacing(4)),
              AppText(
                context.l10n.backButton,
                variant: AppTextVariant.bodyEmphasis,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
