import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';

class EventListCardShimmer extends StatelessWidget {
  const EventListCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final cardHeight = layout.spacing(96);
    final cardRadius = layout.radius(10);
    final padding = layout.spacing(16);

    return Container(
      height: cardHeight,
      margin: EdgeInsets.only(bottom: layout.spacing(14)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: theme.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YouPassShimmerBox(
            width: cardHeight,
            height: cardHeight,
            borderRadius: 0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YouPassShimmerBox(
                    width: double.infinity,
                    height: layout.fontSize(16),
                    borderRadius: layout.radius(6),
                  ),
                  SizedBox(height: layout.spacing(8)),
                  YouPassShimmerBox(
                    width: layout.spacing(160),
                    height: layout.fontSize(12),
                    borderRadius: layout.radius(6),
                  ),
                  SizedBox(height: layout.spacing(6)),
                  YouPassShimmerBox(
                    width: layout.spacing(120),
                    height: layout.fontSize(12),
                    borderRadius: layout.radius(6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
