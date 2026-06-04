import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/invitation_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsListShimmer extends StatelessWidget {
  const InvitationsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        InvitationsDesignSpec.px(context, InvitationsDesignSpec.horizontalPadding);

    return YouPassShimmer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          InvitationsDesignSpec.px(context, 8),
          horizontalPadding,
          InvitationsDesignSpec.px(context, 24),
        ),
        children: [
          YouPassShimmerBox(
            width: InvitationsDesignSpec.px(context, 180),
            height: InvitationsDesignSpec.px(context, 22),
            borderRadius: InvitationsDesignSpec.px(context, 6),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 8)),
          YouPassShimmerBox(
            width: double.infinity,
            height: InvitationsDesignSpec.px(context, 14),
            borderRadius: InvitationsDesignSpec.px(context, 6),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 16)),
          YouPassShimmerBox(
            width: double.infinity,
            height: InvitationsDesignSpec.px(context, 48),
            borderRadius: InvitationsDesignSpec.px(context, 12),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 14)),
          SizedBox(
            height: InvitationsDesignSpec.px(context, 36),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, index) =>
                  SizedBox(width: InvitationsDesignSpec.px(context, 8)),
              itemBuilder: (_, index) => YouPassShimmerBox(
                width: InvitationsDesignSpec.px(context, 72),
                height: InvitationsDesignSpec.px(context, 36),
                borderRadius: InvitationsDesignSpec.px(context, 18),
              ),
            ),
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 16)),
          const InvitationCardShimmer(),
          const InvitationCardShimmer(),
        ],
      ),
    );
  }
}
