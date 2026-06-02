import 'package:flutter/material.dart';
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
        color: TicketsDesignSpec.activeBadgeBackground,
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
            decoration: const BoxDecoration(
              color: TicketsDesignSpec.activeBadgeText,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 6)),
          Text(
            label,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 11),
              fontWeight: FontWeight.w700,
              color: TicketsDesignSpec.activeBadgeText,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
