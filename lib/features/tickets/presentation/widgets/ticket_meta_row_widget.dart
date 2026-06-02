import 'package:flutter/material.dart';
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
    return Padding(
      padding: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: TicketsDesignSpec.px(context, 16),
            color: TicketsDesignSpec.metaIcon,
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 8)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: TicketsDesignSpec.px(context, 13),
                fontWeight: FontWeight.w400,
                color: TicketsDesignSpec.bodyText,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
