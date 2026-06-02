import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
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
    final strings = context.l10n;

    return AppBar(
      backgroundColor: InvitationsDesignSpec.screenBackground,
      surfaceTintColor: InvitationsDesignSpec.screenBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back,
          color: InvitationsDesignSpec.primary,
          size: InvitationsDesignSpec.px(context, 24),
        ),
      ),
      title: Text(
        AppStrings.eventTicketScreenTitle(strings),
        style: TextStyle(
          fontSize: InvitationsDesignSpec.px(context, 16),
          fontWeight: FontWeight.w700,
          color: InvitationsDesignSpec.titleText,
        ),
      ),
    );
  }
}
