import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/presentation/utils/event_browse_card_label_formatter.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_action_button_widget.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class EventDetailContentWidget extends StatelessWidget {
  const EventDetailContentWidget({
    super.key,
    required this.event,
  });

  final EventDetailEntity event;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);
    final scheduleLabel = EventBrowseCardLabelFormatter.scheduleLabel(event);
    final venueLabel = _venueLabel(event);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: FavoritesDesignSpec.px(context, 240),
          width: double.infinity,
          child: EventNetworkImage(
            imageUrl: event.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            FavoritesDesignSpec.px(context, 20),
            horizontalPadding,
            FavoritesDesignSpec.px(context, 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                event.title.toUpperCase(),
                style: TextStyle(
                  fontSize: FavoritesDesignSpec.px(context, 20),
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.2,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: FavoritesDesignSpec.px(context, 14)),
              FavoritesEventMetaRowWidget(
                icon: Icons.calendar_today_outlined,
                label: scheduleLabel,
                iconColor: FavoritesDesignSpec.primary,
                labelColor: Theme.of(context).colorScheme.onSurface,
                fontSize: 13,
              ),
              FavoritesEventMetaRowWidget(
                icon: Icons.location_on_outlined,
                label: venueLabel,
                iconColor: FavoritesDesignSpec.primary,
                labelColor: Theme.of(context).colorScheme.onSurface,
                fontSize: 13,
              ),
              if (event.description != null &&
                  event.description!.trim().isNotEmpty) ...[
                SizedBox(height: FavoritesDesignSpec.px(context, 18)),
                Text(
                  AppStrings.eventDetailAboutSection(strings),
                  style: TextStyle(
                    fontSize: FavoritesDesignSpec.px(context, 13),
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                Text(
                  event.description!.trim(),
                  style: TextStyle(
                    fontSize: FavoritesDesignSpec.px(context, 13),
                    color: FavoritesDesignSpec.bodyText,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _venueLabel(EventDetailEntity event) {
    final venue = event.venueName?.trim();
    final city = event.city?.trim();
    if (venue != null && venue.isNotEmpty) {
      if (city != null && city.isNotEmpty) {
        return '$venue, $city';
      }
      return venue;
    }
    return event.locationLabel;
  }
}

class EventDetailBottomBarWidget extends StatelessWidget {
  const EventDetailBottomBarWidget({
    super.key,
    required this.canBuyTickets,
    required this.onBuyTickets,
  });

  final bool canBuyTickets;
  final VoidCallback? onBuyTickets;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return SafeArea(
      minimum: EdgeInsets.fromLTRB(
        horizontalPadding,
        FavoritesDesignSpec.px(context, 8),
        horizontalPadding,
        FavoritesDesignSpec.px(context, 16),
      ),
      child: canBuyTickets
          ? EventBrowseCardActionButtonWidget(
              label: AppStrings.buyTickets(strings).toUpperCase(),
              onPressed: onBuyTickets,
            )
          : Text(
              AppStrings.eventDetailTicketsUnavailable(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 13),
                color: FavoritesDesignSpec.bodyText,
              ),
            ),
    );
  }
}
