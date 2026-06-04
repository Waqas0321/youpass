import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationOutlineActionButtonWidget extends StatelessWidget {
  const InvitationOutlineActionButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: InvitationsDesignSpec.px(context, 38),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: InvitationsDesignSpec.primary,
          side: const BorderSide(
            color: InvitationsDesignSpec.primary,
            width: 1.5,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: InvitationsDesignSpec.px(context, 8),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              InvitationsDesignSpec.px(context, 10),
            ),
          ),
        ),
        child: Row(
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
                ),
              ),
            ),
            if (icon != null) ...[
              SizedBox(width: InvitationsDesignSpec.px(context, 4)),
              Icon(
                icon,
                size: InvitationsDesignSpec.px(context, 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
