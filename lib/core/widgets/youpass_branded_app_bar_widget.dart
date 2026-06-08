import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';

class YouPassBrandedAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const YouPassBrandedAppBarWidget({
    super.key,
    this.screenTitle,
    required this.onBack,
    this.primaryColor = const Color(0xFFE69D17),
    this.backgroundColor,
    this.subtitleColor,
    this.actions,
  });

  final String? screenTitle;
  final VoidCallback onBack;
  final Color primaryColor;
  final Color? backgroundColor;
  final Color? subtitleColor;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(
        screenTitle == null ? kToolbarHeight : kToolbarHeight + 12,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedBackground =
        backgroundColor ?? theme.scaffoldBackgroundColor;
    final resolvedSubtitle =
        subtitleColor ?? theme.colorScheme.onSurfaceVariant;

    return AppBar(
      backgroundColor: resolvedBackground,
      surfaceTintColor: resolvedBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(Icons.arrow_back, color: primaryColor, size: 24),
      ),
      actions: actions,
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
          const YouPassLogo(),
        ],
      ),
    );
  }
}
