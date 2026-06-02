import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsSectionHeaderWidget extends StatelessWidget {
  const InvitationsSectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.mail_outline,
          size: InvitationsDesignSpec.px(context, 22),
          color: InvitationsDesignSpec.primary,
        ),
        SizedBox(width: InvitationsDesignSpec.px(context, 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 18),
                  fontWeight: FontWeight.w700,
                  color: InvitationsDesignSpec.titleText,
                  height: 1.2,
                ),
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 13),
                  color: InvitationsDesignSpec.bodyText,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
