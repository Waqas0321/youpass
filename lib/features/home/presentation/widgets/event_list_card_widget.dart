import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/core/widgets/youpass_compact_button.dart';
import 'package:youpass/features/home/presentation/widgets/event_meta_row_widget.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';

class EventListCardWidget extends StatelessWidget {
  const EventListCardWidget({
    super.key,
    required this.event,
    this.onBuyTickets,
    this.onEventTap,
    this.onFavoriteTap,
    this.isFavoritePending = false,
  });

  final EventEntity event;
  final VoidCallback? onBuyTickets;
  final VoidCallback? onEventTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavoritePending;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final cardHeight = layout.spacing(120);
    final cardRadius = layout.radius(16);
    final buttonHeight = layout.spacing(28);

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: theme.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onEventTap,
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: cardHeight,
            child: EventNetworkImage(
              imageUrl: event.imageUrl,
              fit: BoxFit.cover,
              width: cardHeight,
              height: cardHeight,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(12),
                layout.spacing(8),
                layout.spacing(8),
                layout.spacing(8),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: layout.spacing(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AppText(
                                event.title,
                                variant: AppTextVariant.listTitle,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: layout.fontSize(16),
                                fontWeight: FontWeight.w700,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: layout.spacing(4)),
                            GestureDetector(
                              onTap: isFavoritePending ? null : onFavoriteTap,
                              behavior: HitTestBehavior.opaque,
                              child: Icon(
                                event.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: layout.fontSize(18),
                                color: event.isFavorite
                                    ? AppColors.favoriteActive
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: layout.spacing(4)),
                        EventMetaRowWidget(
                          icon: Icons.calendar_today_outlined,
                          label: event.dateLabel,
                          iconColor: AppColors.homeAccentYellow,
                          labelColor: AppColors.homeAccentYellow,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                        ),
                        SizedBox(height: layout.spacing(2)),
                        EventMetaRowWidget(
                          icon: Icons.location_on_outlined,
                          label: event.locationLabel,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: buttonHeight,
                      child: YouPassCompactButton(
                        label: AppStrings.buyTickets(context.l10n),
                        onPressed: onBuyTickets ?? () {},
                      ),
                    ),
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
