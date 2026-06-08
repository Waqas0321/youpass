import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

class VipPrimaryButtonWidget extends StatelessWidget {
  const VipPrimaryButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.trailingIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final height = VipVenueDesignSpec.px(context, 52);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          disabledBackgroundColor: accent.withValues(alpha: 0.5),
          foregroundColor: VipVenueScreenTheme.primaryButtonForeground(context),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: VipVenueDesignSpec.px(context, 22),
                height: VipVenueDesignSpec.px(context, 22),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: VipVenueScreenTheme.primaryButtonForeground(context),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    label,
                    variant: AppTextVariant.button,
                    fontSize: VipVenueDesignSpec.px(context, 15),
                    fontWeight: FontWeight.w800,
                    color: VipVenueScreenTheme.primaryButtonForeground(context),
                  ),
                  if (trailingIcon != null) ...[
                    SizedBox(width: VipVenueDesignSpec.px(context, 8)),
                    Icon(
                      trailingIcon,
                      size: VipVenueDesignSpec.px(context, 18),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
