import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class EventBrowseCardShimmer extends StatelessWidget {
  const EventBrowseCardShimmer({super.key});

  static const double _designCardHeight = 156;
  static const double _designImageWidth = 120;

  @override
  Widget build(BuildContext context) {
    final radius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final cardHeight = FavoritesDesignSpec.px(context, _designCardHeight);
    final imageWidth = FavoritesDesignSpec.px(context, _designImageWidth);
    final spacing = FavoritesDesignSpec.px(context, 12);

    return Container(
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      height: cardHeight,
      decoration: BoxDecoration(
        color: FavoritesDesignSpec.screenBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: FavoritesDesignSpec.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YouPassShimmerBox(
            width: imageWidth,
            height: cardHeight,
            borderRadius: 0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YouPassShimmerBox(
                    width: double.infinity,
                    height: FavoritesDesignSpec.px(context, 16),
                    borderRadius: FavoritesDesignSpec.px(context, 6),
                  ),
                  SizedBox(height: spacing),
                  YouPassShimmerBox(
                    width: FavoritesDesignSpec.px(context, 140),
                    height: FavoritesDesignSpec.px(context, 12),
                    borderRadius: FavoritesDesignSpec.px(context, 6),
                  ),
                  SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                  YouPassShimmerBox(
                    width: FavoritesDesignSpec.px(context, 110),
                    height: FavoritesDesignSpec.px(context, 12),
                    borderRadius: FavoritesDesignSpec.px(context, 6),
                  ),
                  const Spacer(),
                  YouPassShimmerBox(
                    width: double.infinity,
                    height: FavoritesDesignSpec.px(context, 36),
                    borderRadius: FavoritesDesignSpec.px(context, 8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
