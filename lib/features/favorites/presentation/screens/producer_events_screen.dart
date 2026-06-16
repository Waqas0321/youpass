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
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/producer_calendar_event_entity.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/producer_calendar_event_card_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/producer_profile_header_widget.dart';
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

  FavoriteProducerEntity? loadedProducer;
  List<ProducerCalendarEventEntity> allEvents = [];
  List<ProducerCalendarEventEntity> visibleEvents = [];
  String searchQuery = '';
  bool isLoading = true;
  String? errorMessage;

  FavoriteProducerEntity get producer =>
      loadedProducer ?? widget.args.producer;

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
        loadedProducer = snapshot.producer.id.isNotEmpty
            ? snapshot.producer
            : widget.args.producer;
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

  EventModel previewFor(ProducerCalendarEventEntity event) {
    return EventModel(
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
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: FavoritesDesignSpec.titleText,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadEvents,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      FavoritesDesignSpec.px(context, 8),
                      horizontalPadding,
                      FavoritesDesignSpec.px(context, 24),
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        ProducerProfileHeaderWidget(producer: producer),
                        SizedBox(height: FavoritesDesignSpec.px(context, 24)),
                        FavoritesSectionHeaderWidget(
                          title: AppStrings.producerEventsUpcomingTitle(strings),
                          subtitle: AppStrings.producerEventsUpcomingSubtitle(
                            strings,
                            producer.name,
                          ),
                          showLeadingIcon: false,
                        ),
                        SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                        FavoritesSearchFieldWidget(
                          hintText: AppStrings.producerEventsSearchHint(strings),
                          onChanged: updateSearch,
                        ),
                        if (errorMessage != null) ...[
                          SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                          AppText(
                            errorMessage!,
                            variant: AppTextVariant.error,
                          ),
                        ],
                        SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                        if (visibleEvents.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: FavoritesDesignSpec.px(context, 32),
                            ),
                            child: Center(
                              child: Text(
                                searchQuery.trim().isEmpty
                                    ? AppStrings.producerEventsEmpty(strings)
                                    : AppStrings
                                        .favoritesNoSearchResults(strings),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                      ]),
                    ),
                  ),
                  if (visibleEvents.isNotEmpty)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final event = visibleEvents[index];
                            return ProducerCalendarEventCardWidget(
                              key: ValueKey(event.id),
                              event: event,
                              onBuyTicket: () => openPurchase(event),
                              onEventTap: () =>
                                  EventDetailScreenActions(context)
                                      .openEventDetail(
                                event: previewFor(event),
                              ),
                            );
                          },
                          childCount: visibleEvents.length,
                        ),
                      ),
                    ),
                  if (visibleEvents.isNotEmpty)
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        FavoritesDesignSpec.px(context, 12),
                        horizontalPadding,
                        FavoritesDesignSpec.px(context, 24),
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_outlined,
                              size: FavoritesDesignSpec.px(context, 16),
                              color: FavoritesDesignSpec.buyAccent,
                            ),
                            SizedBox(width: FavoritesDesignSpec.px(context, 6)),
                            Text(
                              AppStrings.producerEventsAvailableCount(
                                strings,
                                visibleEvents.length,
                              ),
                              style: TextStyle(
                                fontSize: FavoritesDesignSpec.px(context, 13),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
