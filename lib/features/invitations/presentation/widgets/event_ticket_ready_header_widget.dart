import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketReadyHeaderWidget extends StatelessWidget {
  const EventTicketReadyHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        Center(
          child: Container(
            width: InvitationsDesignSpec.px(context, 72),
            height: InvitationsDesignSpec.px(context, 72),
            decoration: const BoxDecoration(
              color: InvitationsDesignSpec.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: InvitationsDesignSpec.px(context, 40),
            ),
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        Text(
          AppStrings.eventTicketReadyTitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 20),
            fontWeight: FontWeight.w700,
            color: InvitationsDesignSpec.titleText,
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 8)),
        Text(
          AppStrings.eventTicketReadySubtitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 14),
            color: InvitationsDesignSpec.bodyText,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
