import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';

class VipTableSelectionShimmer extends StatelessWidget {
  const VipTableSelectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final cellSize = VipVenueDesignSpec.px(context, 44);
    final gap = VipVenueDesignSpec.px(context, 10);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        children: [
          YouPassShimmerBox(
            width: double.infinity,
            height: VipVenueDesignSpec.px(context, 280),
            borderRadius: VipVenueDesignSpec.px(context, 16),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(right: index == 3 ? 0 : gap),
                child: YouPassShimmerBox(
                  width: VipVenueDesignSpec.px(context, 64),
                  height: VipVenueDesignSpec.px(context, 12),
                  borderRadius: VipVenueDesignSpec.px(context, 6),
                ),
              ),
            ),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 16)),
          Wrap(
            spacing: gap,
            runSpacing: gap,
            children: List.generate(
              8,
              (_) => YouPassShimmerBox(
                width: cellSize,
                height: cellSize,
                borderRadius: VipVenueDesignSpec.px(context, 10),
              ),
            ),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 16)),
          YouPassShimmerBox(
            width: double.infinity,
            height: VipVenueDesignSpec.px(context, 120),
            borderRadius: VipVenueDesignSpec.px(context, 14),
          ),
        ],
      ),
    );
  }
}
