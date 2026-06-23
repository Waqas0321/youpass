import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketSectionTitleWidget extends StatelessWidget {
  const AssignTicketSectionTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: TicketsDesignSpec.px(context, 10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: TicketsDesignSpec.px(context, 16),
          fontWeight: FontWeight.w700,
          color: TicketsScreenTheme.title(context),
        ),
      ),
    );
  }
}

class AssignTicketSendNewSectionHeader extends StatelessWidget {
  const AssignTicketSendNewSectionHeader({
    super.key,
    required this.availableCount,
  });

  final int availableCount;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssignTicketSectionTitleWidget(
          title: AppStrings.ticketAssignmentSendNewSectionTitle(strings),
        ),
        Text(
          AppStrings.ticketAssignmentSendNewSectionSubtitle(
            strings,
            availableCount,
          ),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 13),
            color: TicketsScreenTheme.body(context),
            height: 1.35,
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 12)),
      ],
    );
  }
}
