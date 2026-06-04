import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_event_image_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_meta_row_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_stat_column_widget.dart';

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
    final imageHeight = TicketsDesignSpec.px(context, 160);
    final contentPadding = TicketsDesignSpec.px(context, 16);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
        boxShadow: TicketsScreenTheme.cardShadow(context),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              TicketEventImageWidget(
                imagePath: event.imageAssetPath,
                width: double.infinity,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: TicketsDesignSpec.px(context, 12),
                right: TicketsDesignSpec.px(context, 12),
                child: Material(
                  color: TicketsScreenTheme.favoriteToggleBackground(context),
                  shape: const CircleBorder(),
                  elevation: TicketsScreenTheme.isDark(context) ? 0 : 2,
                  shadowColor: const Color(0x33000000),
                  child: InkWell(
                    onTap: onFavoriteToggle,
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                      width: TicketsDesignSpec.px(context, 36),
                      height: TicketsDesignSpec.px(context, 36),
                      child: Icon(
                        event.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: TicketsDesignSpec.px(context, 20),
                        color: event.isFavorite
                            ? TicketsScreenTheme.favoriteActive(context)
                            : TicketsScreenTheme.favoriteToggleIcon(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              contentPadding,
              contentPadding,
              contentPadding,
              TicketsDesignSpec.px(context, 14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: TicketsDesignSpec.px(context, 18),
                    fontWeight: FontWeight.w700,
                    color: TicketsScreenTheme.title(context),
                    height: 1.2,
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
                if (event.showStatistics) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      top: TicketsDesignSpec.px(context, 8),
                      bottom: TicketsDesignSpec.px(context, 10),
                    ),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: TicketsScreenTheme.divider(context),
                    ),
                  ),
                  Text(
                    AppStrings.ticketsStatistics(strings).toUpperCase(),
                    style: TextStyle(
                      fontSize: TicketsDesignSpec.px(context, 11),
                      fontWeight: FontWeight.w600,
                      color: TicketsScreenTheme.body(context),
                      letterSpacing: 0.8,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: TicketsDesignSpec.px(context, 12)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (event.entryTime != null)
                        Expanded(
                          child: TicketStatColumnWidget(
                            icon: Icons.schedule_outlined,
                            label: AppStrings.ticketsStatEntry(strings),
                            value: event.entryTime!,
                          ),
                        ),
                      if (event.consumptionCount != null)
                        Expanded(
                          child: TicketStatColumnWidget(
                            icon: Icons.local_bar_outlined,
                            label: AppStrings.ticketsStatConsumption(strings),
                            value: '${event.consumptionCount}',
                          ),
                        ),
                      if (event.stayDurationLabel != null)
                        Expanded(
                          child: TicketStatColumnWidget(
                            icon: Icons.timer_outlined,
                            label: AppStrings.ticketsStatStay(strings),
                            value: event.stayDurationLabel!,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
