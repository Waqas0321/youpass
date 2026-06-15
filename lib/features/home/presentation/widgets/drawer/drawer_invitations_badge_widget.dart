import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class DrawerInvitationsBadgeWidget extends StatelessWidget {
  const DrawerInvitationsBadgeWidget({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    final strings = context.l10n;
    final theme = HomeDrawerTheme.of(context);
    final displayCount = count >= 100 ? 99 : count;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DrawerDesignSpec.px(context, DrawerDesignSpec.badgePaddingHorizontal),
        vertical: DrawerDesignSpec.px(context, DrawerDesignSpec.badgePaddingVertical),
      ),
      decoration: BoxDecoration(
        color: theme.invitationsBadgeBackground,
        borderRadius: BorderRadius.circular(
          DrawerDesignSpec.px(context, DrawerDesignSpec.badgeRadius),
        ),
      ),
      child: Text(
        AppStrings.drawerInvitationsNewBadge(strings, displayCount),
        style: TextStyle(
          fontSize: DrawerDesignSpec.px(context, DrawerDesignSpec.badgeFontSize),
          fontWeight: FontWeight.w600,
          color: theme.invitationsBadgeText,
          height: 1,
        ),
      ),
    );
  }
}
