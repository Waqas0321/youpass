import 'package:flutter/material.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const EventTicketAppBarWidget({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final background = YouPassThemedColors.screenBackground(context);

    return AppBar(
      backgroundColor: background,
      surfaceTintColor: background,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: QrScreenTheme.accent(context),
          size: InvitationsDesignSpec.px(context, 24),
        ),
      ),
    );
  }
}
