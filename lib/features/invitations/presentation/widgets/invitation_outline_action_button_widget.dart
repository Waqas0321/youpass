import 'package:flutter/material.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

enum InvitationOutlineButtonStyle {
  primary,
  reject,
  muted,
}

class InvitationOutlineActionButtonWidget extends StatelessWidget {
  const InvitationOutlineActionButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.style = InvitationOutlineButtonStyle.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final InvitationOutlineButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final isReject = style == InvitationOutlineButtonStyle.reject;
    final isMuted = style == InvitationOutlineButtonStyle.muted;
    final foregroundColor = isReject
        ? InvitationsDesignSpec.rejectButtonText
        : isMuted
            ? InvitationsScreenTheme.body(context)
            : InvitationsScreenTheme.accent(context);
    final borderColor = isReject
        ? InvitationsDesignSpec.rejectButtonBorder
        : isMuted
            ? InvitationsScreenTheme.cardBorder(context)
            : InvitationsScreenTheme.accent(context);

    return SizedBox(
      height: InvitationsDesignSpec.px(context, 38),
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: borderColor,
            width: 1.5,
          ),
          backgroundColor: InvitationsScreenTheme.outlineButtonFill(context),
          padding: EdgeInsets.symmetric(
            horizontal: InvitationsDesignSpec.px(context, 8),
          ),
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
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: InvitationsDesignSpec.px(context, 11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: foregroundColor,
                      ),
                    ),
                  ),
                  if (icon != null) ...[
                    SizedBox(width: InvitationsDesignSpec.px(context, 4)),
                    Icon(
                      icon,
                      size: InvitationsDesignSpec.px(context, 14),
                      color: foregroundColor,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
