import 'package:flutter/material.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
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
    final iconSize = InvitationsDesignSpec.px(context, 40);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: InvitationsScreenTheme.sectionIconBackground(context),
            borderRadius: BorderRadius.circular(
              InvitationsDesignSpec.px(context, 10),
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.mail_rounded,
            size: InvitationsDesignSpec.px(context, 22),
            color: InvitationsScreenTheme.accent(context),
          ),
        ),
        SizedBox(width: InvitationsDesignSpec.px(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 18),
                  fontWeight: FontWeight.w800,
                  color: InvitationsScreenTheme.title(context),
                  letterSpacing: 0.4,
                  height: 1.2,
                ),
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 13),
                  color: InvitationsScreenTheme.body(context),
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
