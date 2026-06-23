import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/utils/drawer_menu_factory.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_header_bar_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_invitations_tile_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_menu_tile_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_party_featured_tile_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
    this.invitationsBadgeCount = 0,
    this.onMenuSelected,
  });

  final int invitationsBadgeCount;
  final ValueChanged<DrawerMenuId>? onMenuSelected;

  @override
  Widget build(BuildContext context) {
    final isPartyMode = context.watch<AppThemeProvider>().isFiestaMode;
    final screenWidth = MediaQuery.sizeOf(context).width;
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
                child: isPartyMode
                    ? _PartyModeMenu(
                        onSelect: (menuId) => _selectMenu(context, menuId),
                      )
                    : _StandardMenu(
                        invitationsBadgeCount: invitationsBadgeCount,
                        onSelect: (menuId) => _selectMenu(context, menuId),
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

class _StandardMenu extends StatelessWidget {
  const _StandardMenu({
    required this.invitationsBadgeCount,
    required this.onSelect,
  });

  final int invitationsBadgeCount;
  final ValueChanged<DrawerMenuId> onSelect;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final standardItems = DrawerMenuFactory.standardItems(strings);
    final homeItem = DrawerMenuFactory.homeItem(strings);
    final invitationsItem = DrawerMenuFactory.invitationsItem(strings);
    final gap = DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileGap);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DrawerMenuTileWidget(
          item: homeItem,
          onTap: () => onSelect(DrawerMenuId.home),
        ),
        for (var index = 0; index < standardItems.length; index++) ...[
          SizedBox(height: gap),
          DrawerMenuTileWidget(
            item: standardItems[index],
            onTap: () => onSelect(standardItems[index].id),
          ),
        ],
        SizedBox(height: gap),
        DrawerInvitationsTileWidget(
          label: invitationsItem.label,
          badgeCount: invitationsBadgeCount,
          onTap: () => onSelect(DrawerMenuId.invitations),
        ),
        SizedBox(height: DrawerDesignSpec.px(context, 24)),
      ],
    );
  }
}

class _PartyModeMenu extends StatelessWidget {
  const _PartyModeMenu({
    required this.onSelect,
  });

  final ValueChanged<DrawerMenuId> onSelect;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final items = DrawerMenuFactory.partyModeItems(strings);
    final cortesiasItem = DrawerMenuFactory.cortesiasItem(strings);
    final standardItems = items
        .where((item) => item.id != DrawerMenuId.cortesias)
        .toList();
    final theme = HomeDrawerTheme.of(context);
    final gap = DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileGap);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < standardItems.length; index++) ...[
          if (index > 0) SizedBox(height: gap),
          DrawerMenuTileWidget(
            item: standardItems[index],
            iconColor: theme.gold,
            showDividerBelow: standardItems[index].id == DrawerMenuId.drinkMenu,
            onTap: () => onSelect(standardItems[index].id),
          ),
        ],
        SizedBox(height: gap),
        DrawerPartyFeaturedTileWidget(
          label: cortesiasItem.label,
          onTap: () => onSelect(DrawerMenuId.cortesias),
        ),
        SizedBox(height: DrawerDesignSpec.px(context, 24)),
      ],
    );
  }
}
