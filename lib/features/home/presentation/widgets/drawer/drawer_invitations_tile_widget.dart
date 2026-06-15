import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_invitations_badge_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_sparkle_icons_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class DrawerInvitationsTileWidget extends StatefulWidget {
  const DrawerInvitationsTileWidget({
    super.key,
    required this.label,
    required this.badgeCount,
    required this.onTap,
  });

  final String label;
  final int badgeCount;
  final VoidCallback onTap;

  @override
  State<DrawerInvitationsTileWidget> createState() =>
      _DrawerInvitationsTileWidgetState();
}

class _DrawerInvitationsTileWidgetState extends State<DrawerInvitationsTileWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _glow = Tween<double>(begin: 0.22, end: 0.42).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    if (widget.badgeCount > 0) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant DrawerInvitationsTileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.badgeCount > 0 && !_glowController.isAnimating) {
      _glowController.repeat(reverse: true);
    } else if (widget.badgeCount <= 0 && _glowController.isAnimating) {
      _glowController.stop();
      _glowController.reset();
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = HomeDrawerTheme.of(context);
    final radius = DrawerDesignSpec.px(context, DrawerDesignSpec.menuTileRadius);
    final hasPending = widget.badgeCount > 0;
    final fillAlpha = theme.isDark ? 1.0 : (hasPending ? 0.22 + _glow.value : 0.18);
    final borderAlpha = theme.isDark
        ? (hasPending ? 0.55 + _glow.value : 0.4)
        : (hasPending ? 0.45 + _glow.value : 0.35);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(radius),
        child: AnimatedBuilder(
          animation: _glow,
          builder: (context, child) {
            return Ink(
              decoration: BoxDecoration(
                color: theme.isDark
                    ? theme.invitationsBackground
                    : theme.invitationsBackground.withValues(alpha: fillAlpha),
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  color: theme.invitationsBorder.withValues(alpha: borderAlpha),
                  width: hasPending ? 1.25 : 1,
                ),
                boxShadow: hasPending && !theme.isDark
                    ? [
                        BoxShadow(
                          color: theme.gold.withValues(alpha: _glow.value),
                          blurRadius: DrawerDesignSpec.px(context, 14),
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: child,
            );
          },
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
                  primaryColor: theme.gold,
                  secondaryColor: theme.goldSecondary,
                ),
                SizedBox(
                  width: DrawerDesignSpec.px(
                    context,
                    DrawerDesignSpec.menuIconToTextGap,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.invitationsMenuTitleFontSize,
                      ),
                      fontWeight: FontWeight.w800,
                      color: theme.invitationsTitle,
                      letterSpacing: 0.35,
                      height: 1.15,
                    ),
                  ),
                ),
                DrawerInvitationsBadgeWidget(count: widget.badgeCount),
                if (widget.badgeCount > 0)
                  SizedBox(
                    width: DrawerDesignSpec.px(
                      context,
                      DrawerDesignSpec.badgeToChevronGap,
                    ),
                  ),
                Icon(
                  Icons.chevron_right,
                  color: theme.invitationsTitle,
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
