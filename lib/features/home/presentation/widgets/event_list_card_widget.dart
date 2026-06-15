import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_layout.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class EventListCardWidget extends StatelessWidget {
  const EventListCardWidget({
    super.key,
    required this.event,
    this.onEventTap,
    this.onBuyTicket,
    this.onFavoriteTap,
    this.isFavoritePending = false,
    this.showFavorite = true,
    this.showProximity = false,
    this.onJoinWaitlist,
    this.onLeaveWaitlist,
  });

  final EventEntity event;
  final VoidCallback? onEventTap;
  final VoidCallback? onBuyTicket;
  final VoidCallback? onFavoriteTap;
  final bool isFavoritePending;
  final bool showFavorite;
  final bool showProximity;
  final VoidCallback? onJoinWaitlist;
  final VoidCallback? onLeaveWaitlist;

  bool get _showWaitlistCta {
    final waitlist = event.waitlist;
    if (waitlist == null || !waitlist.enabled) {
      return false;
    }
    return waitlist.canJoin || waitlist.canLeave;
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final strings = context.l10n;
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final cardHeight =
        FavoritesDesignSpec.px(context, EventBrowseCardLayout.designCardHeight);
    final imageSize =
        FavoritesDesignSpec.px(context, EventBrowseCardLayout.designImageWidth);
    final imageRadius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.imageRadius);
    final contentPadding = FavoritesDesignSpec.px(context, 12);
    final waitlist = event.waitlist;

    return SizedBox(
      height: cardHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.cardBackground,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: theme.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: FavoritesDesignSpec.px(context, 10),
              offset: Offset(0, FavoritesDesignSpec.px(context, 2)),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onEventTap,
              child: Padding(
                padding: EdgeInsets.all(contentPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(imageRadius),
                      child: SizedBox(
                        width: imageSize,
                        height: imageSize,
                        child: EventNetworkImage(
                          imageUrl: event.imageUrl,
                          fit: BoxFit.cover,
                          width: imageSize,
                          height: imageSize,
                        ),
                      ),
                    ),
                    SizedBox(width: contentPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  event.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: FavoritesDesignSpec.px(context, 16),
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    height: 1.15,
                                  ),
                                ),
                              ),
                              if (showFavorite) ...[
                                SizedBox(width: FavoritesDesignSpec.px(context, 6)),
                                GestureDetector(
                                  onTap: isFavoritePending ? null : onFavoriteTap,
                                  behavior: HitTestBehavior.opaque,
                                  child: Icon(
                                    event.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: FavoritesDesignSpec.px(context, 20),
                                    color: event.isFavorite
                                        ? FavoritesDesignSpec.favoriteActive
                                        : Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                          FavoritesEventMetaRowWidget(
                            icon: Icons.calendar_today_outlined,
                            label: event.dateLabel,
                            labelColor: AppColors.homeAccentYellow,
                            iconColor: AppColors.homeAccentYellow,
                            fontSize: 12,
                          ),
                          FavoritesEventMetaRowWidget(
                            icon: Icons.location_on_outlined,
                            label: event.locationLabel,
                            labelColor: FavoritesDesignSpec.bodyText,
                            iconColor: FavoritesDesignSpec.metaIcon,
                            fontSize: 12,
                          ),
                          if (showProximity && event.distanceKm != null) ...[
                            _ProximityRow(event: event),
                          ],
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _showWaitlistCta
                                ? GestureDetector(
                                    onTap: waitlist!.canJoin
                                        ? onJoinWaitlist
                                        : onLeaveWaitlist,
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      waitlist.canJoin
                                          ? AppStrings.waitlistJoinButton(strings)
                                              .toUpperCase()
                                          : AppStrings.waitlistLeave(strings),
                                      style: TextStyle(
                                        fontSize: FavoritesDesignSpec.px(context, 11),
                                        fontWeight: FontWeight.w700,
                                        color: waitlist.canJoin
                                            ? AppColors.homeAccentYellow
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                      ),
                                    ),
                                  )
                                : _BuyTicketsButton(
                                    label: AppStrings.buyTickets(strings),
                                    onPressed: onBuyTicket ?? onEventTap,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuyTicketsButton extends StatelessWidget {
  const _BuyTicketsButton({
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(FavoritesDesignSpec.px(context, 8));

    return Material(
      elevation: FavoritesDesignSpec.px(context, 1.5),
      shadowColor: Colors.black.withValues(alpha: 0.14),
      color: AppColors.homeAccentYellow,
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: FavoritesDesignSpec.px(context, 12),
            vertical: FavoritesDesignSpec.px(context, 8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 11),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProximityRow extends StatelessWidget {
  const _ProximityRow({required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final distance = event.distanceKm!;
    final distanceLabel = distance < 10
        ? distance.toStringAsFixed(1)
        : distance.round().toString();
    final travelMinutes = event.travelTimeMinutes;

    return Padding(
      padding: EdgeInsets.only(top: FavoritesDesignSpec.px(context, 2)),
      child: Row(
        children: [
          Icon(
            Icons.near_me_outlined,
            size: FavoritesDesignSpec.px(context, 12),
            color: FavoritesDesignSpec.metaIcon,
          ),
          SizedBox(width: FavoritesDesignSpec.px(context, 4)),
          Text(
            l10n.homeEventDistanceKm(distanceLabel),
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 11),
              color: FavoritesDesignSpec.bodyText,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (travelMinutes != null) ...[
            SizedBox(width: FavoritesDesignSpec.px(context, 8)),
            Icon(
              Icons.directions_car_outlined,
              size: FavoritesDesignSpec.px(context, 12),
              color: FavoritesDesignSpec.metaIcon,
            ),
            SizedBox(width: FavoritesDesignSpec.px(context, 4)),
            Text(
              l10n.homeEventTravelMinutes(travelMinutes),
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 11),
                color: FavoritesDesignSpec.bodyText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
