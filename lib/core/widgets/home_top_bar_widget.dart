import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_widget.dart';

class HomeTopBarWidget extends StatelessWidget {
  const HomeTopBarWidget({
    super.key,
    this.onMenuTap,
  });

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final themeProvider = context.watch<AppThemeProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(4),
        vertical: layout.spacing(8),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuTap ?? () {},
            icon: Icon(
              Icons.menu,
              color: AppColors.homeAccentYellow,
              size: layout.iconSize,
            ),
          ),
          Expanded(
            child: Center(
              child: FiestaModeToggleWidget(
                isFiestaMode: themeProvider.isFiestaMode,
                onToggle: themeProvider.toggleFiestaMode,
              ),
            ),
          ),
          SizedBox(width: layout.iconSize + layout.spacing(16)),
        ],
      ),
    );
  }
}
