import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;

        return Container(
          width: layout.spacing(isActive ? 8 : 7),
          height: layout.spacing(isActive ? 8 : 7),
          margin: EdgeInsets.symmetric(horizontal: layout.spacing(4)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppColors.homeAccentYellow
                : AppColors.lightGreyBorder,
          ),
        );
      }),
    );
  }
}
