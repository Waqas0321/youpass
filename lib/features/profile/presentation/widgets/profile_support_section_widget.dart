import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_action_tile_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_header_widget.dart';

class ProfileSupportSectionWidget extends StatelessWidget {
  const ProfileSupportSectionWidget({
    super.key,
    this.onWhatsAppTap,
    this.onEmailTap,
    this.onFaqTap,
  });

  final VoidCallback? onWhatsAppTap;
  final VoidCallback? onEmailTap;
  final VoidCallback? onFaqTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileSectionHeaderWidget(
          icon: Icons.headset_mic_outlined,
          title: AppStrings.profileSupport(strings),
        ),
        SizedBox(height: ProfileDesignSpec.px(context, 12)),
        ProfileSectionCardWidget(
          padding: EdgeInsets.symmetric(
            horizontal: ProfileDesignSpec.px(context, 12),
            vertical: ProfileDesignSpec.px(context, 2),
          ),
          child: Column(
            children: [
              ProfileActionTileWidget(
                icon: Icons.chat_outlined,
                label: AppStrings.profileWhatsAppSupport(strings),
                onTap: onWhatsAppTap,
                useIconBadge: true,
                showDivider: true,
                labelColor: theme.valueText,
                chevronColor: theme.chevronMuted,
              ),
              ProfileActionTileWidget(
                icon: Icons.mail_outline,
                label: AppStrings.profileWriteEmail(strings),
                onTap: onEmailTap,
                useIconBadge: true,
                showDivider: true,
                labelColor: theme.valueText,
                chevronColor: theme.chevronMuted,
              ),
              ProfileActionTileWidget(
                icon: Icons.help_outline,
                label: AppStrings.profileFaq(strings),
                onTap: onFaqTap,
                useIconBadge: true,
                showDivider: false,
                labelColor: theme.valueText,
                chevronColor: theme.chevronMuted,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
