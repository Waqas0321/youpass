import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class HomeNearMeButtonWidget extends StatelessWidget {
  const HomeNearMeButtonWidget({
    super.key,
    required this.isEnabled,
    required this.onPressed,
    this.isLoading = false,
  });

  final bool isEnabled;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Align(
      alignment: Alignment.centerLeft,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                width: layout.fontSize(16),
                height: layout.fontSize(16),
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                isEnabled ? Icons.near_me : Icons.near_me_outlined,
                size: layout.fontSize(16),
              ),
        label: Text(AppStrings.homeNearMeButton(l10n)),
        style: OutlinedButton.styleFrom(
          foregroundColor: isEnabled ? AppColors.primaryMustard : null,
          side: BorderSide(
            color: isEnabled
                ? AppColors.primaryMustard
                : Theme.of(context).dividerColor,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(14),
            vertical: layout.spacing(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius(12)),
          ),
        ),
      ),
    );
  }
}
