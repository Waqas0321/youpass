import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/data/mappers/party_drink_order_mapper.dart';
import 'package:youpass/features/home/data/mappers/party_drink_menu_mapper.dart';
import 'package:youpass/features/home/data/services/party_drinks_api_service.dart';
import 'package:youpass/features/home/presentation/party_drinks/data/party_drink_catalog.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_menu_category.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_menu_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_purchase_success_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_quantities.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_category_filter.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_card_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_category_chips_row_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_bar_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_summary_sheet.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_menu_header_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_recommendations_header_widget.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/home/presentation/utils/party_mode_navigation.dart';
import 'package:youpass/features/tickets/data/services/tickets_api_service.dart';
import 'package:youpass/routes/app_routes.dart';

class PartyDrinkMenuScreen extends StatefulWidget {
  const PartyDrinkMenuScreen({
    super.key,
    this.eventId,
    this.eventTitle,
  });

  final String? eventId;
  final String? eventTitle;

  static Widget fromRouteArgs(PartyDrinkMenuRouteArgs? args) {
    return PartyDrinkMenuScreen(
      eventId: args?.eventId,
      eventTitle: args?.eventTitle,
    );
  }

  @override
  State<PartyDrinkMenuScreen> createState() => _PartyDrinkMenuScreenState();
}

