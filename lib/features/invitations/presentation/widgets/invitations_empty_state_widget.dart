import 'package:flutter/material.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsEmptyStateWidget extends StatelessWidget {
  const InvitationsEmptyStateWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: InvitationsDesignSpec.px(context, 16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: InvitationsDesignSpec.px(context, 72),
            height: InvitationsDesignSpec.px(context, 72),
            decoration: BoxDecoration(
              color: InvitationsDesignSpec.envelopeIconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              size: InvitationsDesignSpec.px(context, 34),
              color: InvitationsScreenTheme.accent(context).withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 16)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: InvitationsDesignSpec.px(context, 14),
              color: InvitationsScreenTheme.body(context),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
