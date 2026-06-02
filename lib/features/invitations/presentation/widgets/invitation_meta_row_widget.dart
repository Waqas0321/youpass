import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationMetaRowWidget extends StatelessWidget {
  const InvitationMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: InvitationsDesignSpec.px(context, 14),
            color: InvitationsDesignSpec.metaIcon,
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 6)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: InvitationsDesignSpec.px(context, 12),
                color: InvitationsDesignSpec.bodyText,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
