import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';

class EventDetailScreenShimmer extends StatelessWidget {
  const EventDetailScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.horizontalPadding);
    final imageRadius =
        EventDetailDesignSpec.px(context, EventDetailDesignSpec.imageBottomRadius);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.only(
          bottom: EventDetailDesignSpec.px(context, 24),
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(imageRadius),
              bottomRight: Radius.circular(imageRadius),
            ),
            child: const AspectRatio(
              aspectRatio: 16 / 9,
              child: YouPassShimmerBox(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              EventDetailDesignSpec.px(context, 22),
              horizontalPadding,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                YouPassShimmerBox(
                  width: double.infinity,
                  height: EventDetailDesignSpec.px(context, 28),
                  borderRadius: EventDetailDesignSpec.px(context, 8),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 14)),
                YouPassShimmerBox(
                  width: EventDetailDesignSpec.px(context, 240),
                  height: EventDetailDesignSpec.px(context, 16),
                  borderRadius: EventDetailDesignSpec.px(context, 6),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 10)),
                YouPassShimmerBox(
                  width: EventDetailDesignSpec.px(context, 280),
                  height: EventDetailDesignSpec.px(context, 16),
                  borderRadius: EventDetailDesignSpec.px(context, 6),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 20)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: EventDetailDesignSpec.px(context, 72),
                  borderRadius: EventDetailDesignSpec.px(context, 14),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 24)),
                YouPassShimmerBox(
                  width: EventDetailDesignSpec.px(context, 140),
                  height: EventDetailDesignSpec.px(context, 12),
                  borderRadius: EventDetailDesignSpec.px(context, 6),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 10)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: EventDetailDesignSpec.px(context, 14),
                  borderRadius: EventDetailDesignSpec.px(context, 6),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 8)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: EventDetailDesignSpec.px(context, 14),
                  borderRadius: EventDetailDesignSpec.px(context, 6),
                ),
                SizedBox(height: EventDetailDesignSpec.px(context, 8)),
                YouPassShimmerBox(
                  width: EventDetailDesignSpec.px(context, 220),
                  height: EventDetailDesignSpec.px(context, 14),
                  borderRadius: EventDetailDesignSpec.px(context, 6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
