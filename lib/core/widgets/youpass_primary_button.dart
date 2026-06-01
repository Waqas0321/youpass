import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class YouPassPrimaryButton extends StatelessWidget {
  const YouPassPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return SizedBox(
      width: double.infinity,
      height: layout.buttonHeight,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMustard,
          disabledBackgroundColor:
              AppColors.primaryMustard.withValues(alpha: 0.5),
          foregroundColor: AppColors.darkNavy,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius(12)),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: layout.spacing(22),
                width: layout.spacing(22),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.darkNavy,
                ),
              )
            : AppText(label, variant: AppTextVariant.button),
      ),
    );
  }
}
