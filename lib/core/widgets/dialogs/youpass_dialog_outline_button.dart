import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class YouPassDialogOutlineButton extends StatelessWidget {
  const YouPassDialogOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 44,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: InvitationsDesignSpec.primary,
          side: const BorderSide(
            color: InvitationsDesignSpec.primary,
            width: 1.5,
          ),
          backgroundColor: YouPassDialogTheme.background(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
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
