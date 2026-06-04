import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/event_browse_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';

class EventBrowseCardsShimmer extends StatelessWidget {
  const EventBrowseCardsShimmer({
    super.key,
    this.cardCount = 3,
    this.wrapWithShimmer = true,
  });

  final int cardCount;
  final bool wrapWithShimmer;

  @override
  Widget build(BuildContext context) {
    final cards = Column(
      children: [
        for (var index = 0; index < cardCount; index++)
          const EventBrowseCardShimmer(),
      ],
    );

    if (!wrapWithShimmer) {
      return cards;
    }

    return YouPassShimmer(child: cards);
  }
}
