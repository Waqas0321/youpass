import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_state.dart';

class YouPassShimmer extends StatefulWidget {
  const YouPassShimmer({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  State<YouPassShimmer> createState() => YouPassShimmerState();
}
