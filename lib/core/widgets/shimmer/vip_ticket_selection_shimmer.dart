import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/vip_ticket_offering_row_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';

class VipTicketSelectionShimmer extends StatelessWidget {
  const VipTicketSelectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        children: [
          YouPassShimmerBox(
            width: VipVenueDesignSpec.px(context, 120),
            height: VipVenueDesignSpec.px(context, 12),
            borderRadius: VipVenueDesignSpec.px(context, 6),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 10)),
          const VipTicketOfferingRowShimmer(),
          const VipTicketOfferingRowShimmer(),
          SizedBox(height: VipVenueDesignSpec.px(context, 8)),
          YouPassShimmerBox(
            width: VipVenueDesignSpec.px(context, 100),
            height: VipVenueDesignSpec.px(context, 12),
            borderRadius: VipVenueDesignSpec.px(context, 6),
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 10)),
          const VipTicketOfferingRowShimmer(),
          SizedBox(height: VipVenueDesignSpec.px(context, 12)),
          YouPassShimmerBox(
            width: double.infinity,
            height: VipVenueDesignSpec.px(context, 72),
            borderRadius: VipVenueDesignSpec.px(context, 14),
          ),
        ],
      ),
    );
  }
}
