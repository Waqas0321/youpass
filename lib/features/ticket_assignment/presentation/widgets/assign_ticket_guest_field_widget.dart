import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketGuestFieldWidget extends StatelessWidget {
  const AssignTicketGuestFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.borderColor,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final radius = TicketAssignmentDesignSpec.fieldRadius(context);
    final resolvedBorderColor =
        borderColor ?? TicketAssignmentDesignSpec.fieldBorder;

    OutlineInputBorder fieldBorder({double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: resolvedBorderColor, width: width),
      );
    }

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: TicketsDesignSpec.px(context, 14),
        fontWeight: FontWeight.w500,
        color: TicketsScreenTheme.title(context),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: TicketsDesignSpec.px(context, 14),
          fontWeight: FontWeight.w400,
          color: TicketsScreenTheme.body(context),
        ),
        filled: true,
        fillColor: TicketAssignmentDesignSpec.fieldFill,
        contentPadding: TicketAssignmentDesignSpec.fieldPadding(context),
        border: fieldBorder(),
        enabledBorder: fieldBorder(),
        focusedBorder: fieldBorder(width: 1.2),
      ),
    );
  }
}
