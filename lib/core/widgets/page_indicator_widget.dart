import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    super.key,
    required this.count,
    required this.activeIndex,
    this.onDotTap,
  });

  final int count;
  final int activeIndex;
  final ValueChanged<int>? onDotTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final dotSize = layout.spacing(7);
    final activeDotSize = layout.spacing(8);
    final spacing = layout.spacing(4);

    final dots = List.generate(count, (index) {
      final isActive = index == activeIndex;

      return GestureDetector(
        onTap: onDotTap == null ? null : () => onDotTap!(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isActive ? activeDotSize : dotSize,
            height: isActive ? activeDotSize : dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.homeAccentYellow
                  : AppColors.lightGreyBorder,
            ),
          ),
        ),
      );
    });

    if (count <= 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dots,
      );
    }

    return SizedBox(
      height: activeDotSize + spacing * 2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: layout.spacing(16)),
        children: dots,
      ),
    );
  }
}
