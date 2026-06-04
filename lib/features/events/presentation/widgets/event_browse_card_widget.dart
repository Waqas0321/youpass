import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class EventBrowseCardWidget extends StatelessWidget {
  const EventBrowseCardWidget({
    super.key,
    required this.event,
    this.onBuyTicket,
    this.onFavoriteTap,
    this.isFavoritePending = false,
    this.showFavorite = true,
  });

  final EventEntity event;
  final VoidCallback? onBuyTicket;
  final VoidCallback? onFavoriteTap;
  final bool isFavoritePending;
  final bool showFavorite;

  static const double _designCardHeight = 156;
  static const double _designImageWidth = 120;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final cardHeight = FavoritesDesignSpec.px(context, _designCardHeight);
    final imageWidth = FavoritesDesignSpec.px(context, _designImageWidth);
    final horizontalPadding = FavoritesDesignSpec.px(context, 12);
    final verticalPadding = FavoritesDesignSpec.px(context, 10);
    final description = _descriptionText(event);
    final scheduleLabel = _scheduleLabel(event);

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      height: cardHeight,
      decoration: BoxDecoration(
        color: FavoritesDesignSpec.screenBackground,
        borderRadius: BorderRadius.circular(radius),
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
                            color: FavoritesDesignSpec.titleText,
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
                                : FavoritesDesignSpec.titleText,
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
                                  color: FavoritesDesignSpec.bodyText,
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
                  _BrowseCardActionButton(
                    label: AppStrings.buyTickets(strings),
                    onPressed: onBuyTicket,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _scheduleLabel(EventEntity event) {
    final date = event.dateLabel.trim();
    final time = event.timeLabel?.trim();
    if (time != null && time.isNotEmpty) {
      if (date.isEmpty) {
        return time;
      }
      return '$date · $time';
    }
    return date;
  }

  static String? _descriptionText(EventEntity event) {
    final dateTime = event.dateTimeLabel.trim();
    final date = event.dateLabel.trim();
    if (dateTime.isEmpty || dateTime == date) {
      return null;
    }
    return dateTime;
  }
}

class _BrowseCardActionButton extends StatelessWidget {
  const _BrowseCardActionButton({
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(
      FavoritesDesignSpec.px(context, 8),
    );

    return Material(
      elevation: FavoritesDesignSpec.px(context, 2),
      shadowColor: Colors.black.withValues(alpha: 0.18),
      color: FavoritesDesignSpec.primary,
      borderRadius: radius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: radius,
        child: SizedBox(
          width: double.infinity,
          height: FavoritesDesignSpec.px(context, 36),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 11),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: FavoritesDesignSpec.titleText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
