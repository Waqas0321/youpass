import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_event_meta_row_widget.dart';

class FavoriteProducerCardWidget extends StatelessWidget {
  const FavoriteProducerCardWidget({
    super.key,
    required this.producer,
    required this.description,
    this.onViewEvents,
    this.onFavoriteToggle,
  });

  final FavoriteProducerEntity producer;
  final String description;
  final VoidCallback? onViewEvents;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final imageSize = FavoritesDesignSpec.px(context, 88);

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(FavoritesDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: FavoritesDesignSpec.screenBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: FavoritesDesignSpec.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAssetImage(
            assetPath: producer.imageAssetPath,
            width: imageSize,
            height: imageSize,
            borderRadius: BorderRadius.circular(
              FavoritesDesignSpec.px(context, FavoritesDesignSpec.imageRadius),
            ),
          ),
          SizedBox(width: FavoritesDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        producer.name,
                        style: TextStyle(
                          fontSize: FavoritesDesignSpec.px(context, 16),
                          fontWeight: FontWeight.w700,
                          color: FavoritesDesignSpec.titleText,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onFavoriteToggle,
                      borderRadius: BorderRadius.circular(20),
                      child: Icon(
                        producer.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: FavoritesDesignSpec.px(context, 20),
                        color: producer.isFavorite
                            ? FavoritesDesignSpec.favoriteActive
                            : FavoritesDesignSpec.titleText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                FavoritesEventMetaRowWidget(
                  icon: Icons.storefront_outlined,
                  label: AppStrings.favoritesProducerType(strings),
                ),
                FavoritesEventMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: AppStrings.favoritesProducerCoverage(strings),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: FavoritesDesignSpec.px(context, 12),
                    color: FavoritesDesignSpec.bodyText,
                    height: 1.35,
                  ),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                _ViewEventsButton(
                  label: AppStrings.favoritesViewEvents(strings),
                  onPressed: onViewEvents,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewEventsButton extends StatelessWidget {
  const _ViewEventsButton({
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: FavoritesDesignSpec.px(context, 40),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: FavoritesDesignSpec.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              FavoritesDesignSpec.px(context, 10),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: FavoritesDesignSpec.px(context, 12),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
