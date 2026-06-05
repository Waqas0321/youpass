import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketSlotCardShimmer extends StatelessWidget {
  const AssignTicketSlotCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final spacing = TicketsDesignSpec.px(context, 10);
    final fieldHeight = TicketsDesignSpec.px(context, 44);
    final buttonHeight = TicketsDesignSpec.px(context, 40);
    final buttonRadius = TicketsDesignSpec.px(context, 10);
    final avatarSize = TicketsDesignSpec.px(context, 44);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
        boxShadow: TicketsScreenTheme.cardShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: YouPassShimmerBox(
                  height: TicketsDesignSpec.px(context, 16),
                  borderRadius: TicketsDesignSpec.px(context, 6),
                ),
              ),
              SizedBox(width: spacing),
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 72),
                height: TicketsDesignSpec.px(context, 24),
                borderRadius: TicketsDesignSpec.px(context, 20),
              ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 14)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YouPassShimmerBox(
                width: avatarSize,
                height: avatarSize,
                borderRadius: avatarSize / 2,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: YouPassShimmerBox(
                  height: fieldHeight,
                  borderRadius: TicketsDesignSpec.px(context, 8),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          YouPassShimmerBox(
            width: double.infinity,
            height: fieldHeight,
            borderRadius: TicketsDesignSpec.px(context, 8),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          Row(
            children: [
              Expanded(
                child: YouPassShimmerBox(
                  height: buttonHeight,
                  borderRadius: buttonRadius,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: YouPassShimmerBox(
                  height: buttonHeight,
                  borderRadius: buttonRadius,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
