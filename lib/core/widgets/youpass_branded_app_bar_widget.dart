import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';

class YouPassBrandedAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const YouPassBrandedAppBarWidget({
    super.key,
    this.screenTitle,
    this.onBack,
    this.onMenuTap,
    this.primaryColor = const Color(0xFFE69D17),
    this.backgroundColor,
    this.subtitleColor,
    this.actions,
  }) : assert(onBack != null || onMenuTap != null);

  final String? screenTitle;
  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final Color primaryColor;
  final Color? backgroundColor;
  final Color? subtitleColor;
  final List<Widget>? actions;

  double _logoWidth(BuildContext context) {
    final layout = ResponsiveLayout(context);
    // Closer to auth/login brand mark size (~50% larger than old compact).
    return (layout.width * 0.55).clamp(200.0, 280.0);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 28);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBackground =
        backgroundColor ?? theme.scaffoldBackgroundColor;
    final resolvedSubtitle =
        subtitleColor ?? theme.colorScheme.onSurfaceVariant;
    final logoWidth = _logoWidth(context);

    return AppBar(
      backgroundColor: resolvedBackground,
      surfaceTintColor: resolvedBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      leading: onBack != null
          ? IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: primaryColor,
                size: 20,
              ),
            )
          : IconButton(
              onPressed: onMenuTap,
              icon: const Icon(
                Icons.menu,
                color: AppColors.homeAccentYellow,
                size: 24,
              ),
            ),
      actions: [
        ...?actions,
        if (onBack != null && onMenuTap != null)
          IconButton(
            onPressed: onMenuTap,
            icon: const Icon(
              Icons.menu,
              color: AppColors.homeAccentYellow,
              size: 24,
            ),
          ),
      ],
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (screenTitle != null) ...[
            Text(
              screenTitle!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: resolvedSubtitle,
              ),
            ),
            const SizedBox(height: 2),
          ],
          YouPassBrandLogo(width: logoWidth),
        ],
      ),
    );
  }
}
