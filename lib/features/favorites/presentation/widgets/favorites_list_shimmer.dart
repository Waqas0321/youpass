import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_card_shimmer.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesListShimmer extends StatelessWidget {
  const FavoritesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return ListView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        FavoritesDesignSpec.px(context, 8),
        horizontalPadding,
        FavoritesDesignSpec.px(context, 24),
      ),
      children: [
        _HeaderShimmer(context),
        SizedBox(height: FavoritesDesignSpec.px(context, 14)),
        _SearchShimmer(context),
        SizedBox(height: FavoritesDesignSpec.px(context, 14)),
        _ChipsShimmer(context),
        SizedBox(height: FavoritesDesignSpec.px(context, 18)),
        const EventBrowseCardShimmer(),
        const EventBrowseCardShimmer(),
        const EventBrowseCardShimmer(),
      ],
    );
  }
}

class _HeaderShimmer extends StatelessWidget {
  const _HeaderShimmer(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: FavoritesDesignSpec.px(context, 22),
          height: FavoritesDesignSpec.px(context, 22),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: FavoritesDesignSpec.px(context, 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: FavoritesDesignSpec.px(context, 18),
                width: FavoritesDesignSpec.px(context, 160),
                color: Colors.grey.shade300,
              ),
              SizedBox(height: FavoritesDesignSpec.px(context, 6)),
              Container(
                height: FavoritesDesignSpec.px(context, 13),
                width: double.infinity,
                color: Colors.grey.shade200,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchShimmer extends StatelessWidget {
  const _SearchShimmer(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FavoritesDesignSpec.px(context, 44),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(FavoritesDesignSpec.px(context, 12)),
      ),
    );
  }
}

class _ChipsShimmer extends StatelessWidget {
  const _ChipsShimmer(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Padding(
          padding: EdgeInsets.only(right: FavoritesDesignSpec.px(context, 8)),
          child: Container(
            width: FavoritesDesignSpec.px(context, 72),
            height: FavoritesDesignSpec.px(context, 32),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
