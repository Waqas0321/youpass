import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

class DrawerSparkleIconsWidget extends StatelessWidget {
  const DrawerSparkleIconsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleSlotWidth),
      height: DrawerDesignSpec.px(context, DrawerDesignSpec.menuIconSize),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.auto_awesome,
            color: DrawerDesignSpec.gold,
            size: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleLarge),
          ),
          Positioned(
            left: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleOffsetX),
            top: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleOffsetY),
            child: Icon(
              Icons.auto_awesome,
              color: DrawerDesignSpec.goldSparkleSecondary,
              size: DrawerDesignSpec.px(context, DrawerDesignSpec.sparkleSmall),
            ),
          ),
        ],
      ),
    );
  }
}
