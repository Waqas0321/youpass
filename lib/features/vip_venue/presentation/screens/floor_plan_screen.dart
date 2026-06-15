import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/shimmer/vip_floor_plan_shimmer.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_kind.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_availability_mapper.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_availability_poller.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/venue_floor_plan_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_floor_plan_hint_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_flow_scaffold.dart';
import 'package:youpass/routes/app_routes.dart';

class FloorPlanScreen extends StatefulWidget {
  const FloorPlanScreen({
    super.key,
    required this.args,
  });

  final VipPurchaseRouteArgs args;

  static Widget fromRouteArgs(VipPurchaseRouteArgs args) {
    return FloorPlanScreen(args: args);
  }

  @override
  State<FloorPlanScreen> createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {
  VenueFloorPlanEntity? floorPlan;
  late final VipVenueAvailabilityPoller _availabilityPoller;

  @override
  void initState() {
    super.initState();
    _availabilityPoller = VipVenueAvailabilityPoller(onPoll: _pollAvailability);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadFloorPlan());
  }

  @override
  void dispose() {
    _availabilityPoller.dispose();
    super.dispose();
  }

  Future<void> _loadFloorPlan() async {
    final layout = await context.read<VipVenueProvider>().loadVenueLayout(
          widget.args.session.event.id,
        );
    if (!mounted) {
      return;
    }
    setState(() => floorPlan = layout);
    if (layout != null) {
      _availabilityPoller.start();
    }
  }

  Future<void> _pollAvailability() async {
    final currentPlan = floorPlan;
    if (currentPlan == null || !mounted) {
      return;
    }

    final snapshot = await context.read<VipVenueProvider>().refreshTableAvailability(
          widget.args.session.event.id,
        );
    if (!mounted || snapshot == null) {
      return;
    }

    setState(() {
      floorPlan = VipVenueAvailabilityMapper.mergeFloorPlan(currentPlan, snapshot);
    });
  }

  void openZone(BuildContext context, VenueZoneEntity zone) {
    widget.args.session.selectedZone = zone;
    widget.args.session.selectedTable = null;
    widget.args.session.tableLockExpiresAt = null;

    Navigator.of(context).pushNamed(
      AppRoutes.vipTableSelection,
      arguments: VipPurchaseRouteArgs(session: widget.args.session),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<VipVenueProvider>();
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final plan = floorPlan;
    final isLoading =
        provider.venueLayoutStatus == VipVenueLoadStatus.loading && plan == null;

    if (isLoading) {
      return VipFlowScaffold(
        title: AppStrings.vipFloorPlanTitle(strings),
        body: const VipFloorPlanShimmer(),
      );
    }

    if (plan == null) {
      return VipFlowScaffold(
        title: AppStrings.vipFloorPlanTitle(strings),
        body: Center(
          child: Text(
            provider.errorMessage ?? AppStrings.errorGeneric(strings),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final subtitle = AppStrings.vipFloorPlanSubtitle(
      strings,
      plan.venueName,
      plan.dimensionsLabel.isNotEmpty
          ? plan.dimensionsLabel
          : AppStrings.vipFloorPlanSize(strings),
    );

    final selectableTableZones = plan.zones
        .where(
          (zone) =>
              zone.isSelectable &&
              zone.kind != VenueZoneKind.stage &&
              zone.kind != VenueZoneKind.danceFloor,
        )
        .toList();

    return VipFlowScaffold(
      title: AppStrings.vipFloorPlanTitle(strings),
      subtitle: subtitle,
      body: ListView(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        children: [
          VenueFloorPlanWidget(
            zones: plan.zones,
            onZoneTap: (zone) => openZone(context, zone),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 16)),
          const VenueMapLegendWidget(),
          if (selectableTableZones.isNotEmpty) ...[
            SizedBox(height: VipVenueDesignSpec.px(context, 20)),
            const VipFloorPlanHintCardWidget(),
          ],
        ],
      ),
    );
  }
}
