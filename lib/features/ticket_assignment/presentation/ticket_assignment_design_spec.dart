import 'package:flutter/material.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class TicketAssignmentDesignSpec {
  TicketAssignmentDesignSpec._();

  static const Color fieldBorder = Color(0xFFE0E0E0);
  static const Color fieldFill = Color(0xFFFFFFFF);
  static const Color cancelButtonFill = Color(0xFFFFF0F0);

  static double cardRadius(BuildContext context) =>
      TicketsDesignSpec.px(context, 14);

  static double fieldRadius(BuildContext context) =>
      TicketsDesignSpec.px(context, 10);

  static double buttonRadius(BuildContext context) =>
      TicketsDesignSpec.px(context, 10);

  static double buttonHeight(BuildContext context) =>
      TicketsDesignSpec.px(context, 40);

  static double avatarSize(BuildContext context) =>
      TicketsDesignSpec.px(context, 44);

  static EdgeInsets fieldPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: TicketsDesignSpec.px(context, 12),
      vertical: TicketsDesignSpec.px(context, 10),
    );
  }
}
