import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class ProfileAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBarWidget({
    super.key,
    required this.onBack,
    this.title,
  });

  final VoidCallback onBack;
  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: ProfileDesignSpec.primary,
          size: ProfileDesignSpec.px(context, ProfileDesignSpec.backIconSize),
        ),
      ),
      title: Text(
        title ?? AppStrings.profileTitle(strings),
        style: TextStyle(
          fontSize: ProfileDesignSpec.px(context, ProfileDesignSpec.appBarTitleSize),
          fontWeight: FontWeight.w700,
          color: ProfileDesignSpec.primary,
          height: 1.2,
        ),
      ),
    );
  }
}
