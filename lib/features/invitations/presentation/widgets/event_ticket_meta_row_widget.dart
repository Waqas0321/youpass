import 'package:flutter/material.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketMetaRowWidget extends StatelessWidget {
  const EventTicketMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final metaColor = QrScreenTheme.eventMeta(context);

    return Padding(
      padding: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: InvitationsDesignSpec.px(context, 14),
            color: metaColor,
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 6)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: InvitationsDesignSpec.px(context, 12),
                fontWeight: FontWeight.w400,
                color: metaColor,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
