import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_action_button_widget.dart';
import 'package:youpass/features/favorites/domain/entities/producer_calendar_event_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class ProducerCalendarEventCardWidget extends StatelessWidget {
  const ProducerCalendarEventCardWidget({
    super.key,
    required this.event,
    required this.onBuyTicket,
    this.onEventTap,
  });

  final ProducerCalendarEventEntity event;
  final VoidCallback onBuyTicket;
  final VoidCallback? onEventTap;

  String _ctaLabel(BuildContext context) {
    final strings = context.l10n;
    switch (event.ticketCta) {
      case ProducerTicketCta.presale:
        return AppStrings.producerEventPresale(strings);
      case ProducerTicketCta.prepay:
        return AppStrings.producerEventPrepay(strings);
      case ProducerTicketCta.buy:
        return AppStrings.producerEventBuyTicket(strings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final imageHeight = FavoritesDesignSpec.px(context, 140);

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: theme.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: FavoritesDesignSpec.px(context, 10),
            offset: Offset(0, FavoritesDesignSpec.px(context, 2)),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEventTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: imageHeight,
                child: EventNetworkImage(
                  imageUrl: event.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(FavoritesDesignSpec.px(context, 12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: FavoritesDesignSpec.px(context, 15),
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                    FavoritesEventMetaRowWidget(
                      icon: Icons.calendar_today_outlined,
                      label: event.dateLabel,
                    ),
                    SizedBox(height: FavoritesDesignSpec.px(context, 4)),
                    FavoritesEventMetaRowWidget(
                      icon: Icons.location_on_outlined,
                      label: event.venueName ?? event.locationLabel,
                    ),
                    if (event.eventTypeName != null &&
                        event.eventTypeName!.isNotEmpty) ...[
                      SizedBox(height: FavoritesDesignSpec.px(context, 4)),
                      FavoritesEventMetaRowWidget(
                        icon: Icons.confirmation_number_outlined,
                        label: event.eventTypeName!,
                      ),
                    ],
                    if (event.followersPresaleActive &&
                        event.followersPresaleLabel != null) ...[
                      SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                      Text(
                        event.followersPresaleLabel!,
                        style: TextStyle(
                          fontSize: FavoritesDesignSpec.px(context, 12),
                          fontWeight: FontWeight.w600,
                          color: FavoritesDesignSpec.buyAccent,
                        ),
                      ),
                    ],
                    SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                    EventBrowseCardActionButtonWidget(
                      label: _ctaLabel(context),
                      onPressed: onBuyTicket,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
