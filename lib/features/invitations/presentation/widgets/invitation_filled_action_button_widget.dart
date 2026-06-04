import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationFilledActionButtonWidget extends StatelessWidget {
  const InvitationFilledActionButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor = InvitationsDesignSpec.primary,
    this.enabled = true,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = enabled
        ? backgroundColor
        : InvitationsDesignSpec.attendanceConfirmedButton;

    return SizedBox(
      width: double.infinity,
      height: InvitationsDesignSpec.px(context, 38),
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveColor,
          disabledBackgroundColor: InvitationsDesignSpec.attendanceConfirmedButton,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              InvitationsDesignSpec.px(context, 10),
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: InvitationsDesignSpec.px(context, 18),
                height: InvitationsDesignSpec.px(context, 18),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 11),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }
}
