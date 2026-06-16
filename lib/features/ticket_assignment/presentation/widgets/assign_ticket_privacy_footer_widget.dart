import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketPrivacyFooterWidget extends StatelessWidget {
  const AssignTicketPrivacyFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          size: TicketsDesignSpec.px(context, 16),
          color: TicketsScreenTheme.accent(context),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 8)),
        Flexible(
          child: Text(
            AppStrings.ticketAssignmentPrivacyNote(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 12),
              color: TicketsScreenTheme.body(context),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
