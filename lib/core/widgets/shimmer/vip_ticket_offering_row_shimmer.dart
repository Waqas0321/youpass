import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

class VipTicketOfferingRowShimmer extends StatelessWidget {
  const VipTicketOfferingRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = VipVenueDesignSpec.px(context, 14);

    return Container(
      margin: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 12)),
      padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: VipVenueScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: VipVenueScreenTheme.cardBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          YouPassShimmerBox(
            width: VipVenueDesignSpec.px(context, 140),
            height: VipVenueDesignSpec.px(context, 14),
            borderRadius: VipVenueDesignSpec.px(context, 6),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 8)),
          YouPassShimmerBox(
            width: VipVenueDesignSpec.px(context, 90),
            height: VipVenueDesignSpec.px(context, 16),
            borderRadius: VipVenueDesignSpec.px(context, 6),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 14)),
          YouPassShimmerBox(
            width: double.infinity,
            height: VipVenueDesignSpec.px(context, 40),
            borderRadius: VipVenueDesignSpec.px(context, 20),
          ),
        ],
      ),
    );
  }
}
