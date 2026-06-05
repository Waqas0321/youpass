import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketWhatsAppInfoWidget extends StatelessWidget {
  const AssignTicketWhatsAppInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, 12);

    return Container(
      padding: EdgeInsets.all(TicketsDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: AppColors.whatsAppGreen.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: AppColors.whatsAppGreen.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: AppColors.whatsAppGreen,
            size: TicketsDesignSpec.px(context, 22),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 10)),
          Expanded(
            child: Text(
              AppStrings.ticketAssignmentWhatsAppInfo(strings),
              style: TextStyle(
                fontSize: TicketsDesignSpec.px(context, 13),
                color: TicketsScreenTheme.body(context),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
