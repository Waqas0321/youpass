import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';

class HomeEventsSectionShimmer extends StatelessWidget {
  const HomeEventsSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(16)),
      child: YouPassShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            EventBrowseCardShimmer(),
            EventBrowseCardShimmer(),
          ],
        ),
      ),
    );
  }
}
