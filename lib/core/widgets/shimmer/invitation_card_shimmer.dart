import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationCardShimmer extends StatelessWidget {
  const InvitationCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final imageSize = InvitationsDesignSpec.px(context, 96);
    final radius = InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardRadius);
    final spacing = InvitationsDesignSpec.px(context, 12);

    return Container(
      margin: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(spacing),
      decoration: BoxDecoration(
        color: InvitationsDesignSpec.screenBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: InvitationsDesignSpec.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YouPassShimmerBox(
            width: imageSize,
            height: imageSize,
            borderRadius: InvitationsDesignSpec.px(context, 12),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: YouPassShimmerBox(
                        height: InvitationsDesignSpec.px(context, 16),
                        borderRadius: InvitationsDesignSpec.px(context, 6),
                      ),
                    ),
                    SizedBox(width: spacing),
                    YouPassShimmerBox(
                      width: InvitationsDesignSpec.px(context, 28),
                      height: InvitationsDesignSpec.px(context, 28),
                      borderRadius: InvitationsDesignSpec.px(context, 6),
                    ),
                  ],
                ),
                SizedBox(height: spacing),
                YouPassShimmerBox(
                  width: InvitationsDesignSpec.px(context, 140),
                  height: InvitationsDesignSpec.px(context, 12),
                  borderRadius: InvitationsDesignSpec.px(context, 6),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                YouPassShimmerBox(
                  width: InvitationsDesignSpec.px(context, 120),
                  height: InvitationsDesignSpec.px(context, 12),
                  borderRadius: InvitationsDesignSpec.px(context, 6),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                YouPassShimmerBox(
                  width: InvitationsDesignSpec.px(context, 80),
                  height: InvitationsDesignSpec.px(context, 12),
                  borderRadius: InvitationsDesignSpec.px(context, 6),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: InvitationsDesignSpec.px(context, 1),
                  borderRadius: 0,
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                YouPassShimmerBox(
                  width: double.infinity,
                  height: InvitationsDesignSpec.px(context, 38),
                  borderRadius: InvitationsDesignSpec.px(context, 10),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                Row(
                  children: [
                    Expanded(
                      child: YouPassShimmerBox(
                        height: InvitationsDesignSpec.px(context, 38),
                        borderRadius: InvitationsDesignSpec.px(context, 10),
                      ),
                    ),
                    SizedBox(width: InvitationsDesignSpec.px(context, 8)),
                    Expanded(
                      child: YouPassShimmerBox(
                        height: InvitationsDesignSpec.px(context, 38),
                        borderRadius: InvitationsDesignSpec.px(context, 10),
                      ),
                    ),
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
