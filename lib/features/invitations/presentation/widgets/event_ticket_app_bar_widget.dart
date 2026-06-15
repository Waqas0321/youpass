import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const EventTicketAppBarWidget({
    super.key,
    required this.onBack,
    this.onMenuTap,
  });

  final VoidCallback onBack;
  final VoidCallback? onMenuTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final background = YouPassThemedColors.screenBackground(context);

    return AppBar(
      backgroundColor: background,
      surfaceTintColor: background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: QrScreenTheme.accent(context),
          size: InvitationsDesignSpec.px(context, 24),
        ),
      ),
      title: Text(
        AppStrings.eventTicketScreenTitle(strings),
        style: TextStyle(
          fontSize: InvitationsDesignSpec.px(context, 16),
          fontWeight: FontWeight.w700,
          color: QrScreenTheme.accent(context),
        ),
      ),
      actions: [
        if (onMenuTap != null)
          IconButton(
            onPressed: onMenuTap,
            icon: Icon(
              Icons.menu,
              color: AppColors.homeAccentYellow,
              size: InvitationsDesignSpec.px(context, 24),
            ),
          ),
      ],
    );
  }
}
