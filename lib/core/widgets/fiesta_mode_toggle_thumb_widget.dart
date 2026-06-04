import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';

class FiestaModeToggleThumbWidget extends StatelessWidget {
  const FiestaModeToggleThumbWidget({
    super.key,
    required this.size,
    required this.isFiestaMode,
    required this.badgeLabel,
    required this.modeLabel,
    required this.layout,
  });

  final double size;
  final bool isFiestaMode;
  final String badgeLabel;
  final String modeLabel;
  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isFiestaMode ? AppColors.homeBlack : AppColors.homeAccentYellow;
    final foregroundColor =
        isFiestaMode ? AppColors.homeAccentYellow : AppColors.homeBlack;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: layout.spacing(2)),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                badgeLabel,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: layout.fontSize(8),
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                modeLabel.toUpperCase(),
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: layout.fontSize(4.2),
                  fontWeight: FontWeight.w700,
                  height: 1,
                  letterSpacing: 0.1,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
