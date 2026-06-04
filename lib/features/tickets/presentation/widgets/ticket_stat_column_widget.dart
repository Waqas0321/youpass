import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class TicketStatColumnWidget extends StatelessWidget {
  const TicketStatColumnWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: TicketsDesignSpec.px(context, 20),
          color: TicketsScreenTheme.accent(context),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 11),
                  color: TicketsScreenTheme.body(context),
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
              SizedBox(height: TicketsDesignSpec.px(context, 2)),
              Text(
                value,
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 15),
                  fontWeight: FontWeight.w700,
                  color: TicketsScreenTheme.title(context),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
