import 'package:flutter/material.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketPendingBadgeWidget extends StatelessWidget {
  const AssignTicketPendingBadgeWidget({
    super.key,
    required this.label,
    required this.accentColor,
  });

  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: TicketsDesignSpec.px(context, 10),
        vertical: TicketsDesignSpec.px(context, 4),
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(
          TicketAssignmentDesignSpec.buttonRadius(context),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: TicketsDesignSpec.px(context, 11),
          fontWeight: FontWeight.w700,
          color: accentColor,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
