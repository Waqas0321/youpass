import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_slot_filter.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketSummaryHeaderWidget extends StatelessWidget {
  const AssignTicketSummaryHeaderWidget({
    super.key,
    required this.assignments,
  });

  final TicketOrderAssignmentsEntity assignments;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final claimedCount = assignments.claimedCount > 0
        ? assignments.claimedCount
        : TicketAssignmentSlotFilter.claimedCount(assignments);

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
        if (assignments.availableCount > 0)
          Text(
            AppStrings.ticketAssignmentAvailableCount(
              strings,
              assignments.availableCount,
            ),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 14),
              color: TicketsScreenTheme.body(context),
              height: 1.35,
            ),
          ),
        if (assignments.pendingCount > 0) ...[
          SizedBox(height: TicketsDesignSpec.px(context, 4)),
          Text(
            AppStrings.ticketAssignmentPendingCount(
              strings,
              assignments.pendingCount,
            ),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 14),
              color: TicketsScreenTheme.body(context),
              height: 1.35,
            ),
          ),
        ],
        if (claimedCount > 0) ...[
          SizedBox(height: TicketsDesignSpec.px(context, 4)),
          Text(
            AppStrings.ticketAssignmentClaimedCount(strings, claimedCount),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 14),
              color: TicketsScreenTheme.body(context),
              height: 1.35,
            ),
          ),
        ],
      ],
    );
  }
}
