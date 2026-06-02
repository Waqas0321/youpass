import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/drawer_youpass_logo.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

class DrawerHeaderBarWidget extends StatelessWidget {
  const DrawerHeaderBarWidget({
    super.key,
    required this.onBackTap,
  });

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        DrawerDesignSpec.px(context, DrawerDesignSpec.horizontalPadding),
        DrawerDesignSpec.px(context, DrawerDesignSpec.headerTopPadding),
        DrawerDesignSpec.px(context, DrawerDesignSpec.horizontalPadding),
        DrawerDesignSpec.px(context, DrawerDesignSpec.headerBottomPadding),
      ),
      child: SizedBox(
        height: DrawerDesignSpec.px(context, DrawerDesignSpec.headerHeight),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onBackTap,
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  Icons.arrow_back,
                  color: DrawerDesignSpec.gold,
                  size: DrawerDesignSpec.px(
                    context,
                    DrawerDesignSpec.backIconSize,
                  ),
                ),
              ),
            ),
            const DrawerYouPassLogo(),
          ],
        ),
      ),
    );
  }
}
