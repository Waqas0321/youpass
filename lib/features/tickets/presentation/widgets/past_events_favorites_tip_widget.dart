import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class PastEventsFavoritesTipWidget extends StatelessWidget {
  const PastEventsFavoritesTipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.favorite,
          size: TicketsDesignSpec.px(context, 16),
          color: TicketsScreenTheme.favoriteActive(context),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 8)),
        Expanded(
          child: Text(
            AppStrings.ticketsFavoritesTip(strings),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 12),
              color: TicketsScreenTheme.body(context),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
