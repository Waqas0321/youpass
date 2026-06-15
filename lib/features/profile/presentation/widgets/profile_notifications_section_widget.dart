import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/notification_channel_toggle_row.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileNotificationsSectionWidget extends StatelessWidget {
  const ProfileNotificationsSectionWidget({
    super.key,
    required this.notificationsEnabled,
    required this.onMasterChanged,
    required this.emailEnabled,
    required this.pushEnabled,
    required this.whatsappEnabled,
    required this.onEmailChanged,
    required this.onPushChanged,
    required this.onWhatsappChanged,
    required this.onAdvancedSettingsTap,
    this.isLoading = false,
    this.isSaving = false,
  });

  final bool notificationsEnabled;
  final ValueChanged<bool> onMasterChanged;
  final bool emailEnabled;
  final bool pushEnabled;
  final bool whatsappEnabled;
  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onWhatsappChanged;
  final VoidCallback onAdvancedSettingsTap;
  final bool isLoading;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final channelsEnabled = notificationsEnabled && !isSaving;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileSectionHeaderWidget(
          icon: Icons.notifications_outlined,
          title: AppStrings.profileNotifications(strings),
        ),
        SizedBox(height: ProfileDesignSpec.px(context, 12)),
        if (isLoading)
          ProfileSectionCardWidget(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ProfileDesignSpec.px(context, 20),
              ),
              child: Center(
                child: SizedBox(
                  width: ProfileDesignSpec.px(context, 24),
                  height: ProfileDesignSpec.px(context, 24),
                  child: CircularProgressIndicator(
                    color: theme.primary,
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            ),
          )
        else
          ProfileSectionCardWidget(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ProfileDesignSpec.px(context, 4),
                vertical: ProfileDesignSpec.px(context, 8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _MasterSwitchRow(
                    value: notificationsEnabled,
                    onChanged: isSaving ? null : onMasterChanged,
                  ),
                  Divider(height: 1, thickness: 1, color: theme.rowDivider),
                  NotificationChannelToggleRow(
                    title: AppStrings.profileNotificationChannelEmail(strings),
                    subtitle:
                        AppStrings.profileNotificationChannelEmailDesc(strings),
                    icon: Icons.mail_outline,
                    value: emailEnabled,
                    enabled: channelsEnabled,
                    onChanged: channelsEnabled ? onEmailChanged : null,
                  ),
                  NotificationChannelToggleRow(
                    title: AppStrings.profileNotificationChannelPush(strings),
                    subtitle:
                        AppStrings.profileNotificationChannelPushDesc(strings),
                    icon: Icons.smartphone_outlined,
                    value: pushEnabled,
                    enabled: channelsEnabled,
                    onChanged: channelsEnabled ? onPushChanged : null,
                  ),
                  NotificationChannelToggleRow(
                    title:
                        AppStrings.profileNotificationChannelWhatsApp(strings),
                    subtitle: AppStrings.profileNotificationChannelWhatsAppDesc(
                      strings,
                    ),
                    icon: Icons.chat_outlined,
                    value: whatsappEnabled,
                    enabled: channelsEnabled,
                    onChanged: channelsEnabled ? onWhatsappChanged : null,
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: ProfileDesignSpec.px(context, 10)),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: isLoading ? null : onAdvancedSettingsTap,
            icon: Icon(
              Icons.tune,
              size: ProfileDesignSpec.px(context, 18),
              color: theme.primary,
            ),
            label: Text(
              AppStrings.profileNotificationAdvancedSettings(strings),
              style: TextStyle(
                fontSize: ProfileDesignSpec.px(context, 14),
                fontWeight: FontWeight.w700,
                color: theme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MasterSwitchRow extends StatelessWidget {
  const _MasterSwitchRow({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ProfileDesignSpec.px(context, 10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.profileReceiveNotifications(strings),
              style: TextStyle(
                fontSize: ProfileDesignSpec.px(context, 15),
                fontWeight: FontWeight.w800,
                color: theme.valueText,
                height: 1.2,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: theme.switchThumbColor,
            activeTrackColor: theme.primary,
            inactiveThumbColor: theme.switchThumbColor,
            inactiveTrackColor: theme.switchInactiveTrack,
          ),
        ],
      ),
    );
  }
}
