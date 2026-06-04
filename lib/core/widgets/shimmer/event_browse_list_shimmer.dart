import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class EventBrowseListShimmer extends StatelessWidget {
  const EventBrowseListShimmer({
    super.key,
    this.cardCount = 3,
  });

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);
    final spacing = FavoritesDesignSpec.px(context, 14);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          FavoritesDesignSpec.px(context, 8),
          horizontalPadding,
          FavoritesDesignSpec.px(context, 24),
        ),
        children: [
          YouPassShimmerBox(
            width: FavoritesDesignSpec.px(context, 180),
            height: FavoritesDesignSpec.px(context, 22),
            borderRadius: FavoritesDesignSpec.px(context, 6),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          YouPassShimmerBox(
            width: double.infinity,
            height: FavoritesDesignSpec.px(context, 14),
            borderRadius: FavoritesDesignSpec.px(context, 6),
          ),
          SizedBox(height: spacing),
          YouPassShimmerBox(
            width: double.infinity,
            height: FavoritesDesignSpec.px(context, 48),
            borderRadius: FavoritesDesignSpec.px(context, 12),
          ),
          SizedBox(height: spacing),
          YouPassShimmerBox(
            width: FavoritesDesignSpec.px(context, 56),
            height: FavoritesDesignSpec.px(context, 12),
            borderRadius: FavoritesDesignSpec.px(context, 6),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          SizedBox(
            height: FavoritesDesignSpec.px(context, 40),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, index) =>
                  SizedBox(width: FavoritesDesignSpec.px(context, 8)),
              itemBuilder: (_, index) => YouPassShimmerBox(
                width: FavoritesDesignSpec.px(context, 88),
                height: FavoritesDesignSpec.px(context, 40),
                borderRadius: FavoritesDesignSpec.px(context, 20),
              ),
            ),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 16)),
          for (var index = 0; index < cardCount; index++)
            const EventBrowseCardShimmer(),
        ],
      ),
    );
  }
}
