import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class PastEventsAttendedHeaderWidget extends StatelessWidget {
  const PastEventsAttendedHeaderWidget({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: TicketsDesignSpec.px(context, 36),
          height: TicketsDesignSpec.px(context, 36),
          decoration: BoxDecoration(
            color: TicketsScreenTheme.sectionIconBackground(context),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.confirmation_number_outlined,
            size: TicketsDesignSpec.px(context, 18),
            color: TicketsScreenTheme.accent(context),
          ),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.ticketsAttendedSectionTitle(strings),
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 14),
                  fontWeight: FontWeight.w700,
                  color: TicketsScreenTheme.title(context),
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: TicketsDesignSpec.px(context, 4)),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 12),
                  color: TicketsScreenTheme.body(context),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
