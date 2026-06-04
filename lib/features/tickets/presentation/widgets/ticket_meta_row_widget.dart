import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class TicketMetaRowWidget extends StatelessWidget {
  const TicketMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textColor = YouPassThemedColors.secondaryText(context);

    return Padding(
      padding: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: TicketsDesignSpec.px(context, 14),
            color: textColor,
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 6)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: TicketsDesignSpec.px(context, 12),
                fontWeight: FontWeight.w400,
                color: textColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
