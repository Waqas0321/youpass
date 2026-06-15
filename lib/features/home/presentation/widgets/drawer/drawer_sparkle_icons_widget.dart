import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class DrawerSparkleIconsWidget extends StatelessWidget {
  const DrawerSparkleIconsWidget({
    super.key,
    this.primaryColor,
    this.secondaryColor,
  });

  final Color? primaryColor;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    final theme = HomeDrawerTheme.of(context);
    final primary = primaryColor ?? theme.gold;
    final secondary = secondaryColor ?? theme.goldSecondary;

    return SizedBox(
      width: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleSlotWidth),
      height: DrawerDesignSpec.px(context, DrawerDesignSpec.menuIconSize),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.auto_awesome,
            color: primary,
            size: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleLarge),
          ),
          Positioned(
            left: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleOffsetX),
            top: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleOffsetY),
            child: Icon(
              Icons.auto_awesome,
              color: secondary,
              size: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleSmall),
            ),
          ),
        ],
      ),
    );
  }
}
