import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_header_widget.dart';

class ProfileNotificationsSectionWidget extends StatelessWidget {
  const ProfileNotificationsSectionWidget({
    super.key,
    required this.notificationsEnabled,
    required this.onChanged,
  });

  final bool notificationsEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileSectionHeaderWidget(
          icon: Icons.notifications_outlined,
          title: AppStrings.profileNotifications(strings),
        ),
        SizedBox(height: layout.spacing(12)),
        Row(
          children: [
            Expanded(
              child: AppText(
                AppStrings.profileReceiveNotifications(strings),
                variant: AppTextVariant.bodyEmphasis,
                fontSize: layout.fontSize(15),
              ),
            ),
            Switch(
              value: notificationsEnabled,
              onChanged: onChanged,
              activeThumbColor: AppColors.backgroundWhite,
              activeTrackColor: AppColors.primaryMustard,
              inactiveThumbColor: AppColors.backgroundWhite,
              inactiveTrackColor: AppColors.lightGreyBorder,
            ),
          ],
        ),
        SizedBox(height: layout.spacing(8)),
        AppText(
          AppStrings.profileNotificationChannels(strings),
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(12),
        ),
      ],
    );
  }
}
