import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_sparkle_icons_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

/// Solid gold featured row used for courtesies in Party Mode.
class DrawerPartyFeaturedTileWidget extends StatelessWidget {
  const DrawerPartyFeaturedTileWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = HomeDrawerTheme.of(context);
    final radius = DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileRadius);
    const onGold = Color(0xFF000000);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: theme.gold,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DrawerDesignSpec.px(
                context,
                DrawerDesignSpec.menuTilePaddingHorizontal,
              ),
              vertical: DrawerDesignSpec.px(
                context,
                DrawerDesignSpec.invitationsTilePaddingVertical,
              ),
            ),
            child: Row(
              children: [
                DrawerSparkleIconsWidget(
                  primaryColor: onGold,
                  secondaryColor: onGold.withValues(alpha: 0.72),
                ),
                SizedBox(
                  width: DrawerDesignSpec.px(
                    context,
                    DrawerDesignSpec.menuIconToTextGap,
                  ),
                ),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.invitationsMenuTitleFontSize,
                      ),
                      fontWeight: FontWeight.w800,
                      color: onGold,
                      letterSpacing: 0.35,
                      height: 1.15,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: onGold,
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
