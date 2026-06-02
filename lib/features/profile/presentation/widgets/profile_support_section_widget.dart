import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_action_tile_widget.dart';

class ProfileSupportSectionWidget extends StatelessWidget {
  const ProfileSupportSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileSectionHeaderWidget(
          icon: Icons.headset_mic_outlined,
          title: AppStrings.profileSupport(strings),
        ),
        SizedBox(height: layout.spacing(4)),
        ProfileActionTileWidget(
          icon: Icons.chat_outlined,
          label: AppStrings.profileWhatsAppSupport(strings),
        ),
        ProfileActionTileWidget(
          icon: Icons.mail_outline,
          label: AppStrings.profileWriteEmail(strings),
        ),
        ProfileActionTileWidget(
          icon: Icons.help_outline,
          label: AppStrings.profileFaq(strings),
        ),
        SizedBox(height: layout.spacing(8)),
      ],
    );
  }
}
