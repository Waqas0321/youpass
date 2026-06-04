import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_box.dart';

/// Full-screen loading placeholder. Prefer screen-specific shimmer widgets.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YouPassShimmer(
        child: YouPassShimmerBox(
          width: 48,
          height: 48,
          borderRadius: 24,
        ),
      ),
    );
  }
}
