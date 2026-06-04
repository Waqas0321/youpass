import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer_theme.dart';

class YouPassShimmer extends StatefulWidget {
  const YouPassShimmer({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  State<YouPassShimmer> createState() => _YouPassShimmerState();
}

class _YouPassShimmerState extends State<YouPassShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: YouPassShimmerTheme.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = _controller.value * 2;
            return LinearGradient(
              begin: Alignment(-1 + slide, 0),
              end: Alignment(slide, 0),
              colors: const [
                YouPassShimmerTheme.base,
                YouPassShimmerTheme.highlight,
                YouPassShimmerTheme.base,
              ],
              stops: const [0.1, 0.5, 0.9],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
