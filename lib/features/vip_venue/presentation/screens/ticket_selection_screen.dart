import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/shimmer/vip_ticket_selection_shimmer.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_section.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
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
  String? expandedOfferingId;
  bool _isLoadingPurchaseData = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPurchaseData());
  }

  Future<void> _loadPurchaseData() async {
    final provider = context.read<VipVenueProvider>();
    final eventId = session.event.id;

    if (eventId.isEmpty) {
      if (mounted) {
        setState(() => _isLoadingPurchaseData = false);
      }
      return;
    }

    _applyPurchaseMetaFromEventDetail();

    try {
      final bundle = await provider.loadTicketTypes(eventId);
      if (!mounted) {
        return;
      }

      if (bundle == null) {
        return;
      }

      setState(() {
        session.offerings = List<TicketOfferingEntity>.from(bundle.offerings);
        session.serviceFeeRate = bundle.serviceFeeRate;
        if (bundle.currency.isNotEmpty) {
          session.purchaseCurrency = bundle.currency;
        }
        session.currencyDecimals = bundle.currencyDecimals;
        session.hasVenueLayout = bundle.hasVenueLayout;
        session.hasTicketOfferings = bundle.offerings.isNotEmpty;
        session.tableLockMinutes = bundle.tableLockMinutes;
        _isLoadingPurchaseData = false;
      });

      if (bundle.hasVenueLayout) {
        unawaited(provider.loadVenueLayout(eventId));
      }
    } finally {
      if (mounted && _isLoadingPurchaseData) {
        setState(() => _isLoadingPurchaseData = false);
      }
    }
  }

  void _applyPurchaseMetaFromEventDetail() {
    if (session.event is! EventDetailEntity) {
      return;
    }

    final purchase = (session.event as EventDetailEntity).purchase;
    if (purchase == null) {
      return;
    }

    session.serviceFeeRate = purchase.serviceFeeRate;
    session.hasVenueLayout = purchase.hasVenueLayout;
    session.hasTicketOfferings = purchase.hasTicketOfferings;
    session.purchaseCurrency = purchase.currency;
  }

  List<TicketOfferingEntity> get _generalOfferings {
    final items = session.offerings
        .where((o) => o.section == TicketOfferingSection.general)
        .toList();
    items.sort(_compareOfferings);
    return items;
  }

  List<TicketOfferingEntity> get _vipGeneralOfferings {
    final items = session.offerings
        .where((o) => o.section == TicketOfferingSection.vip)
        .toList();
    items.sort(_compareOfferings);
    return items;
  }

  int _compareOfferings(TicketOfferingEntity a, TicketOfferingEntity b) {
    const order = {
      'early_bird': 1,
      'preventa_2': 2,
      'preventa_3': 3,
      'general': 4,
      'vip_general': 5,
    };
    final aOrder = order[a.type ?? a.id] ?? 999;
    final bOrder = order[b.type ?? b.id] ?? 999;
    if (aOrder != bOrder) {
      return aOrder.compareTo(bOrder);
    }
    return a.price.compareTo(b.price);
  }

  List<TicketOfferingEntity> get _quantityOfferings => session.offerings;

  bool get _hasSelectableQuantity =>
      _quantityOfferings.any((offering) => offering.isQuantitySelectable);

  bool get _showEmptyState =>
      _quantityOfferings.isEmpty && !session.hasVenueLayout;

  bool get _allTicketWavesSoldOut =>
      _quantityOfferings.isNotEmpty && !_hasSelectableQuantity;

  void onOfferingTap(TicketOfferingEntity offering) {
    if (!offering.isQuantitySelectable) {
      return;
    }

    setState(() {
      if (expandedOfferingId == offering.id) {
        expandedOfferingId = null;
        session.offerings = session.offerings
            .map((item) => item.copyWith(quantity: 0))
            .toList();
        return;
      }

      expandedOfferingId = offering.id;
      session.offerings = session.offerings
          .map(
            (item) => item.id == offering.id
                ? item.copyWith(quantity: 1)
                : item.copyWith(quantity: 0),
          )
          .toList();
    });
  }

  void updateOfferingQuantity(String offeringId, int quantity) {
    if (quantity < 1) {
      return;
    }

    setState(() {
      expandedOfferingId = offeringId;
      session.offerings = session.offerings
          .map(
            (item) => item.id == offeringId
                ? item.copyWith(quantity: quantity)
                : item.copyWith(quantity: 0),
          )
          .toList();
    });
  }

  void openPurchaseSummary() {
    if (!session.hasSelectedTickets) {
      return;
    }

    session.selectedZone = null;
    session.selectedTable = null;
    session.tableLockExpiresAt = null;
    session.tableLockId = null;

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
    final isLoading = _isLoadingPurchaseData;
    final showBottomBar = !isLoading && !_showEmptyState;

    return VipFlowScaffold(
      title: AppStrings.vipTicketSelectionHeading(strings),
      subtitle: session.event.title,
      bottomBar: showBottomBar
          ? TicketSelectionBottomBarWidget(
              session: session,
              onSummaryTap: openPurchaseSummary,
              onContinue: openPurchaseSummary,
              enabled: session.hasSelectedTickets,
            )
          : null,
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
                if (_showEmptyState)
                  _EmptyStateMessage(
                    message: AppStrings.vipTicketsNoneAvailable(strings),
                  )
                else ...[
                  if (_allTicketWavesSoldOut && !session.hasVenueLayout)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: VipVenueDesignSpec.px(context, 12),
                      ),
                      child: _EmptyStateMessage(
                        message: AppStrings.vipTicketsAllSoldOut(strings),
                      ),
                    ),
                  if (_generalOfferings.isNotEmpty) ...[
                    VipSectionCaptionWidget(
                      label: AppStrings.vipSectionGeneralTickets(strings),
                    ),
                    ..._generalOfferings.map(
                      (offering) => TicketOfferingRowWidget(
                        offering: offering,
                        isExpanded: expandedOfferingId == offering.id,
                        onTap: () => onOfferingTap(offering),
                        onQuantityChanged: (quantity) =>
                            updateOfferingQuantity(offering.id, quantity),
                        countryIsoCode: session.countryIsoCode,
                        currencyDecimals: session.currencyDecimals,
                      ),
                    ),
                  ],
                  if (_vipGeneralOfferings.isNotEmpty) ...[
                    SizedBox(height: VipVenueDesignSpec.px(context, 12)),
                    VipSectionCaptionWidget(
                      label: AppStrings.vipSectionVipTickets(strings),
                    ),
                    ..._vipGeneralOfferings.map(
                      (offering) => TicketOfferingRowWidget(
                        offering: offering,
                        isExpanded: expandedOfferingId == offering.id,
                        onTap: () => onOfferingTap(offering),
                        onQuantityChanged: (quantity) =>
                            updateOfferingQuantity(offering.id, quantity),
                        countryIsoCode: session.countryIsoCode,
                        currencyDecimals: session.currencyDecimals,
                      ),
                    ),
                  ],
                  if (session.hasVenueLayout) ...[
                    SizedBox(height: VipVenueDesignSpec.px(context, 12)),
                    VipSectionCaptionWidget(
                      label: AppStrings.vipSectionVipTables(strings),
                    ),
                    VipTablesEntryWidget(onTap: openFloorPlan),
                  ],
                ],
              ],
            ),
    );
  }
}

class _EmptyStateMessage extends StatelessWidget {
  const _EmptyStateMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: VipVenueDesignSpec.px(context, 32),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: VipVenueDesignSpec.px(context, 14),
          color: VipVenueScreenTheme.body(context),
        ),
      ),
    );
  }
}
