import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/shimmer/event_detail_screen_shimmer.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/usecases/get_event_detail_usecase.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/events/presentation/routes/event_detail_route_args.dart';
import 'package:youpass/features/events/presentation/widgets/event_detail_content_widget.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';

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

  EventDetailEntity? event;
  bool isLoading = true;
  bool isFavoritePending = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getEventDetailUseCase = sl<GetEventDetailUseCase>();
    toggleEventFavoriteUseCase = sl<events_usecases.ToggleEventFavoriteUseCase>();
    loadEventDetail();
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

  void openTicketSelection() {
    final current = event;
    if (current == null || !(current.purchase?.hasTicketOfferings ?? true)) {
      return;
    }

    VipPurchaseScreenActions(context).openTicketSelection(event: current);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final current = event;
    final preview = widget.args.previewEvent;

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: FavoritesDesignSpec.primary,
        actions: current == null
            ? null
            : [
                IconButton(
                  onPressed: isFavoritePending ? null : toggleFavorite,
                  icon: Icon(
                    current.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: current.isFavorite
                        ? FavoritesDesignSpec.favoriteActive
                        : FavoritesDesignSpec.primary,
                  ),
                ),
              ],
      ),
      body: isLoading
          ? const EventDetailScreenShimmer()
          : errorMessage != null && current == null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      FavoritesDesignSpec.px(context, 24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          errorMessage!,
                          variant: AppTextVariant.error,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: FavoritesDesignSpec.px(context, 16)),
                        TextButton(
                          onPressed: loadEventDetail,
                          child: Text(AppStrings.ticketAssignmentRetry(strings)),
                        ),
                      ],
                    ),
                  ),
                )
              : current != null
                  ? EventDetailContentWidget(event: current)
                  : preview != null
                      ? EventDetailContentWidget(
                          event: EventDetailEntity(
                            id: preview.id,
                            title: preview.title,
                            dateTimeLabel: preview.dateTimeLabel,
                            dateLabel: preview.dateLabel,
                            locationLabel: preview.locationLabel,
                            timeLabel: preview.timeLabel,
                            imageUrl: preview.imageUrl,
                            eventTypeSlug: preview.eventTypeSlug,
                            countryCode: preview.countryCode,
                            isFavorite: preview.isFavorite,
                          ),
                        )
                      : const SizedBox.shrink(),
      bottomNavigationBar: current == null && isLoading
          ? null
          : current != null
              ? EventDetailBottomBarWidget(
                  canBuyTickets: current.purchase?.hasTicketOfferings ?? true,
                  onBuyTickets: openTicketSelection,
                )
              : null,
    );
  }
}
