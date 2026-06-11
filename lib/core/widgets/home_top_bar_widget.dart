import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/fiesta_mode_toggle_widget.dart';

class HomeTopBarWidget extends StatelessWidget {
  const HomeTopBarWidget({
    super.key,
    this.onMenuTap,
    this.greetingText,
    this.showPartyModeBanner = true,
  });

  final VoidCallback? onMenuTap;
  final String? greetingText;
  final bool showPartyModeBanner;

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
            child: greetingText?.trim().isNotEmpty == true
                ? AppText(
                    greetingText!.trim(),
                    variant: AppTextVariant.appBar,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox.shrink(),
          ),
          if (showPartyModeBanner)
            FiestaModeToggleWidget(
              isFiestaMode: themeProvider.isFiestaMode,
              onToggle: themeProvider.toggleFiestaMode,
            )
          else
            SizedBox(width: layout.iconSize + layout.spacing(16)),
        ],
      ),
    );
  }
}
