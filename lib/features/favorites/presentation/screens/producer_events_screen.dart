import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/favorites/domain/entities/producer_calendar_event_entity.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_list_shimmer.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/producer_calendar_event_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';

class ProducerEventsScreen extends StatefulWidget {
  const ProducerEventsScreen({super.key, required this.args});

  final ProducerEventsRouteArgs args;

  static Widget fromRouteArgs(ProducerEventsRouteArgs args) {
    return ProducerEventsScreen(args: args);
  }

  @override
  State<ProducerEventsScreen> createState() => _ProducerEventsScreenState();
}

class _ProducerEventsScreenState extends State<ProducerEventsScreen> {
  late final FavoritesRepository favoritesRepository;

  List<ProducerCalendarEventEntity> allEvents = [];
  List<ProducerCalendarEventEntity> visibleEvents = [];
  String searchQuery = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    favoritesRepository = sl<FavoritesRepository>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        loadEvents();
      }
    });
  }

  Future<void> loadEvents() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final snapshot = await favoritesRepository.fetchProducerUpcomingEvents(
        widget.args.producer.id,
      );
      if (!mounted) {
        return;
      }

      setState(() {
        allEvents = snapshot.events;
        isLoading = false;
        applySearch();
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

  void applySearch() {
    final normalized = searchQuery.trim().toLowerCase();
    if (normalized.isEmpty) {
      visibleEvents = allEvents;
      return;
    }

    visibleEvents = allEvents
        .where(
          (event) =>
              event.title.toLowerCase().contains(normalized) ||
              event.locationLabel.toLowerCase().contains(normalized) ||
              (event.venueName?.toLowerCase().contains(normalized) ?? false),
        )
        .toList();
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      applySearch();
    });
  }

  void openPurchase(ProducerCalendarEventEntity event) {
    final preview = EventModel(
      id: event.id,
      title: event.title,
      dateTimeLabel: event.dateLabel,
      dateLabel: event.dateLabel,
      locationLabel: event.locationLabel,
      imageUrl: event.imageUrl,
      eventTypeSlug: event.eventTypeSlug,
      isFavorite: event.isFavorite,
      startsAt: event.startsAt,
    );

    VipPurchaseScreenActions(context).openTicketSelection(event: preview);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final producer = widget.args.producer;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: FavoritesDesignSpec.primary,
      ),
      body: isLoading
          ? const FavoritesListShimmer()
          : errorMessage != null && allEvents.isEmpty
              ? Center(
                  child: AppText(
                    errorMessage!,
                    variant: AppTextVariant.error,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: loadEvents,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      FavoritesDesignSpec.px(context, 8),
                      horizontalPadding,
                      FavoritesDesignSpec.px(context, 24),
                    ),
                    children: [
                      FavoritesSectionHeaderWidget(
                        title: AppStrings.producerEventsUpcomingTitle(strings),
                        subtitle: AppStrings.producerEventsUpcomingSubtitle(
                          strings,
                          producer.name,
                        ),
                        leadingIcon: Icons.event_outlined,
                        leadingIconColor: FavoritesDesignSpec.primary,
                      ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                      FavoritesSearchFieldWidget(
                        hintText: AppStrings.producerEventsSearchHint(strings),
                        onChanged: updateSearch,
                      ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                      if (visibleEvents.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: FavoritesDesignSpec.px(context, 32),
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.favoritesNoSearchResults(strings),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        )
                      else
                        ...visibleEvents.map(
                          (event) => ProducerCalendarEventCardWidget(
                            event: event,
                            onBuyTicket: () => openPurchase(event),
                            onEventTap: () => EventDetailScreenActions(context)
                                .openEventDetail(
                              event: EventModel(
                                id: event.id,
                                title: event.title,
                                dateTimeLabel: event.dateLabel,
                                dateLabel: event.dateLabel,
                                locationLabel: event.locationLabel,
                                imageUrl: event.imageUrl,
                                eventTypeSlug: event.eventTypeSlug,
                                isFavorite: event.isFavorite,
                                startsAt: event.startsAt,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 12)),
                      Center(
                        child: Text(
                          AppStrings.producerEventsAvailableCount(
                            strings,
                            visibleEvents.length,
                          ),
                          style: TextStyle(
                            fontSize: FavoritesDesignSpec.px(context, 13),
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
