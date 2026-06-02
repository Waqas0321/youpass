import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/utils/drawer_menu_factory.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_header_bar_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_menu_tile_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_card_widget.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
    required this.userName,
    this.onMenuSelected,
  });

  final String userName;
  final ValueChanged<DrawerMenuId>? onMenuSelected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final menuItems = DrawerMenuFactory.build(context.l10n);
    final horizontalPadding =
        DrawerDesignSpec.px(context, DrawerDesignSpec.horizontalPadding);

    return Drawer(
      width: screenWidth,
      backgroundColor: DrawerDesignSpec.screenBackground,
      elevation: 0,
      shadowColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeaderBarWidget(
              onBackTap: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DrawerProfileCardWidget(userName: userName),
                    SizedBox(
                      height: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.profileToMenuGap,
                      ),
                    ),
                    for (var index = 0; index < menuItems.length; index++) ...[
                      if (index > 0)
                        SizedBox(
                          height: DrawerDesignSpec.px(
                            context,
                            DrawerDesignSpec.menuTileGap,
                          ),
                        ),
                      DrawerMenuTileWidget(
                        item: menuItems[index],
                        onTap: () {
                          Navigator.of(context).pop();
                          onMenuSelected?.call(menuItems[index].id);
                        },
                      ),
                    ],
                    SizedBox(height: DrawerDesignSpec.px(context, 24)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
