import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsFooterNoteWidget extends StatelessWidget {
  const InvitationsFooterNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final iconSize = InvitationsDesignSpec.px(context, 22);

    return Container(
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 10)),
      decoration: BoxDecoration(
        color: InvitationsScreenTheme.footerNoteBackground(context),
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, 10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: InvitationsScreenTheme.accent(context).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.info_outline,
              size: InvitationsDesignSpec.px(context, 14),
              color: InvitationsScreenTheme.accent(context),
            ),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 10)),
          Expanded(
            child: Text(
              AppStrings.invitationsFooterNote(strings),
              style: TextStyle(
                fontSize: InvitationsDesignSpec.px(context, 12),
                color: InvitationsScreenTheme.body(context),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
