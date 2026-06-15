import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/drawer_youpass_logo.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class DrawerHeaderBarWidget extends StatelessWidget {
  const DrawerHeaderBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = HomeDrawerTheme.of(context);
    final sideSlot = DrawerDesignSpec.px(context, DrawerDesignSpec.backIconSize + 16);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        DrawerDesignSpec.px(context, 4),
        DrawerDesignSpec.px(context, DrawerDesignSpec.headerTopPadding),
        DrawerDesignSpec.px(context, 4),
        DrawerDesignSpec.px(context, DrawerDesignSpec.headerBottomPadding),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: theme.gold,
              size: DrawerDesignSpec.px(context, DrawerDesignSpec.backIconSize),
            ),
          ),
          Expanded(
            child: Center(
              child: DrawerYouPassLogo(color: theme.gold),
            ),
          ),
          SizedBox(width: sideSlot),
        ],
      ),
    );
  }
}
