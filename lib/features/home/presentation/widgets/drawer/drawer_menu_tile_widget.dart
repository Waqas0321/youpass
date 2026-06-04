import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/home/domain/entities/drawer_menu_id.dart';
import 'package:youpass/features/home/presentation/models/drawer_menu_item.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_sparkle_icons_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';

class DrawerMenuTileWidget extends StatelessWidget {
  const DrawerMenuTileWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  final DrawerMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final isInvitations = item.id == DrawerMenuId.invitations;
    final radius = DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileRadius);

    final backgroundColor = isInvitations
        ? theme.drawerInvitationsTileBackground
        : theme.drawerMenuTileBackground;

    final titleColor = isInvitations
        ? YouPassThemeExtension.invitationsTitle
        : theme.drawerMenuTitle;

    final chevronColor =
        isInvitations ? YouPassThemeExtension.drawerGold : theme.drawerMenuTitle;

    final titleWeight = isInvitations ? FontWeight.w700 : FontWeight.w500;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: isInvitations
                  ? theme.drawerInvitationsTileBackground
                  : theme.drawerMenuBorder,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DrawerDesignSpec.px(
                context,
                DrawerDesignSpec.menuTilePaddingHorizontal,
              ),
              vertical: DrawerDesignSpec.px(
                context,
                DrawerDesignSpec.menuTilePaddingVertical,
              ),
            ),
            child: Row(
              children: [
                if (isInvitations)
                  const DrawerSparkleIconsWidget()
                else
                  Icon(
                    item.icon,
                    color: theme.drawerMenuTitle,
                    size: DrawerDesignSpec.px(
                      context,
                      DrawerDesignSpec.menuIconSize,
                    ),
                  ),
                SizedBox(
                  width: DrawerDesignSpec.px(
                    context,
                    DrawerDesignSpec.menuIconToTextGap,
                  ),
                ),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.menuTitleFontSize,
                      ),
                      fontWeight: titleWeight,
                      color: titleColor,
                      letterSpacing: isInvitations ? 0.3 : 0,
                      height: 1.2,
                    ),
                  ),
                ),
                if (item.badgeLabel != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.badgePaddingHorizontal,
                      ),
                      vertical: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.badgePaddingVertical,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: theme.drawerInvitationsBadgeBackground,
                      borderRadius: BorderRadius.circular(
                        DrawerDesignSpec.px(
                          context,
                          DrawerDesignSpec.badgeRadius,
                        ),
                      ),
                    ),
                    child: Text(
                      item.badgeLabel!,
                      style: TextStyle(
                        fontSize: DrawerDesignSpec.px(
                          context,
                          DrawerDesignSpec.badgeFontSize,
                        ),
                        fontWeight: FontWeight.w600,
                        color: theme.drawerInvitationsBadgeText,
                        height: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: DrawerDesignSpec.px(
                      context,
                      DrawerDesignSpec.badgeToChevronGap,
                    ),
                  ),
                ],
                Icon(
                  Icons.chevron_right,
                  color: chevronColor,
                  size: DrawerDesignSpec.px(
                    context,
                    DrawerDesignSpec.menuChevronSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
