import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/shimmer/vip_table_selection_shimmer.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_availability_mapper.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_availability_poller.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_label_helper.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_flow_scaffold.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_table_detail_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_table_distribution_legend_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_table_distribution_map_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class TableSelectionScreen extends StatefulWidget {
  const TableSelectionScreen({
    super.key,
    required this.args,
  });

  final VipPurchaseRouteArgs args;

  static Widget fromRouteArgs(VipPurchaseRouteArgs args) {
    return TableSelectionScreen(args: args);
  }

  @override
  State<TableSelectionScreen> createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  List<VenueTableEntity> tables = const [];
  VenueTableEntity? selectedTable;
  late final VipVenueAvailabilityPoller _availabilityPoller;

  @override
  void initState() {
    super.initState();
    selectedTable = widget.args.session.selectedTable;
    _availabilityPoller = VipVenueAvailabilityPoller(onPoll: _pollAvailability);
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadTables());
  }

  @override
  void dispose() {
    _availabilityPoller.dispose();
    super.dispose();
  }

  Future<void> _loadTables() async {
    final zone = widget.args.session.selectedZone;
    if (zone == null) {
      return;
    }

    final bundle = await context.read<VipVenueProvider>().loadZoneTables(
          eventId: widget.args.session.event.id,
          zoneId: zone.id,
        );

    if (!mounted || bundle == null) {
      return;
    }

    setState(() {
      tables = bundle.tables;
      _syncSelectedTable();
    });
    _availabilityPoller.start();
  }

  void _syncSelectedTable() {
    final current = selectedTable;
    if (current == null) {
      return;
    }

    for (final table in tables) {
      if (table.id == current.id) {
        selectedTable = table.isSelectable ? table : null;
        widget.args.session.selectedTable = selectedTable;
        return;
      }
    }
    selectedTable = null;
    widget.args.session.selectedTable = null;
  }

  Future<void> _pollAvailability() async {
    final zone = widget.args.session.selectedZone;
    if (zone == null || tables.isEmpty || !mounted) {
      return;
    }

    final snapshot = await context.read<VipVenueProvider>().refreshTableAvailability(
          widget.args.session.event.id,
        );
    if (!mounted || snapshot == null) {
      return;
    }

    setState(() {
      tables = VipVenueAvailabilityMapper.mergeZoneTables(
        tables,
        zone.id,
        snapshot,
      );
      _syncSelectedTable();
    });
  }

  void selectTable(VenueTableEntity table) {
    if (table.status == VenueTableStatus.locked ||
        table.status == VenueTableStatus.reserved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.vipTableBlockedMessage(context.l10n)),
        ),
      );
      return;
    }

    if (!table.isSelectable) {
      return;
    }

    setState(() {
      selectedTable = table;
      widget.args.session.selectedTable = table;
    });
  }

  Future<void> reserveTable() async {
    final table = selectedTable;
    final zone = widget.args.session.selectedZone;
    if (table == null || zone == null) {
      return;
    }

    widget.args.session.selectedTable = table;
    widget.args.session.tableLockExpiresAt = null;
    widget.args.session.tableLockId = null;

    await Navigator.of(context).pushNamed(
      AppRoutes.vipPurchaseSummary,
      arguments: VipPurchaseRouteArgs(session: widget.args.session),
    );

    if (!mounted) {
      return;
    }

    await _loadTables();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final zone = widget.args.session.selectedZone;
    final provider = context.watch<VipVenueProvider>();
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);

    if (zone == null) {
      return VipFlowScaffold(
        title: AppStrings.vipTablesZoneTitle(strings),
        body: const SizedBox.shrink(),
      );
    }

    final activeTable = selectedTable;
    final isLoading =
        provider.zoneTablesStatus == VipVenueLoadStatus.loading && tables.isEmpty;
    final allSoldOut = tables.isNotEmpty && tables.every((table) => !table.isSelectable);

    return VipFlowScaffold(
      headerStyle: VipFlowHeaderStyle.branded,
      title: VipVenueLabelHelper.zoneScreenTitle(strings, zone),
      subtitle: VipVenueLabelHelper.tablesCapacitySubtitle(strings, zone),
      bottomBar: activeTable == null
          ? null
          : Padding(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
              child: VipFlowBottomActionRowWidget(
                backLabel: AppStrings.vipBackButton(strings),
                onBack: () => Navigator.of(context).pop(),
                primaryLabel: VipVenueLabelHelper.tableReserveLabel(
                  strings,
                  activeTable.label,
                ),
                onPrimary: reserveTable,
                primaryEnabled: true,
                primaryLoading: false,
              ),
            ),
      body: isLoading
          ? const VipTableSelectionShimmer()
          : allSoldOut
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Text(
                      AppStrings.vipTablesZoneSoldOut(strings),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: VipVenueDesignSpec.px(context, 15),
                        color: VipVenueScreenTheme.body(context),
                      ),
                    ),
                  ),
                )
              : ListView(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
              children: [
                if (provider.zoneTablesStatus == VipVenueLoadStatus.error)
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
                VipTableDistributionMapWidget(
                  zoneName: zone.name,
                  tables: tables,
                  selectedTableId: selectedTable?.id,
                  onTableTap: selectTable,
                ),
                SizedBox(height: VipVenueDesignSpec.px(context, 14)),
                const VipTableDistributionLegendWidget(),
                if (activeTable != null) ...[
                  SizedBox(height: VipVenueDesignSpec.px(context, 16)),
                  VipTableDetailCardWidget(
                    table: activeTable,
                    zone: zone,
                    currencyCode: widget.args.session.currency,
                    countryIsoCode: widget.args.session.countryIsoCode,
                  ),
                ],
              ],
            ),
    );
  }
}
