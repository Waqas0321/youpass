import 'package:flutter/material.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class VipPurchaseScreenActions {
  const VipPurchaseScreenActions(this.context);

  final BuildContext context;

  void openTicketSelection({required EventEntity event}) {
    final session = VipPurchaseSession(event: event);

    if (event is EventDetailEntity) {
      final purchase = event.purchase;
      if (purchase != null) {
        session.serviceFeeRate = purchase.serviceFeeRate;
        session.hasVenueLayout = purchase.hasVenueLayout;
        session.hasTicketOfferings = purchase.hasTicketOfferings;
      }
    }

    Navigator.of(context).pushNamed(
      AppRoutes.vipTicketSelection,
      arguments: VipPurchaseRouteArgs(session: session),
    );
  }
}
