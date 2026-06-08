import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/presentation/utils/event_browse_card_label_formatter.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_action_button_widget.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_layout.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class EventBrowseCardWidget extends StatelessWidget {
  const EventBrowseCardWidget({
    super.key,
    required this.event,
    this.onBuyTicket,
    this.onEventTap,
    this.onFavoriteTap,
    this.isFavoritePending = false,
    this.showFavorite = true,
  });

  final EventEntity event;
  final VoidCallback? onBuyTicket;
  final VoidCallback? onEventTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavoritePending;
  final bool showFavorite;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final cardHeight =
        FavoritesDesignSpec.px(context, EventBrowseCardLayout.designCardHeight);
    final imageWidth =
        FavoritesDesignSpec.px(context, EventBrowseCardLayout.designImageWidth);
    final horizontalPadding = FavoritesDesignSpec.px(context, 12);
    final verticalPadding = FavoritesDesignSpec.px(context, 10);
    final description = EventBrowseCardLabelFormatter.descriptionText(event);
    final scheduleLabel = EventBrowseCardLabelFormatter.scheduleLabel(event);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onEventTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      height: cardHeight,
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: theme.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: FavoritesDesignSpec.px(context, 10),
            offset: Offset(0, FavoritesDesignSpec.px(context, 2)),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: imageWidth,
            child: ColoredBox(
              color: Colors.black,
              child: EventNetworkImage(
                imageUrl: event.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                verticalPadding,
                horizontalPadding,
                verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event.title.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: FavoritesDesignSpec.px(context, 15),
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.15,
                            letterSpacing: 0.2,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FavoritesEventMetaRowWidget(
                          icon: Icons.location_on_outlined,
                          label: event.locationLabel,
                        ),
                        FavoritesEventMetaRowWidget(
                          icon: Icons.calendar_today_outlined,
                          label: scheduleLabel,
                        ),
                        if (description != null) ...[
                          SizedBox(height: FavoritesDesignSpec.px(context, 2)),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: FavoritesDesignSpec.px(context, 11),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: FavoritesDesignSpec.px(context, 4)),
                  EventBrowseCardActionButtonWidget(
                    label: AppStrings.buyTickets(strings),
                    onPressed: onBuyTicket,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
      ),
    );
  }
}
