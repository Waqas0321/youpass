import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_meta_row_widget.dart';

class PastEventCardWidget extends StatelessWidget {
  const PastEventCardWidget({
    super.key,
    required this.event,
    this.onFavoriteToggle,
  });

  final PastEventEntity event;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final imageHeight = TicketsDesignSpec.px(context, 140);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 16)),
      padding: EdgeInsets.all(TicketsDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: TicketsDesignSpec.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsDesignSpec.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              TicketsDesignSpec.px(context, TicketsDesignSpec.imageRadius),
            ),
            child: Stack(
              children: [
                AppAssetImage(
                  assetPath: event.imageAssetPath,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: TicketsDesignSpec.px(context, 10),
                  right: TicketsDesignSpec.px(context, 10),
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.92),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onFavoriteToggle,
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(
                          TicketsDesignSpec.px(context, 8),
                        ),
                        child: Icon(
                          event.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: TicketsDesignSpec.px(context, 20),
                          color: event.isFavorite
                              ? TicketsDesignSpec.favoriteActive
                              : TicketsDesignSpec.titleText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          Text(
            event.title,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 17),
              fontWeight: FontWeight.w700,
              color: TicketsDesignSpec.titleText,
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 8)),
          TicketMetaRowWidget(
            icon: Icons.location_on_outlined,
            label: event.locationLabel,
          ),
          TicketMetaRowWidget(
            icon: Icons.calendar_today_outlined,
            label: event.dateLabel,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: TicketsDesignSpec.px(context, 12),
            ),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: TicketsDesignSpec.divider,
            ),
          ),
          Text(
            AppStrings.ticketsStatistics(strings),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 11),
              fontWeight: FontWeight.w600,
              color: TicketsDesignSpec.bodyText,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 10)),
          Row(
            children: [
              Expanded(
                child: _StatColumn(
                  icon: Icons.schedule_outlined,
                  label: AppStrings.ticketsStatEntry(strings),
                  value: event.entryTime,
                ),
              ),
              Expanded(
                child: _StatColumn(
                  icon: Icons.local_bar_outlined,
                  label: AppStrings.ticketsStatConsumption(strings),
                  value: '${event.consumptionCount}',
                ),
              ),
              Expanded(
                child: _StatColumn(
                  icon: Icons.timer_outlined,
                  label: AppStrings.ticketsStatStay(strings),
                  value: event.stayDurationLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: TicketsDesignSpec.px(context, 18),
          color: TicketsDesignSpec.primary,
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 4)),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 10),
            color: TicketsDesignSpec.bodyText,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 2)),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 14),
            fontWeight: FontWeight.w700,
            color: TicketsDesignSpec.primary,
          ),
        ),
      ],
    );
  }
}
