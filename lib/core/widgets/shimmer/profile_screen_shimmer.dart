import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);
    final spacing = ProfileDesignSpec.px(context, 16);

    return YouPassShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: spacing),
            YouPassShimmerBox(
              width: double.infinity,
              height: ProfileDesignSpec.px(context, 160),
              borderRadius: ProfileDesignSpec.px(context, 16),
            ),
            SizedBox(height: spacing),
            YouPassShimmerBox(
              width: ProfileDesignSpec.px(context, 140),
              height: ProfileDesignSpec.px(context, 16),
              borderRadius: ProfileDesignSpec.px(context, 6),
            ),
            SizedBox(height: spacing),
            for (var index = 0; index < 4; index++) ...[
              YouPassShimmerBox(
                width: double.infinity,
                height: ProfileDesignSpec.px(context, 52),
                borderRadius: ProfileDesignSpec.px(context, 12),
              ),
              SizedBox(height: ProfileDesignSpec.px(context, 10)),
            ],
            SizedBox(height: spacing),
            YouPassShimmerBox(
              width: ProfileDesignSpec.px(context, 120),
              height: ProfileDesignSpec.px(context, 16),
              borderRadius: ProfileDesignSpec.px(context, 6),
            ),
            SizedBox(height: ProfileDesignSpec.px(context, 10)),
            YouPassShimmerBox(
              width: double.infinity,
              height: ProfileDesignSpec.px(context, 72),
              borderRadius: ProfileDesignSpec.px(context, 12),
            ),
          ],
        ),
      ),
    );
  }
}
