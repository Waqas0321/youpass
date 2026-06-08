import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';

class VipFloorPlanShimmer extends StatelessWidget {
  const VipFloorPlanShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final mapHeight = VipVenueDesignSpec.px(context, 320);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        children: [
          YouPassShimmerBox(
            width: double.infinity,
            height: mapHeight,
            borderRadius: VipVenueDesignSpec.px(context, 16),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YouPassShimmerBox(
                width: VipVenueDesignSpec.px(context, 72),
                height: VipVenueDesignSpec.px(context, 12),
                borderRadius: VipVenueDesignSpec.px(context, 6),
              ),
              SizedBox(width: VipVenueDesignSpec.px(context, 20)),
              YouPassShimmerBox(
                width: VipVenueDesignSpec.px(context, 72),
                height: VipVenueDesignSpec.px(context, 12),
                borderRadius: VipVenueDesignSpec.px(context, 6),
              ),
              SizedBox(width: VipVenueDesignSpec.px(context, 20)),
              YouPassShimmerBox(
                width: VipVenueDesignSpec.px(context, 72),
                height: VipVenueDesignSpec.px(context, 12),
                borderRadius: VipVenueDesignSpec.px(context, 6),
              ),
            ],
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 20)),
          YouPassShimmerBox(
            width: double.infinity,
            height: VipVenueDesignSpec.px(context, 88),
            borderRadius: VipVenueDesignSpec.px(context, 14),
          ),
        ],
      ),
    );
  }
}
