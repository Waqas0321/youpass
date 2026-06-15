import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/utils/drawer_menu_factory.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_header_bar_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_invitations_tile_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_menu_tile_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_card_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
    required this.firstName,
    required this.tier,
    this.profilePhotoUrl,
    this.invitationsBadgeCount = 0,
    this.onMenuSelected,
  });

  final String firstName;
  final DrawerMembershipTier tier;
  final String? profilePhotoUrl;
  final int invitationsBadgeCount;
  final ValueChanged<DrawerMenuId>? onMenuSelected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final strings = context.l10n;
    final standardItems = DrawerMenuFactory.standardItems(strings);
    final homeItem = DrawerMenuFactory.homeItem(strings);
    final invitationsItem = DrawerMenuFactory.invitationsItem(strings);
    final horizontalPadding =
        DrawerDesignSpec.px(context, DrawerDesignSpec.horizontalPadding);

    final drawerTheme = HomeDrawerTheme.of(context);

    return Drawer(
      width: screenWidth * DrawerDesignSpec.drawerWidthFactor,
      backgroundColor: drawerTheme.panelBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(DrawerDesignSpec.px(context, 16)),
          bottomRight: Radius.circular(DrawerDesignSpec.px(context, 16)),
        ),
      ),
      elevation: drawerTheme.isDark ? 0 : 16,
      shadowColor: drawerTheme.shadowColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DrawerHeaderBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DrawerProfileCardWidget(
                      firstName: firstName,
                      tier: tier,
                      profilePhotoUrl: profilePhotoUrl,
                      onTap: () => _selectMenu(context, DrawerMenuId.profile),
                    ),
                    SizedBox(
                      height: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.profileToMenuGap,
                      ),
                    ),
                    DrawerMenuTileWidget(
                      item: homeItem,
                      onTap: () => _selectMenu(context, DrawerMenuId.home),
                    ),
                    SizedBox(
                      height: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.menuTileGap,
                      ),
                    ),
                    DrawerInvitationsTileWidget(
                      label: invitationsItem.label,
                      badgeCount: invitationsBadgeCount,
                      onTap: () => _selectMenu(context, DrawerMenuId.invitations),
                    ),
                    SizedBox(
                      height: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.menuTileGap,
                      ),
                    ),
                    for (var index = 0; index < standardItems.length; index++) ...[
                      if (index > 0)
                        SizedBox(
                          height: DrawerDesignSpec.px(
                            context,
                            DrawerDesignSpec.menuTileGap,
                          ),
                        ),
                      DrawerMenuTileWidget(
                        item: standardItems[index],
                        onTap: () => _selectMenu(context, standardItems[index].id),
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

  void _selectMenu(BuildContext context, DrawerMenuId menuId) {
    Navigator.of(context).pop();
    onMenuSelected?.call(menuId);
  }
}
