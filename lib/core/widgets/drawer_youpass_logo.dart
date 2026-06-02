import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

class DrawerYouPassLogo extends StatelessWidget {
  const DrawerYouPassLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final logoSize = DrawerDesignSpec.px(context, DrawerDesignSpec.logoFontSize);
    final regSize = DrawerDesignSpec.px(context, DrawerDesignSpec.logoRegFontSize);
    final regOffsetY = DrawerDesignSpec.px(context, DrawerDesignSpec.logoRegOffsetY);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: logoSize,
          fontWeight: FontWeight.w700,
          color: DrawerDesignSpec.gold,
          letterSpacing: -0.5,
          height: 1,
        ),
        children: [
          TextSpan(text: AppConstants.appName),
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Transform.translate(
              offset: Offset(DrawerDesignSpec.px(context, 2), regOffsetY),
              child: Text(
                '®',
                style: TextStyle(
                  fontSize: regSize,
                  fontWeight: FontWeight.w600,
                  color: DrawerDesignSpec.gold,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
