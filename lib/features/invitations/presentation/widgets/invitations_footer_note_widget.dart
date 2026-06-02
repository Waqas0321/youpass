import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsFooterNoteWidget extends StatelessWidget {
  const InvitationsFooterNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          size: InvitationsDesignSpec.px(context, 16),
          color: InvitationsDesignSpec.metaIcon,
        ),
        SizedBox(width: InvitationsDesignSpec.px(context, 8)),
        Expanded(
          child: Text(
            AppStrings.invitationsFooterNote(strings),
            style: TextStyle(
              fontSize: InvitationsDesignSpec.px(context, 12),
              color: InvitationsDesignSpec.bodyText,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
