import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/shimmer/vip_ticket_selection_shimmer.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/ticket_offering_row_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/ticket_selection_bottom_bar_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_flow_scaffold.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_tables_entry_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class TicketSelectionScreen extends StatefulWidget {
  const TicketSelectionScreen({
    super.key,
    required this.args,
  });

  final VipPurchaseRouteArgs args;

  static Widget fromRouteArgs(VipPurchaseRouteArgs args) {
    return TicketSelectionScreen(args: args);
  }

  @override
  State<TicketSelectionScreen> createState() => _TicketSelectionScreenState();
}

class _TicketSelectionScreenState extends State<TicketSelectionScreen> {
  late final session = widget.args.session;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPurchaseData());
  }

  Future<void> _loadPurchaseData() async {
    final provider = context.read<VipVenueProvider>();
    final eventId = session.event.id;

    final bundle = await provider.loadTicketTypes(eventId);
    if (!mounted || bundle == null) {
      return;
    }

    setState(() {
      session.offerings = List<TicketOfferingEntity>.from(bundle.offerings);
      session.serviceFeeRate = bundle.serviceFeeRate;
    });

    final layout = await provider.loadVenueLayout(eventId);
    if (!mounted) {
      return;
    }

    setState(() {
      session.hasVenueLayout = layout != null;
    });
  }

  void updateOfferingQuantity(String offeringId, int quantity) {
    setState(() {
      final index = session.offerings.indexWhere((item) => item.id == offeringId);
      if (index == -1) {
        return;
      }
      session.offerings[index] =
          session.offerings[index].copyWith(quantity: quantity);
    });
  }

  void openPurchaseSummary() {
    if (!session.hasSelectedTickets) {
      return;
    }

    session.selectedZone = null;
    session.selectedTable = null;
    session.tableLockExpiresAt = null;

    Navigator.of(context).pushNamed(
      AppRoutes.vipPurchaseSummary,
      arguments: VipPurchaseRouteArgs(session: session),
    );
  }

  void openFloorPlan() {
    Navigator.of(context).pushNamed(
      AppRoutes.vipFloorPlan,
      arguments: VipPurchaseRouteArgs(session: session),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provider = context.watch<VipVenueProvider>();
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final isLoading = provider.ticketTypesStatus == VipVenueLoadStatus.loading &&
        session.offerings.isEmpty;
    final generalOfferings = session.offerings
        .where((offering) => offering.section == TicketOfferingSection.general)
        .toList();
    final vipOfferings = session.offerings
        .where((offering) => offering.section == TicketOfferingSection.vip)
        .toList();

    return VipFlowScaffold(
      title: AppStrings.vipTicketSelectionHeading(strings),
      subtitle: session.event.title,
      bottomBar: isLoading
          ? null
          : TicketSelectionBottomBarWidget(
              session: session,
              onSummaryTap: openPurchaseSummary,
              onContinue: openPurchaseSummary,
            ),
      body: isLoading
          ? const VipTicketSelectionShimmer()
          : ListView(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
              children: [
                if (provider.ticketTypesStatus == VipVenueLoadStatus.error)
                  Padding(
                    padding: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 12)),
                    child: Text(
                      provider.errorMessage ?? AppStrings.errorGeneric(strings),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: VipVenueDesignSpec.px(context, 13),
                      ),
                    ),
                  ),
                VipSectionCaptionWidget(
                  label: AppStrings.vipSectionGeneralTickets(strings),
                ),
                ...generalOfferings.map(
                  (offering) => TicketOfferingRowWidget(
                    offering: offering,
                    onQuantityChanged: (quantity) =>
                        updateOfferingQuantity(offering.id, quantity),
                  ),
                ),
                SizedBox(height: VipVenueDesignSpec.px(context, 8)),
                VipSectionCaptionWidget(
                  label: AppStrings.vipSectionVipTickets(strings),
                ),
                ...vipOfferings.map(
                  (offering) => TicketOfferingRowWidget(
                    offering: offering,
                    onQuantityChanged: (quantity) =>
                        updateOfferingQuantity(offering.id, quantity),
                  ),
                ),
                if (session.hasVenueLayout) ...[
                  SizedBox(height: VipVenueDesignSpec.px(context, 12)),
                  VipTablesEntryWidget(onTap: openFloorPlan),
                ],
              ],
            ),
    );
  }
}
