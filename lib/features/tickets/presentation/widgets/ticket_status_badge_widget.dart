import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class TicketStatusBadgeWidget extends StatelessWidget {
  const TicketStatusBadgeWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: TicketsDesignSpec.px(context, 10),
        vertical: TicketsDesignSpec.px(context, 5),
      ),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.activeBadgeBackground(context),
        borderRadius: BorderRadius.circular(
          TicketsDesignSpec.px(context, TicketsDesignSpec.badgeRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: TicketsDesignSpec.px(context, 6),
            height: TicketsDesignSpec.px(context, 6),
            decoration: BoxDecoration(
              color: TicketsScreenTheme.activeBadgeText(context),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 6)),
          Text(
            label,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 11),
              fontWeight: FontWeight.w700,
              color: TicketsScreenTheme.activeBadgeText(context),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
