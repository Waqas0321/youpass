import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';

/// Primary action button for themed YouPass dialogs.
class YouPassDialogPrimaryButton extends StatelessWidget {
  const YouPassDialogPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.height = 44,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isInteractive = enabled && !isLoading && onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isInteractive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: YouPassDialogTheme.primaryButtonBackground(context),
          disabledBackgroundColor:
              YouPassDialogTheme.primaryButtonBackground(context)
                  .withValues(alpha: 0.35),
          foregroundColor: YouPassDialogTheme.primaryButtonForeground(context),
          disabledForegroundColor:
              YouPassDialogTheme.primaryButtonForeground(context)
                  .withValues(alpha: 0.55),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: YouPassDialogTheme.primaryButtonForeground(context),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
      ),
    );
  }
}
