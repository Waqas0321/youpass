import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';

class HomeFeedShimmer extends StatelessWidget {
  const HomeFeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return YouPassShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YouPassShimmerBox(
            width: layout.spacing(200),
            height: layout.spacing(28),
            borderRadius: layout.spacing(8),
          ),
          SizedBox(height: layout.spacing(18)),
          SizedBox(
            height: layout.spacing(40),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, index) => SizedBox(width: layout.spacing(8)),
              itemBuilder: (_, index) => YouPassShimmerBox(
                width: layout.spacing(88),
                height: layout.spacing(40),
                borderRadius: layout.spacing(20),
              ),
            ),
          ),
          SizedBox(height: layout.spacing(20)),
          YouPassShimmerBox(
            width: double.infinity,
            height: layout.spacing(190),
            borderRadius: layout.spacing(16),
          ),
          SizedBox(height: layout.spacing(24)),
          YouPassShimmerBox(
            width: layout.spacing(120),
            height: layout.spacing(18),
            borderRadius: layout.spacing(6),
          ),
          SizedBox(height: layout.spacing(14)),
          const EventBrowseCardShimmer(),
          const EventBrowseCardShimmer(),
        ],
      ),
    );
  }
}
