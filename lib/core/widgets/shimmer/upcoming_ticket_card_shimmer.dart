import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class UpcomingTicketCardShimmer extends StatelessWidget {
  const UpcomingTicketCardShimmer({super.key});

  static const double _designImageHeight = 160;

  @override
  Widget build(BuildContext context) {
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final imageHeight = TicketsDesignSpec.px(context, _designImageHeight);
    final contentPadding = TicketsDesignSpec.px(context, 16);
    final spacing = TicketsDesignSpec.px(context, 10);
    final smallSpacing = TicketsDesignSpec.px(context, 6);
    final buttonHeight = TicketsDesignSpec.px(context, 44);
    final buttonRadius = TicketsDesignSpec.px(context, 10);

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
        boxShadow: TicketsScreenTheme.cardShadow(context),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              YouPassShimmerBox(
                width: double.infinity,
                height: imageHeight,
                borderRadius: 0,
              ),
              Positioned(
                left: TicketsDesignSpec.px(context, 12),
                top: TicketsDesignSpec.px(context, 12),
                child: YouPassShimmerBox(
                  width: TicketsDesignSpec.px(context, 72),
                  height: TicketsDesignSpec.px(context, 24),
                  borderRadius: TicketsDesignSpec.px(context, 20),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YouPassShimmerBox(
                  width: TicketsDesignSpec.px(context, 200),
                  height: TicketsDesignSpec.px(context, 18),
                  borderRadius: TicketsDesignSpec.px(context, 6),
                ),
                SizedBox(height: spacing),
                _MetaRowShimmer(context),
                SizedBox(height: smallSpacing),
                _MetaRowShimmer(context),
                SizedBox(height: smallSpacing),
                _MetaRowShimmer(
                  context,
                  lineWidth: TicketsDesignSpec.px(context, 120),
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 12)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: buttonHeight,
                  borderRadius: buttonRadius,
                ),
                SizedBox(height: spacing),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: buttonHeight,
                  borderRadius: buttonRadius,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRowShimmer extends StatelessWidget {
  const _MetaRowShimmer(
    this.context, {
    this.lineWidth,
  });

  final BuildContext context;
  final double? lineWidth;

  @override
  Widget build(BuildContext _) {
    return Row(
      children: [
        YouPassShimmerBox(
          width: TicketsDesignSpec.px(context, 14),
          height: TicketsDesignSpec.px(context, 14),
          borderRadius: TicketsDesignSpec.px(context, 4),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 6)),
        YouPassShimmerBox(
          width: lineWidth ?? TicketsDesignSpec.px(context, 160),
          height: TicketsDesignSpec.px(context, 12),
          borderRadius: TicketsDesignSpec.px(context, 6),
        ),
      ],
    );
  }
}