class _PartyDrinkMenuScreenState extends State<PartyDrinkMenuScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Set<String> selectedCategories = {PartyDrinkMenuCategory.allSlug};
  final Map<String, int> quantities = {};

  List<PartyDrinkMenuCategory> menuCategories = const [];
  List<PartyDrinkItem> drinks = const [];
  bool isLoading = true;
  String? loadError;
  String? eventTitle;
  String? eventId;

  PartyDrinkCartSummary get _cart =>
      PartyDrinkCartCalculator.summarize(quantities, drinks);

  List<PartyDrinkItem> get _visibleDrinks =>
      PartyDrinkCatalog.drinksForCategories(drinks, selectedCategories);

  List<PartyDrinkItem> get _recommendedDrinks =>
      PartyDrinkCatalog.recommendedDrinksForCategories(
        drinks,
        selectedCategories,
      );

  List<PartyDrinkItem> get _remainingDrinks =>
      _visibleDrinks.where((drink) => !drink.isRecommended).toList();

  List<PartyDrinkItem> get _gridDrinks {
    final recommended = _recommendedDrinks;
    final rest = _remainingDrinks;
    return [...recommended, ...rest];
  }

  bool get _showRecommendations => _recommendedDrinks.isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMenu();
    });
  }

  Future<void> _refreshMenu() async {
    final homeProvider = context.read<HomeProvider>();
    await homeProvider.refreshPartyModeEligibility();
    if (!mounted) {
      return;
    }
    await _loadMenu(showFullScreenLoader: false);
  }

  Future<void> _loadMenu({bool showFullScreenLoader = true}) async {
    if (showFullScreenLoader) {
      setState(() {
        isLoading = true;
        loadError = null;
      });
    } else {
      setState(() {
        loadError = null;
      });
    }

    try {
      final homeProvider = context.read<HomeProvider>();
      final resolved = await _resolveEventContext(homeProvider);
      if (!mounted) {
        return;
      }

      if (resolved == null) {
        setState(() {
          isLoading = false;
          menuCategories = const [];
          drinks = const [];
          eventTitle = null;
          eventId = null;
          loadError =
              'No event found. Enable Party Mode or use a ticket for an event with a drink menu.';
        });
        return;
      }

      final menu = await GetIt.I<PartyDrinksApiService>().fetchEventDrinkMenu(
        resolved.eventId,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        menuCategories = PartyDrinkMenuMapper.categories(menu);
        drinks = PartyDrinkMenuMapper.products(
          menu,
          eventId: resolved.eventId,
        );
        eventTitle = resolved.eventTitle ?? homeProvider.partyModeEventTitle;
        eventId = resolved.eventId;
        isLoading = false;
        loadError = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        isLoading = false;
        loadError = error.toString();
      });
    }
  }

  Future<_PartyDrinkEventContext?> _resolveEventContext(
    HomeProvider homeProvider,
  ) async {
    final routedEventId = widget.eventId?.trim();
    if (routedEventId != null && routedEventId.isNotEmpty) {
      return _PartyDrinkEventContext(
        eventId: routedEventId,
        eventTitle: widget.eventTitle ?? homeProvider.partyModeEventTitle,
      );
    }

    final partyEventId = homeProvider.partyModeEventId;
    if (partyEventId != null && partyEventId.isNotEmpty) {
      return _PartyDrinkEventContext(
        eventId: partyEventId,
        eventTitle: homeProvider.partyModeEventTitle,
      );
    }

    try {
      final response = await GetIt.I<TicketsApiService>().fetchUpcomingTickets(
        page: 1,
        limit: 1,
      );
      if (response.items.isEmpty) {
        return null;
      }

      final ticket = response.items.first;
      final eventId = ticket.eventId;
      if (eventId == null || eventId.isEmpty) {
        return null;
      }

      return _PartyDrinkEventContext(
        eventId: eventId,
        eventTitle: ticket.title,
      );
    } catch (_) {
      return null;
    }
  }

  void _increment(String drinkId) {
    setState(() => PartyDrinkCartQuantities.adjust(quantities, drinkId, 1));
  }

  void _decrement(String drinkId) {
    setState(() => PartyDrinkCartQuantities.adjust(quantities, drinkId, -1));
  }

  void _toggleCategory(String categorySlug) {
    setState(() {
      selectedCategories =
          PartyDrinkCategoryFilter.toggleCategory(selectedCategories, categorySlug);
    });
  }

  void _openCheckoutSummary() {
    PartyDrinkCheckoutSummarySheet.show(
      context: context,
      quantities: quantities,
      drinks: drinks,
      onQuantitiesChanged: (updated) {
        setState(() {
          quantities
            ..clear()
            ..addAll(updated);
        });
      },
      onPurchaseCompleted: _completePurchase,
    );
  }

  Future<void> _completePurchase(PartyDrinkCartSummary cart) async {
    final currentEventId = eventId;
    if (currentEventId == null || currentEventId.isEmpty) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not determine the event for this order.')),
      );
      throw StateError('Missing event id');
    }

    final api = GetIt.I<PartyDrinksApiService>();
    final confirmations = <PartyDrinkPurchaseConfirmation>[];
    final quantitiesByEvent = <String, Map<String, int>>{};

    for (final line in cart.lineItems) {
      final lineEventId = line.drink.eventId ?? currentEventId;
      if (lineEventId.isEmpty) {
        continue;
      }
      final bucket = quantitiesByEvent.putIfAbsent(lineEventId, () => {});
      bucket[line.drink.id] = line.quantity;
    }

    if (quantitiesByEvent.isEmpty) {
      quantitiesByEvent[currentEventId] = {
        for (final line in cart.lineItems) line.drink.id: line.quantity,
      };
    }

    try {
      for (final entry in quantitiesByEvent.entries) {
        final order = await api.createDrinkOrder(
          eventId: entry.key,
          quantities: entry.value,
        );
        confirmations.addAll(PartyDrinkOrderMapper.toConfirmations(order));
      }
      if (!mounted) {
        return;
      }
      if (confirmations.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not load QR codes for this order.'),
          ),
        );
        return;
      }

      final args = PartyDrinkPurchaseSuccessRouteArgs.fromConfirmations(
        confirmations,
      );

      setState(() => quantities.clear());

      await Navigator.of(context).pushNamed(
        AppRoutes.partyDrinkPurchaseSuccess,
        arguments: args,
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
      rethrow;
    }
  }

  Widget _drinkCard(PartyDrinkItem drink) {
    return PartyDrinkCardWidget(
      drink: drink,
      quantity: PartyDrinkCartQuantities.read(quantities, drink.id),
      onDecrement: () => _decrement(drink.id),
      onIncrement: () => _increment(drink.id),
    );
  }

  SliverPadding _drinkGridSliver({
    required List<PartyDrinkItem> items,
    required double horizontalPadding,
    required double gap,
    EdgeInsets? padding,
  }) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: gap,
          mainAxisSpacing: gap,
          childAspectRatio: PartyDrinksDesignSpec.gridChildAspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _drinkCard(items[index]),
          childCount: items.length,
        ),
      ),
    );
  }

  Widget _menuHeader() {
    final canChange =
        context.watch<HomeProvider>().partyModeEligibleEvents.length >= 2;
    return PartyDrinkMenuHeaderWidget(
      onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
      subtitle: eventTitle,
      onChangeEvent: canChange
          ? () => PartyModeNavigation.changeDrinkMenuEvent(context)
          : null,
    );
  }

  Widget _buildLoadingBody({
    required double horizontalPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _menuHeader(),
        const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _buildErrorBody({
    required double horizontalPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _menuHeader(),
        Expanded(
          child: RefreshIndicator(
            color: PartyDrinksDesignSpec.gold,
            onRefresh: _refreshMenu,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.22),
                Text(
                  loadError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Center(
                  child: OutlinedButton(
                    onPressed: _refreshMenu,
                    child: const Text('Retry'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyMenuBody({
    required double horizontalPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _menuHeader(),
        Expanded(
          child: RefreshIndicator(
            color: PartyDrinksDesignSpec.gold,
            onRefresh: _refreshMenu,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.28),
                Text(
                  context.l10n.partyDrinkMenuEmpty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody({
    required double gap,
    required double horizontalPadding,
    required double bottomInset,
  }) {
    if (isLoading) {
      return _buildLoadingBody(horizontalPadding: horizontalPadding);
    }

    if (loadError != null) {
      return _buildErrorBody(horizontalPadding: horizontalPadding);
    }

    if (drinks.isEmpty) {
      return _buildEmptyMenuBody(horizontalPadding: horizontalPadding);
    }

    return _buildMenuBody(
      gap: gap,
      horizontalPadding: horizontalPadding,
      bottomInset: bottomInset,
    );
  }

  Widget _buildMenuBody({
    required double gap,
    required double horizontalPadding,
    required double bottomInset,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _menuHeader(),
        PartyDrinkCategoryChipsRowWidget(
          categories: menuCategories,
          selectedCategories: selectedCategories,
          onCategoryToggled: _toggleCategory,
        ),
        SizedBox(height: PartyDrinksDesignSpec.px(context, 8)),
        Expanded(
          child: RefreshIndicator(
            color: PartyDrinksDesignSpec.gold,
            onRefresh: _refreshMenu,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                if (_showRecommendations)
                  const SliverToBoxAdapter(
                    child: PartyDrinkRecommendationsHeaderWidget(),
                  ),
                if (_gridDrinks.isNotEmpty)
                  _drinkGridSliver(
                    items: _gridDrinks,
                    horizontalPadding: horizontalPadding,
                    gap: gap,
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      PartyDrinksDesignSpec.px(context, 16),
                      horizontalPadding,
                      0,
                    ),
                  )
                else
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        context.l10n.partyDrinkMenuEmpty,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(child: SizedBox(height: bottomInset)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = PartyDrinksDesignSpec.px(context, PartyDrinksDesignSpec.gridGap);
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final cart = _cart;
    final checkoutBarHeight = PartyDrinksDesignSpec.px(context, 88);
    final bottomInset = cart.hasItems
        ? checkoutBarHeight + PartyDrinksDesignSpec.px(context, 24)
        : PartyDrinksDesignSpec.px(context, 24);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      body: Stack(
        children: [
          _buildBody(
            gap: gap,
            horizontalPadding: horizontalPadding,
            bottomInset: bottomInset,
          ),
          if (cart.hasItems)
            Positioned(
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: MediaQuery.paddingOf(context).bottom +
                  PartyDrinksDesignSpec.px(context, 12),
              child: PartyDrinkCheckoutBarWidget(
                cart: cart,
                onBuyTap: _openCheckoutSummary,
              ),
            ),
        ],
      ),
    );
  }
}

class _PartyDrinkEventContext {
  const _PartyDrinkEventContext({
    required this.eventId,
    this.eventTitle,
  });

  final String eventId;
  final String? eventTitle;
}
