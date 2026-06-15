import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_list_shimmer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/events/domain/usecases/get_all_events_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/events/presentation/routes/all_events_route_args.dart';
import 'package:youpass/features/events/presentation/utils/event_browse_favorite_helper.dart';
import 'package:youpass/features/events/presentation/utils/event_browse_filter_helper.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_list_content.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({
    super.key,
    this.args = const AllEventsRouteArgs(),
  });

  final AllEventsRouteArgs args;

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  late final GetAllEventsUseCase getAllEventsUseCase;
  late final events_usecases.ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
  late final EventsRepository eventsRepository;

  List<EventCategoryEntity> categories = [];
  List<EventEntity> allEvents = [];
  List<EventEntity> visibleEvents = [];
  String selectedCategoryId = '';
  String searchQuery = '';
  bool isInitialLoading = true;
  bool isListLoading = false;
  String? errorMessage;
  final Set<String> favoritePendingIds = {};

  @override
  void initState() {
    super.initState();
    eventsRepository = sl<EventsRepository>();
    getAllEventsUseCase = sl<GetAllEventsUseCase>();
    toggleEventFavoriteUseCase = sl<events_usecases.ToggleEventFavoriteUseCase>();
    selectedCategoryId = widget.args.initialCategoryId ?? '';
    loadEvents();
  }

  Future<void> loadEvents({bool listOnly = false}) async {
    setState(() {
      if (listOnly) {
        isListLoading = true;
      } else {
        isInitialLoading = true;
      }
      errorMessage = null;
    });

    try {
      final loadedCategories = await eventsRepository.fetchBrowseCategories();
      final category = EventBrowseFilterHelper.findCategory(
        loadedCategories,
        selectedCategoryId,
      );
      final events = await getAllEventsUseCase(category: category);

      if (!mounted) {
        return;
      }

      setState(() {
        categories = loadedCategories;
        if (selectedCategoryId.isEmpty ||
            EventBrowseFilterHelper.findCategory(
                  loadedCategories,
                  selectedCategoryId,
                ) ==
                null) {
          selectedCategoryId =
              loadedCategories.isNotEmpty ? loadedCategories.first.id : '';
        }
        allEvents = events;
        isInitialLoading = false;
        isListLoading = false;
        applyFilters();
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInitialLoading = false;
        isListLoading = false;
        errorMessage = AppMessageLocalizer.fromError(context.l10n, error);
      });
    }
  }

  void applyFilters() {
    visibleEvents = EventBrowseFilterHelper.filter(
      events: allEvents,
      searchQuery: searchQuery,
      selectedCategoryId: selectedCategoryId,
      categories: categories,
    );
  }

  Future<void> selectCategory(String categoryId) async {
    if (selectedCategoryId == categoryId) {
      return;
    }

    setState(() => selectedCategoryId = categoryId);
    await loadEvents(listOnly: true);
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      applyFilters();
    });
  }

  Future<void> toggleFavorite(String eventId) async {
    final index = allEvents.indexWhere((event) => event.id == eventId);
    if (index == -1 || favoritePendingIds.contains(eventId)) {
      return;
    }

    final current = allEvents[index];
    final nextFavorite = !current.isFavorite;
    favoritePendingIds.add(eventId);

    setState(() {
      allEvents =
          EventBrowseFavoriteHelper.replaceFavorite(allEvents, eventId, nextFavorite);
      applyFilters();
    });

    try {
      await toggleEventFavoriteUseCase(
        eventId: eventId,
        isFavorite: current.isFavorite,
      );
    } catch (_) {
      setState(() {
        allEvents = EventBrowseFavoriteHelper.replaceFavorite(
          allEvents,
          eventId,
          current.isFavorite,
        );
        applyFilters();
      });
    } finally {
      favoritePendingIds.remove(eventId);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: FavoritesDesignSpec.primary,
      ),
      body: isInitialLoading
          ? const EventBrowseListShimmer()
          : errorMessage != null && categories.isEmpty
              ? Center(
                  child: AppText(
                    errorMessage!,
                    variant: AppTextVariant.error,
                  ),
                )
              : EventBrowseListContent(
                  headerTitle: AppStrings.allEventsTitle(strings),
                  headerSubtitle: AppStrings.allEventsSubtitle(strings),
                  headerIcon: Icons.event_note_outlined,
                  headerIconColor: FavoritesDesignSpec.primary,
                  searchHint: AppStrings.allEventsSearchHint(strings),
                  onSearchChanged: updateSearch,
                  categories: categories,
                  selectedCategoryId: selectedCategoryId,
                  onCategorySelected: selectCategory,
                  visibleEvents: visibleEvents,
                  isListLoading: isListLoading,
                  emptyMessage: AppStrings.homeNoEventsFound(strings),
                  footerIcon: Icons.event_note_outlined,
                  footerIconColor: FavoritesDesignSpec.buyAccent,
                  footerText: AppStrings.allEventsAvailableCount(
                    strings,
                    visibleEvents.length,
                  ),
                  onFavoriteTap: toggleFavorite,
                  favoritePendingIds: favoritePendingIds,
                  onEventTap: (event) =>
                      EventDetailScreenActions(context).openEventDetail(
                    event: event,
                  ),
                  onBuyTicket: (event) =>
                      VipPurchaseScreenActions(context).openTicketSelection(
                    event: event,
                  ),
                ),
    );
  }
}
