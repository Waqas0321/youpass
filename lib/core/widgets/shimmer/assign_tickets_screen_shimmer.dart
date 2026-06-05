import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/shimmer/assign_ticket_slot_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketsScreenShimmer extends StatelessWidget {
  const AssignTicketsScreenShimmer({
    super.key,
    this.cardCount = 2,
  });

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          TicketsDesignSpec.px(context, 16),
          horizontalPadding,
          TicketsDesignSpec.px(context, 24),
        ),
        children: [
          YouPassShimmerBox(
            width: TicketsDesignSpec.px(context, 220),
            height: TicketsDesignSpec.px(context, 26),
            borderRadius: TicketsDesignSpec.px(context, 6),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 8)),
          YouPassShimmerBox(
            width: double.infinity,
            height: TicketsDesignSpec.px(context, 14),
            borderRadius: TicketsDesignSpec.px(context, 6),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 16)),
          for (var index = 0; index < cardCount; index++)
            const AssignTicketSlotCardShimmer(),
          SizedBox(height: TicketsDesignSpec.px(context, 16)),
          Container(
            padding: EdgeInsets.all(TicketsDesignSpec.px(context, 14)),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(TicketsDesignSpec.px(context, 12)),
              border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YouPassShimmerBox(
                  width: TicketsDesignSpec.px(context, 22),
                  height: TicketsDesignSpec.px(context, 22),
                  borderRadius: TicketsDesignSpec.px(context, 6),
                ),
                SizedBox(width: TicketsDesignSpec.px(context, 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      YouPassShimmerBox(
                        width: double.infinity,
                        height: TicketsDesignSpec.px(context, 12),
                        borderRadius: TicketsDesignSpec.px(context, 6),
                      ),
                      SizedBox(height: TicketsDesignSpec.px(context, 6)),
                      YouPassShimmerBox(
                        width: TicketsDesignSpec.px(context, 200),
                        height: TicketsDesignSpec.px(context, 12),
                        borderRadius: TicketsDesignSpec.px(context, 6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 16),
                height: TicketsDesignSpec.px(context, 16),
                borderRadius: TicketsDesignSpec.px(context, 4),
              ),
              SizedBox(width: TicketsDesignSpec.px(context, 8)),
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 180),
                height: TicketsDesignSpec.px(context, 12),
                borderRadius: TicketsDesignSpec.px(context, 6),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
