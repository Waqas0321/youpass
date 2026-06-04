import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/past_event_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/upcoming_ticket_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class UpcomingTicketsTabShimmer extends StatelessWidget {
  const UpcomingTicketsTabShimmer({
    super.key,
    this.cardCount = 2,
  });

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding);

    return YouPassShimmer(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          TicketsDesignSpec.px(context, 16),
          horizontalPadding,
          TicketsDesignSpec.px(context, 24),
        ),
        itemCount: cardCount,
        itemBuilder: (context, index) => const UpcomingTicketCardShimmer(),
      ),
    );
  }
}

class PastEventsListShimmer extends StatelessWidget {
  const PastEventsListShimmer({
    super.key,
    this.cardCount = 2,
  });

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding);

    return YouPassShimmer(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          TicketsDesignSpec.px(context, 16),
          horizontalPadding,
          TicketsDesignSpec.px(context, 24),
        ),
        itemCount: cardCount,
        itemBuilder: (context, index) => const PastEventCardShimmer(),
      ),
    );
  }
}
