import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_meta_row_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_status_badge_widget.dart';

class UpcomingTicketCardWidget extends StatelessWidget {
  const UpcomingTicketCardWidget({
    super.key,
    required this.ticket,
    this.onViewQr,
    this.onAssignTickets,
  });

  final UpcomingTicketEntity ticket;
  final VoidCallback? onViewQr;
  final VoidCallback? onAssignTickets;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final imageHeight = TicketsDesignSpec.px(context, 160);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsDesignSpec.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: TicketsDesignSpec.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radius),
            ),
            child: Stack(
              children: [
                AppAssetImage(
                  assetPath: ticket.imageAssetPath,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
                if (ticket.isActive)
                  Positioned(
                    left: TicketsDesignSpec.px(context, 12),
                    top: TicketsDesignSpec.px(context, 12),
                    child: TicketStatusBadgeWidget(
                      label: AppStrings.ticketsStatusActive(strings),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(TicketsDesignSpec.px(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.title,
                  style: TextStyle(
                    fontSize: TicketsDesignSpec.px(context, 17),
                    fontWeight: FontWeight.w700,
                    color: TicketsDesignSpec.titleText,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 10)),
                TicketMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: ticket.dateLabel,
                ),
                TicketMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: ticket.locationLabel,
                ),
                TicketMetaRowWidget(
                  icon: Icons.confirmation_number_outlined,
                  label: ticket.ticketTypeLabel,
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 12)),
                _TicketFilledButton(
                  label: AppStrings.ticketsViewQr(strings),
                  icon: Icons.visibility_outlined,
                  backgroundColor: TicketsDesignSpec.primary,
                  foregroundColor: Colors.white,
                  onPressed: onViewQr,
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 10)),
                if (ticket.tier == TicketTier.vip)
                  _TicketFilledButton(
                    label: AppStrings.ticketsAssignVip(strings),
                    icon: Icons.confirmation_number_outlined,
                    backgroundColor: TicketsDesignSpec.vipButton,
                    foregroundColor: Colors.white,
                    onPressed: onAssignTickets,
                  )
                else
                  _TicketOutlineButton(
                    label: AppStrings.ticketsAssignEntries(strings),
                    icon: Icons.people_outline,
                    onPressed: onAssignTickets,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketFilledButton extends StatelessWidget {
  const _TicketFilledButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final height = TicketsDesignSpec.px(context, 44);
    final radius = TicketsDesignSpec.px(context, 10);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: TicketsDesignSpec.px(context, 18)),
            SizedBox(width: TicketsDesignSpec.px(context, 8)),
            Text(
              label,
              style: TextStyle(
                fontSize: TicketsDesignSpec.px(context, 13),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketOutlineButton extends StatelessWidget {
  const _TicketOutlineButton({
    required this.label,
    required this.icon,
    this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final height = TicketsDesignSpec.px(context, 44);
    final radius = TicketsDesignSpec.px(context, 10);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: TicketsDesignSpec.primary,
          side: const BorderSide(color: TicketsDesignSpec.primary, width: 1.5),
          backgroundColor: const Color(0xFFFFFBF0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: TicketsDesignSpec.px(context, 18)),
            SizedBox(width: TicketsDesignSpec.px(context, 8)),
            Text(
              label,
              style: TextStyle(
                fontSize: TicketsDesignSpec.px(context, 13),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
