import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class EventDetailScreenShimmer extends StatelessWidget {
  const EventDetailScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          YouPassShimmerBox(
            width: double.infinity,
            height: FavoritesDesignSpec.px(context, 240),
            borderRadius: 0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              FavoritesDesignSpec.px(context, 20),
              horizontalPadding,
              FavoritesDesignSpec.px(context, 24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                YouPassShimmerBox(
                  width: double.infinity,
                  height: FavoritesDesignSpec.px(context, 22),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                YouPassShimmerBox(
                  width: FavoritesDesignSpec.px(context, 220),
                  height: FavoritesDesignSpec.px(context, 14),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                YouPassShimmerBox(
                  width: FavoritesDesignSpec.px(context, 180),
                  height: FavoritesDesignSpec.px(context, 14),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 20)),
                YouPassShimmerBox(
                  width: FavoritesDesignSpec.px(context, 120),
                  height: FavoritesDesignSpec.px(context, 12),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: FavoritesDesignSpec.px(context, 12),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: FavoritesDesignSpec.px(context, 12),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
                SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                YouPassShimmerBox(
                  width: FavoritesDesignSpec.px(context, 260),
                  height: FavoritesDesignSpec.px(context, 12),
                  borderRadius: FavoritesDesignSpec.px(context, 6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
