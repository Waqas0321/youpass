import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class PastEventCardShimmer extends StatelessWidget {
  const PastEventCardShimmer({super.key});

  static const double _designImageHeight = 160;

  @override
  Widget build(BuildContext context) {
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final imageHeight = TicketsDesignSpec.px(context, _designImageHeight);
    final contentPadding = TicketsDesignSpec.px(context, 16);

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
                top: TicketsDesignSpec.px(context, 12),
                right: TicketsDesignSpec.px(context, 12),
                child: YouPassShimmerBox(
                  width: TicketsDesignSpec.px(context, 36),
                  height: TicketsDesignSpec.px(context, 36),
                  borderRadius: TicketsDesignSpec.px(context, 18),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              contentPadding,
              contentPadding,
              contentPadding,
              TicketsDesignSpec.px(context, 14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YouPassShimmerBox(
                  width: TicketsDesignSpec.px(context, 180),
                  height: TicketsDesignSpec.px(context, 18),
                  borderRadius: TicketsDesignSpec.px(context, 6),
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 8)),
                _MetaRowShimmer(context),
                SizedBox(height: TicketsDesignSpec.px(context, 4)),
                _MetaRowShimmer(
                  context,
                  lineWidth: TicketsDesignSpec.px(context, 140),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: TicketsDesignSpec.px(context, 10),
                  ),
                  child: YouPassShimmerBox(
                    width: double.infinity,
                    height: 1,
                    borderRadius: 0,
                  ),
                ),
                YouPassShimmerBox(
                  width: TicketsDesignSpec.px(context, 88),
                  height: TicketsDesignSpec.px(context, 11),
                  borderRadius: TicketsDesignSpec.px(context, 4),
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 12)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _StatColumnShimmer(context)),
                    Expanded(child: _StatColumnShimmer(context)),
                    Expanded(child: _StatColumnShimmer(context)),
                  ],
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

class _StatColumnShimmer extends StatelessWidget {
  const _StatColumnShimmer(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        YouPassShimmerBox(
          width: TicketsDesignSpec.px(context, 20),
          height: TicketsDesignSpec.px(context, 20),
          borderRadius: TicketsDesignSpec.px(context, 6),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 48),
                height: TicketsDesignSpec.px(context, 10),
                borderRadius: TicketsDesignSpec.px(context, 4),
              ),
              SizedBox(height: TicketsDesignSpec.px(context, 4)),
              YouPassShimmerBox(
                width: TicketsDesignSpec.px(context, 36),
                height: TicketsDesignSpec.px(context, 14),
                borderRadius: TicketsDesignSpec.px(context, 4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
