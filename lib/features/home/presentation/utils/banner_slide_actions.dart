import 'package:flutter/material.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/home/domain/entities/banner_tap_action_entity.dart';

class BannerSlideActions {
  BannerSlideActions(this.context);

  final BuildContext context;

  Future<void> handleTap(EventEntity event) async {
    final tapAction = event.tapAction;
    if (tapAction == null) {
      EventDetailScreenActions(context).openEventDetail(event: event);
      return;
    }

    switch (tapAction.type) {
      case BannerTapActionType.eventDetail:
        final eventId = tapAction.eventId ?? event.id;
        final targetEvent = eventId == event.id
            ? event
            : EventEntity(
                id: eventId,
                title: event.title,
                dateTimeLabel: event.dateTimeLabel,
                dateLabel: event.dateLabel,
                locationLabel: event.locationLabel,
                timeLabel: event.timeLabel,
                imageUrl: event.imageUrl,
                eventTypeSlug: event.eventTypeSlug,
                countryCode: event.countryCode,
                isFavorite: event.isFavorite,
                subtitle: event.subtitle,
                bannerId: event.bannerId,
                aspectRatio: event.aspectRatio,
                tapAction: tapAction,
              );
        EventDetailScreenActions(context).openEventDetail(event: targetEvent);
        return;
      case BannerTapActionType.externalUrl:
        final url = tapAction.url;
        if (url == null || url.isEmpty) {
          return;
        }
        await PaymentUrlLauncher.openExternalUrl(url);
        return;
      case BannerTapActionType.promoterPage:
      case BannerTapActionType.landingPage:
        _showUnsupportedActionMessage();
        return;
    }
  }

  void _showUnsupportedActionMessage() {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(
      const SnackBar(
        content: Text('This banner action is not available yet.'),
      ),
    );
  }
}
