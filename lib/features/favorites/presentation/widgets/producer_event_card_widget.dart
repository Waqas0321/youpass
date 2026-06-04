import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_entity.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/producer_event_buy_ticket_button_widget.dart';

class ProducerEventCardWidget extends StatelessWidget {
  const ProducerEventCardWidget({
    super.key,
    required this.event,
    this.onBuyTicket,
  });

  final ProducerEventEntity event;
  final VoidCallback? onBuyTicket;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final imageWidth = FavoritesDesignSpec.px(context, 110);
    final imageHeight = FavoritesDesignSpec.px(context, 130);

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(FavoritesDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: theme.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: FavoritesDesignSpec.px(context, 15),
                    fontWeight: FontWeight.w700,
                    color: YouPassThemedColors.primaryText(context),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                FavoritesEventMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: event.dateLabel,
                ),
                FavoritesEventMetaRowWidget(
                  icon: Icons.schedule_outlined,
                  label: event.timeLabel,
                ),
                FavoritesEventMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: event.locationLabel,
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: FavoritesDesignSpec.px(context, 12),
                      color: YouPassThemedColors.secondaryText(context),
                    ),
                    children: [
                      TextSpan(text: '${AppStrings.producerEventFromPrice(strings)} '),
                      TextSpan(
                        text: event.priceLabel,
                        style: const TextStyle(
                          color: FavoritesDesignSpec.buyAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                ProducerEventBuyTicketButtonWidget(
                  label: AppStrings.producerEventBuyTicket(strings),
                  onPressed: onBuyTicket,
                ),
              ],
            ),
          ),
          SizedBox(width: FavoritesDesignSpec.px(context, 10)),
          AppAssetImage(
            assetPath: event.imageAssetPath,
            width: imageWidth,
            height: imageHeight,
            borderRadius: BorderRadius.circular(
              FavoritesDesignSpec.px(context, FavoritesDesignSpec.imageRadius),
            ),
          ),
        ],
      ),
    );
  }
}
