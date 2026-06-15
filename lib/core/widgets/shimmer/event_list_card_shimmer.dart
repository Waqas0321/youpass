import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_layout.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class EventListCardShimmer extends StatelessWidget {
  const EventListCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final cardHeight =
        FavoritesDesignSpec.px(context, EventBrowseCardLayout.designCardHeight);
    final cardRadius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.cardRadius);
    final imageSize =
        FavoritesDesignSpec.px(context, EventBrowseCardLayout.designImageWidth);
    final imageRadius = FavoritesDesignSpec.px(context, FavoritesDesignSpec.imageRadius);
    final padding = FavoritesDesignSpec.px(context, 12);

    return Container(
      height: cardHeight,
      margin: EdgeInsets.only(bottom: FavoritesDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: theme.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YouPassShimmerBox(
              width: imageSize,
              height: imageSize,
              borderRadius: imageRadius,
            ),
            SizedBox(width: padding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: YouPassShimmerBox(
                          width: double.infinity,
                          height: FavoritesDesignSpec.px(context, 16),
                          borderRadius: FavoritesDesignSpec.px(context, 6),
                        ),
                      ),
                      SizedBox(width: FavoritesDesignSpec.px(context, 8)),
                      YouPassShimmerBox(
                        width: FavoritesDesignSpec.px(context, 20),
                        height: FavoritesDesignSpec.px(context, 20),
                        borderRadius: FavoritesDesignSpec.px(context, 10),
                      ),
                    ],
                  ),
                  SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                  YouPassShimmerBox(
                    width: FavoritesDesignSpec.px(context, 180),
                    height: FavoritesDesignSpec.px(context, 12),
                    borderRadius: FavoritesDesignSpec.px(context, 6),
                  ),
                  SizedBox(height: FavoritesDesignSpec.px(context, 6)),
                  YouPassShimmerBox(
                    width: FavoritesDesignSpec.px(context, 150),
                    height: FavoritesDesignSpec.px(context, 12),
                    borderRadius: FavoritesDesignSpec.px(context, 6),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: YouPassShimmerBox(
                      width: FavoritesDesignSpec.px(context, 132),
                      height: FavoritesDesignSpec.px(context, 32),
                      borderRadius: FavoritesDesignSpec.px(context, 8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
