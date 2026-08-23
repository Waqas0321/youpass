import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBarWidget({
    super.key,
    this.onBack,
    this.onMenuTap,
    this.title,
    this.accentColor,
  }) : assert(onBack != null || onMenuTap != null);

  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final String? title;
  final Color? accentColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final accent = accentColor ?? theme.primary;

    return AppBar(
      backgroundColor: theme.screenBackground,
      surfaceTintColor: theme.screenBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      toolbarHeight: kToolbarHeight + 12,
      titleSpacing: 8,
      leading: onBack != null
          ? IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back,
                color: accent,
                size: ProfileDesignSpec.px(context, ProfileDesignSpec.backIconSize),
              ),
            )
          : IconButton(
              onPressed: onMenuTap,
              icon: Icon(
                Icons.menu,
                color: AppColors.homeAccentYellow,
                size: ProfileDesignSpec.px(context, ProfileDesignSpec.backIconSize),
              ),
            ),
      actions: [
        if (onBack != null && onMenuTap != null)
          IconButton(
            onPressed: onMenuTap,
            icon: Icon(
              Icons.menu,
              color: AppColors.homeAccentYellow,
              size: ProfileDesignSpec.px(context, ProfileDesignSpec.backIconSize),
            ),
          )
        else if (onBack != null)
          const SizedBox(width: kMinInteractiveDimension),
      ],
      title: Text(
        title ?? AppStrings.profileTitle(strings),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ProfileDesignSpec.px(context, ProfileDesignSpec.appBarTitleSize),
          fontWeight: FontWeight.w700,
          color: accent,
          height: 1.15,
        ),
      ),
    );
  }
}
