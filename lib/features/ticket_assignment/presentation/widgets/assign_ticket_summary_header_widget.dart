import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketSummaryHeaderWidget extends StatelessWidget {
  const AssignTicketSummaryHeaderWidget({
    super.key,
    required this.assignments,
    this.visibleSlotCount,
  });

  final TicketOrderAssignmentsEntity assignments;
  final int? visibleSlotCount;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final availableCount = visibleSlotCount ?? assignments.availableCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.ticketAssignmentHeading(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 22),
            fontWeight: FontWeight.w800,
            color: TicketsScreenTheme.title(context),
            height: 1.2,
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 8)),
        Text(
          assignments.canAssignInParts
              ? AppStrings.ticketAssignmentSummarySubtitle(
                  strings,
                  availableCount,
                )
              : AppStrings.ticketAssignmentAvailableCount(
                  strings,
                  availableCount,
                ),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 14),
            color: TicketsScreenTheme.body(context),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
