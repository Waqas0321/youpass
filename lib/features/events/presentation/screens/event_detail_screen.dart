import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/shimmer/event_detail_screen_shimmer.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/usecases/get_event_detail_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_producer_follow_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';
import 'package:youpass/features/events/presentation/routes/event_detail_route_args.dart';
import 'package:youpass/features/events/presentation/widgets/event_detail_buy_tickets_bar_widget.dart';
import 'package:youpass/features/events/presentation/widgets/event_detail_content_widget.dart';
import 'package:youpass/features/events/presentation/widgets/event_detail_header_widget.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';
import 'package:youpass/features/waitlist/presentation/utils/waitlist_flow_actions.dart';
import 'package:youpass/routes/app_routes.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({
    super.key,
    required this.args,
  });

  final EventDetailRouteArgs args;

  static Widget fromRouteArgs(EventDetailRouteArgs args) {
    return EventDetailScreen(args: args);
  }

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late final GetEventDetailUseCase getEventDetailUseCase;
  late final events_usecases.ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
  late final ToggleProducerFollowUseCase toggleProducerFollowUseCase;

  EventDetailEntity? event;
  bool isLoading = true;
  bool isFavoritePending = false;
  bool isFollowPending = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getEventDetailUseCase = sl<GetEventDetailUseCase>();
    toggleEventFavoriteUseCase = sl<events_usecases.ToggleEventFavoriteUseCase>();
    toggleProducerFollowUseCase = sl<ToggleProducerFollowUseCase>();
    loadEventDetail();
  }

  bool get _headerIsFavorite {
    final current = event;
    if (current != null) {
      return current.isFavorite;
    }
    return widget.args.previewEvent?.isFavorite ?? false;
  }

  Future<void> loadEventDetail() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final loaded = await getEventDetailUseCase(widget.args.eventId);
      if (!mounted) {
        return;
      }
      setState(() {
        event = loaded;
        isLoading = false;
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

  Future<void> toggleFavorite() async {
    final current = event;
    if (current == null || isFavoritePending) {
      return;
    }

    final nextFavorite = !current.isFavorite;
    setState(() {
      isFavoritePending = true;
      event = current.copyWith(isFavorite: nextFavorite);
    });

    try {
      await toggleEventFavoriteUseCase(
        eventId: current.id,
        isFavorite: current.isFavorite,
      );
    } catch (_) {
      if (mounted) {
        setState(() => event = current);
      }
    } finally {
      if (mounted) {
        setState(() => isFavoritePending = false);
      }
    }
  }

  Future<void> toggleProducerFollow(FavoriteProducerEntity producer) async {
    final current = event;
    if (current == null || isFollowPending) {
      return;
    }

    final nextFollowing = !producer.isFollowing;
    setState(() {
      isFollowPending = true;
      event = current.copyWithProducerFollowing(nextFollowing);
    });

    try {
      await toggleProducerFollowUseCase(
        producerId: producer.id,
        isFollowing: producer.isFollowing,
      );
      if (mounted) {
        final strings = context.l10n;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              nextFollowing
                  ? AppStrings.eventDetailFollowPromoter(strings, producer.name)
                  : AppStrings.eventDetailUnfollowPromoter(
                      strings,
                      producer.name,
                    ),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.fromLTRB(
              16,
              0,
              16,
              EventDetailDesignSpec.px(context, 88),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(() => event = current);
      }
    } finally {
      if (mounted) {
        setState(() => isFollowPending = false);
      }
    }
  }

  void openProducerCalendar(FavoriteProducerEntity producer) {
    Navigator.of(context).pushNamed(
      AppRoutes.producerEvents,
      arguments: ProducerEventsRouteArgs(producer: producer),
    );
  }

  void openTicketSelection() {
    final current = event;
    if (current == null ||
        current.availability?.isSoldOut == true ||
        !(current.purchase?.canPurchase ?? false)) {
      return;
    }

    VipPurchaseScreenActions(context).openTicketSelection(event: current);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final current = event;

    return Scaffold(
      backgroundColor: EventDetailTheme.of(context).screenBackground,
      body: Column(
        children: [
          EventDetailHeaderWidget(
            onBack: () => Navigator.of(context).pop(),
            isFavorite: _headerIsFavorite,
            isFavoriteEnabled: !isFavoritePending,
            onFavoriteToggle: isLoading && current == null
                ? null
                : toggleFavorite,
          ),
          Expanded(
            child: isLoading
                ? const EventDetailScreenShimmer()
                : errorMessage != null && current == null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                            EventDetailDesignSpec.px(context, 24),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                errorMessage!,
                                variant: AppTextVariant.error,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: EventDetailDesignSpec.px(context, 16),
                              ),
                              TextButton(
                                onPressed: loadEventDetail,
                                child: Text(
                                  AppStrings.ticketAssignmentRetry(strings),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : current != null
                        ? EventDetailContentWidget(
                            event: current,
                            isFollowPending: isFollowPending,
                            onPromoterTap: openProducerCalendar,
                            onPromoterFollowToggle: toggleProducerFollow,
                          )
                        : const SizedBox.shrink(),
          ),
          EventDetailBuyTicketsBarWidget(
            enabled: current != null,
            isSoldOut: current?.availability?.isSoldOut ?? false,
            canBuyTickets: !(current?.availability?.isSoldOut ?? false) &&
                (current?.purchase?.canPurchase ?? false),
            onBuyTickets: openTicketSelection,
            canJoinWaitlist: !(current?.availability?.isSoldOut ?? false) &&
                (current?.waitlist?.canJoin ?? false),
            canLeaveWaitlist: current?.waitlist?.canLeave ?? false,
            onJoinWaitlist: current == null
                ? null
                : () async {
                    await WaitlistFlowActions(context).openJoinScreen(
                      eventId: current.id,
                      eventTitle: current.title,
                    );
                    if (context.mounted) {
                      await loadEventDetail();
                    }
                  },
            onLeaveWaitlist: current == null
                ? null
                : () async {
                    final waitlistActions = WaitlistFlowActions(context);
                    await waitlistActions.leaveWaitlist(
                      WaitlistEntryEntity(
                        id: '',
                        eventId: current.id,
                        eventTitle: current.title,
                        locationLabel: current.locationLabel,
                        dateTimeLabel: current.dateTimeLabel,
                        imageUrl: current.imageUrl ?? '',
                        status: 'waiting',
                        position: current.waitlist?.position ?? 0,
                        badge: 'WAITING LIST',
                        statusLabel: '',
                        canLeave: true,
                      ),
                    );
                    if (context.mounted) {
                      await loadEventDetail();
                    }
                  },
          ),
        ],
      ),
    );
  }
}
