import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/data/mappers/party_drink_order_mapper.dart';
import 'package:youpass/features/home/data/mappers/party_drink_purchases_mapper.dart';
import 'package:youpass/features/home/data/models/event_drink_order_response_model.dart';
import 'package:youpass/features/home/data/services/party_drinks_api_service.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_orders_list_mode.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_purchase_display_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_purchase_success_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_purchase_card_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_purchases_header_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_purchases_tabs_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_purchases_top_bar_widget.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/routes/app_routes.dart';

class PartyDrinkOrdersListScreen extends StatefulWidget {
  const PartyDrinkOrdersListScreen({
    super.key,
    required this.mode,
  });

  final PartyDrinkOrdersListMode mode;

  @override
  State<PartyDrinkOrdersListScreen> createState() =>
      _PartyDrinkOrdersListScreenState();
}

class _PartyDrinkOrdersListScreenState extends State<PartyDrinkOrdersListScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  String? errorMessage;
  List<EventDrinkOrderModel> orders = const [];
  PartyDrinkPurchasesTab selectedTab = PartyDrinkPurchasesTab.pending;
  bool isOpeningQr = false;

  bool get _isCourtesies => widget.mode == PartyDrinkOrdersListMode.courtesies;

  List<PartyDrinkPurchaseDisplayItem> get _items =>
      PartyDrinkPurchasesMapper.flattenOrders(orders);

  List<PartyDrinkPurchaseDisplayItem> get _visibleItems {
    final pending = selectedTab == PartyDrinkPurchasesTab.pending;
    return _items.where((item) => item.isRedeemed != pending).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await GetIt.I<PartyDrinksApiService>().fetchMyDrinkOrders(
        complimentary: _isCourtesies,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        orders = response.orders;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _openOrderQr(PartyDrinkPurchaseDisplayItem item) async {
    if (!item.canViewQr || isOpeningQr) {
      if (mounted && !item.canViewQr) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.partyDrinkPurchasesQrUnavailable),
          ),
        );
      }
      return;
    }

    setState(() => isOpeningQr = true);

    try {
      var confirmations = PartyDrinkOrderMapper.toConfirmations(item.order);

      if (confirmations.isEmpty &&
          (item.line.entryCode?.isNotEmpty ?? false)) {
        confirmations = [
          PartyDrinkOrderMapper.toConfirmationForLine(item.order, item.line),
        ];
      }

      if (confirmations.isEmpty) {
        final order = await GetIt.I<PartyDrinksApiService>().fetchDrinkOrder(
          item.order.orderId,
        );
        confirmations = PartyDrinkOrderMapper.toConfirmations(order);
      }

      if (!mounted) {
        return;
      }

      if (confirmations.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.partyDrinkPurchasesQrUnavailable),
          ),
        );
        return;
      }

      final initialIndex = confirmations.indexWhere(
        (confirmation) => confirmation.lineId == item.line.lineId,
      );

      await Navigator.of(context).pushNamed(
        AppRoutes.partyDrinkPurchaseSuccess,
        arguments: PartyDrinkPurchaseSuccessRouteArgs.fromConfirmations(
          confirmations,
          initialIndex: initialIndex >= 0 ? initialIndex : 0,
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isOpeningQr = false);
      }
    }
  }

  String _emptyMessage(BuildContext context) {
    final strings = context.l10n;
    if (_isCourtesies) {
      return selectedTab == PartyDrinkPurchasesTab.pending
          ? AppStrings.partyDrinkCourtesiesEmptyPending(strings)
          : AppStrings.partyDrinkCourtesiesEmptyUsed(strings);
    }
    return selectedTab == PartyDrinkPurchasesTab.pending
        ? AppStrings.partyDrinkPurchasesEmptyPending(strings)
        : AppStrings.partyDrinkPurchasesEmptyUsed(strings);
  }

  Widget _buildFixedHeader(BuildContext context) {
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PartyDrinkPurchasesTopBarWidget(
          onDrawerTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
        ),
        PartyDrinkPurchasesHeaderWidget(
          title: _isCourtesies
              ? AppStrings.partyDrinkCourtesiesTitle(strings)
              : AppStrings.partyDrinkPurchasesTitle(strings),
          subtitle: _isCourtesies
              ? AppStrings.partyDrinkCourtesiesSubtitle(strings)
              : AppStrings.partyDrinkPurchasesSubtitle(strings),
        ),
        PartyDrinkPurchasesTabsWidget(
          selectedTab: selectedTab,
          onTabSelected: (tab) => setState(() => selectedTab = tab),
        ),
      ],
    );
  }

  Widget _buildScrollableContent(double horizontalPadding) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: constraints.maxHeight * 0.35),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: constraints.maxHeight * 0.2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }

    final visibleItems = _visibleItems;

    if (visibleItems.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: constraints.maxHeight * 0.2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                _emptyMessage(context),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        PartyDrinksDesignSpec.px(context, 16),
        horizontalPadding,
        MediaQuery.paddingOf(context).bottom + PartyDrinksDesignSpec.px(context, 24),
      ),
      itemCount: visibleItems.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: PartyDrinksDesignSpec.px(context, 12)),
      itemBuilder: (context, index) {
        final item = visibleItems[index];
        return PartyDrinkPurchaseCardWidget(
          item: item,
          listMode: widget.mode,
          onViewQr: item.canViewQr && !isOpeningQr ? () => _openOrderQr(item) : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFixedHeader(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadOrders,
                child: _buildScrollableContent(horizontalPadding),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
