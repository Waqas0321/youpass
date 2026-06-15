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
  }) : assert(onBack != null || onMenuTap != null);

  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return AppBar(
      backgroundColor: theme.screenBackground,
      surfaceTintColor: theme.screenBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: onBack != null
          ? IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back,
                color: theme.primary,
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
          ),
      ],
      title: Text(
        title ?? AppStrings.profileTitle(strings),
        style: TextStyle(
          fontSize: ProfileDesignSpec.px(context, ProfileDesignSpec.appBarTitleSize),
          fontWeight: FontWeight.w700,
          color: theme.primary,
          height: 1.2,
        ),
      ),
    );
  }
}
