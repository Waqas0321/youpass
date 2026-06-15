import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/models/drawer_menu_item.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

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
    final theme = HomeDrawerTheme.of(context);
    final radius = DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileRadius);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: theme.menuTileBackground,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: theme.menuBorder,
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
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    color: theme.menuIcon,
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
                ],
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.menuTitleFontSize,
                      ),
                      fontWeight: FontWeight.w500,
                      color: theme.menuTitle,
                      height: 1.2,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: theme.chevron,
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
