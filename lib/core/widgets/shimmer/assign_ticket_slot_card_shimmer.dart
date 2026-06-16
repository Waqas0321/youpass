import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketSlotCardShimmer extends StatelessWidget {
  const AssignTicketSlotCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = TicketAssignmentDesignSpec.cardRadius(context);
    final spacing = TicketsDesignSpec.px(context, 10);
    final fieldHeight = TicketsDesignSpec.px(context, 42);
    final buttonHeight = TicketAssignmentDesignSpec.buttonHeight(context);
    final buttonRadius = TicketAssignmentDesignSpec.buttonRadius(context);
    final avatarSize = TicketAssignmentDesignSpec.avatarSize(context);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 88),
                height: TicketsDesignSpec.px(context, 16),
                borderRadius: TicketsDesignSpec.px(context, 6),
              ),
              SizedBox(width: spacing),
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 88),
                height: TicketsDesignSpec.px(context, 22),
                borderRadius: buttonRadius,
              ),
            ],
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 14)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YouPassShimmerBox(
                width: avatarSize,
                height: avatarSize,
                borderRadius: avatarSize / 2,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Column(
                  children: [
                    YouPassShimmerBox(
                      width: double.infinity,
                      height: fieldHeight,
                      borderRadius: TicketAssignmentDesignSpec.fieldRadius(context),
                    ),
                    SizedBox(height: spacing),
                    YouPassShimmerBox(
                      width: double.infinity,
                      height: fieldHeight,
                      borderRadius: TicketAssignmentDesignSpec.fieldRadius(context),
                    ),
                  ],
                ),
              ),
            ],
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
          SizedBox(height: spacing),
          YouPassShimmerBox(
            width: double.infinity,
            height: buttonHeight,
            borderRadius: buttonRadius,
          ),
        ],
      ),
    );
  }
}
