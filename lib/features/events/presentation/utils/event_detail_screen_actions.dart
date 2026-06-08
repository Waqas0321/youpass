import 'package:flutter/material.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/presentation/routes/event_detail_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class EventDetailScreenActions {
  const EventDetailScreenActions(this.context);

  final BuildContext context;

  void openEventDetail({required EventEntity event}) {
    Navigator.of(context).pushNamed(
      AppRoutes.eventDetail,
      arguments: EventDetailRouteArgs(
        eventId: event.id,
        previewEvent: event,
      ),
    );
  }
}
