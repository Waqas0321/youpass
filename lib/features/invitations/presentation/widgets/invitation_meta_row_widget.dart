import 'package:flutter/material.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationMetaRowWidget extends StatelessWidget {
  const InvitationMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
    this.emphasize = false,
  });

  final IconData icon;
  final String label;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final textColor = emphasize
        ? InvitationsScreenTheme.accent(context)
        : InvitationsScreenTheme.body(context);
    final iconColor = emphasize
        ? InvitationsScreenTheme.accent(context)
        : textColor;

    return Padding(
      padding: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: InvitationsDesignSpec.px(context, 14),
            color: iconColor,
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 6)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: InvitationsDesignSpec.px(context, 12),
                fontWeight: emphasize ? FontWeight.w600 : FontWeight.w400,
                color: textColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
