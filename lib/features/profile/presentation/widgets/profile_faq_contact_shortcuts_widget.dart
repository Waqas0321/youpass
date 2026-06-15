import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_outline_button.dart';
import 'package:youpass/features/profile/data/models/support_faq_model.dart';
import 'package:youpass/features/profile/presentation/utils/profile_support_actions.dart';

class ProfileFaqContactShortcutsWidget extends StatelessWidget {
  const ProfileFaqContactShortcutsWidget({
    super.key,
    this.contact,
    this.sourceContext = 'FAQ',
  });

  final SupportContactModel? contact;
  final String sourceContext;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final actions = ProfileSupportActions(
      context,
      contact: contact,
      sourceContext: sourceContext,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YouPassOutlineButton(
          label: AppStrings.profileFaqContactWhatsApp(strings),
          icon: Icons.chat_outlined,
          onPressed: actions.openWhatsApp,
        ),
        const SizedBox(height: 10),
        YouPassOutlineButton(
          label: AppStrings.profileFaqContactEmail(strings),
          icon: Icons.mail_outline,
          onPressed: actions.openEmail,
        ),
      ],
    );
  }
}
