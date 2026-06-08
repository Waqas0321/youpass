import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_list_shimmer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/events/domain/usecases/get_favorite_events_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/events/presentation/utils/event_browse_filter_helper.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_list_content.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  late final EventsRepository eventsRepository;
  late final GetFavoriteEventsUseCase getFavoriteEventsUseCase;
  late final events_usecases.ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;

  List<EventCategoryEntity> categories = [];
  List<EventEntity> allEvents = [];
  List<EventEntity> visibleEvents = [];
  String selectedCategoryId = AppConstants.categoryIdAll;
  String searchQuery = '';
  bool isLoading = true;
  String? errorMessage;
  final Set<String> favoritePendingIds = {};

  @override
  void initState() {
    super.initState();
    eventsRepository = sl<EventsRepository>();
    getFavoriteEventsUseCase = sl<GetFavoriteEventsUseCase>();
    toggleEventFavoriteUseCase = sl<events_usecases.ToggleEventFavoriteUseCase>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        loadFavorites();
      }
    });
  }

  Future<void> loadFavorites() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final events = await getFavoriteEventsUseCase();
      final loadedCategories = await eventsRepository.fetchBrowseCategories();

      if (!mounted) {
        return;
      }

      setState(() {
        categories = loadedCategories;
        allEvents = events;
        isLoading = false;
        applyFilters();
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
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

  void selectCategory(String categoryId) {
    if (selectedCategoryId == categoryId) {
      return;
    }

    setState(() {
      selectedCategoryId = categoryId;
      applyFilters();
    });
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      applyFilters();
    });
  }

  Future<void> toggleFavorite(String eventId) async {
    if (favoritePendingIds.contains(eventId)) {
      return;
    }

    favoritePendingIds.add(eventId);
    setState(() {});

    try {
      await toggleEventFavoriteUseCase(
        eventId: eventId,
        isFavorite: true,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        allEvents = allEvents.where((event) => event.id != eventId).toList();
        applyFilters();
      });
    } catch (error) {
      if (mounted) {
        setState(
          () => errorMessage = AppMessageLocalizer.fromError(context.l10n, error),
        );
      }
    } finally {
      favoritePendingIds.remove(eventId);
      if (mounted) {
        setState(() {});
      }
    }
  }

  String emptyMessage(AppLocalizations strings) {
    if (allEvents.isEmpty) {
      return AppStrings.favoritesEventsEmpty(strings);
    }
    return AppStrings.homeNoEventsFound(strings);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: FavoritesDesignSpec.primary,
      ),
      body: isLoading
          ? const EventBrowseListShimmer()
          : errorMessage != null && allEvents.isEmpty
              ? Center(
                  child: AppText(
                    errorMessage!,
                    variant: AppTextVariant.error,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: loadFavorites,
                  child: EventBrowseListContent(
                    headerTitle: AppStrings.drawerMyFavorites(strings),
                    headerSubtitle: AppStrings.favoritesEventsSubtitle(strings),
                    headerIcon: Icons.favorite_outline,
                    headerIconColor: FavoritesDesignSpec.favoriteActive,
                    searchHint: AppStrings.favoritesEventsSearchHint(strings),
                    onSearchChanged: updateSearch,
                    categories: categories,
                    selectedCategoryId: selectedCategoryId,
                    onCategorySelected: selectCategory,
                    visibleEvents: visibleEvents,
                    emptyMessage: emptyMessage(strings),
                    footerIcon: Icons.favorite,
                    footerIconColor: FavoritesDesignSpec.favoriteActive,
                    footerText: AppStrings.favoritesSavedEventsCount(
                      strings,
                      visibleEvents.length,
                    ),
                    onFavoriteTap: toggleFavorite,
                    favoritePendingIds: favoritePendingIds,
                    onEventTap: (event) =>
                        EventDetailScreenActions(context).openEventDetail(
                      event: event,
                    ),
                    markAllAsFavorite: true,
                  ),
                ),
    );
  }
}
