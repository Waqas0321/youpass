import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/profile/data/models/profile_notification_settings_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class NotificationAdvancedSettingsScreen extends StatefulWidget {
  const NotificationAdvancedSettingsScreen({super.key});

  @override
  State<NotificationAdvancedSettingsScreen> createState() =>
      _NotificationAdvancedSettingsScreenState();
}

class _NotificationAdvancedSettingsScreenState
    extends State<NotificationAdvancedSettingsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final profileApi = sl<ProfileApiService>();

  ProfileNotificationSettingsModel? settings;
  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    setState(() => isLoading = true);
    try {
      final result = await profileApi.fetchNotificationSettings();
      if (mounted) {
        setState(() {
          settings = result;
          isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> applyPatch(
    Map<String, dynamic> patch, {
    ProfileNotificationSettingsModel? optimistic,
  }) async {
    if (settings == null) {
      return;
    }

    final previous = settings!;
    if (optimistic != null) {
      setState(() {
        settings = optimistic;
        isSaving = true;
      });
    } else {
      setState(() => isSaving = true);
    }

    try {
      final updated = await profileApi.updateNotificationSettings(patch);
      if (mounted) {
        setState(() {
          settings = updated;
          isSaving = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          settings = previous;
          isSaving = false;
        });
        AppSnackBar.show(
          context,
          AppStrings.profileNotificationUpdateFailed(context.l10n),
        );
      }
    }
  }

  Future<void> toggleTypeChannel({
    required NotificationTypeKey type,
    required String channel,
    required bool enabled,
  }) async {
    final current = settings;
    if (current == null) {
      return;
    }

    final typePrefs = current.types[type] ??
        ProfileNotificationSettingsModel.defaultForType(type);
    final updatedType = switch (channel) {
      'email' => typePrefs.copyWith(email: enabled),
      'push' => typePrefs.copyWith(push: enabled),
      'whatsapp' => typePrefs.copyWith(whatsapp: enabled),
      _ => typePrefs,
    };

    await applyPatch(
      current.patchTypeChannel(type: type, channel: channel, enabled: enabled),
      optimistic: current.copyWith(
        types: {
          ...current.types,
          type: updatedType,
        },
      ),
    );
  }

  Future<void> toggleNightSilence(bool enabled) async {
    final current = settings;
    if (current == null) {
      return;
    }

    final updatedNight = current.nightSilence.copyWith(
      enabled: enabled,
      fromHour: enabled ? (current.nightSilence.fromHour ?? 23) : null,
      clearFromHour: !enabled,
    );

    await applyPatch(
      current.patchNightSilence(updatedNight),
      optimistic: current.copyWith(nightSilence: updatedNight),
    );
  }

  Future<void> pickNightSilenceTime() async {
    final current = settings;
    if (current == null) {
      return;
    }

    final initialHour = current.nightSilence.fromHour ?? 23;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: 0),
      helpText: AppStrings.profileNotificationNightSilenceFrom(context.l10n),
    );

    if (picked == null || !mounted) {
      return;
    }

    final updatedNight = current.nightSilence.copyWith(
      enabled: true,
      fromHour: picked.hour,
    );

    await applyPatch(
      current.patchNightSilence(updatedNight),
      optimistic: current.copyWith(nightSilence: updatedNight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        title: AppStrings.profileNotificationAdvancedTitle(strings),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: theme.primary),
            )
          : settings == null
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    ProfileDesignSpec.px(context, 12),
                    horizontalPadding,
                    MediaQuery.paddingOf(context).bottom + 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.profileNotificationByType(strings),
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(context, 13),
                          fontWeight: FontWeight.w800,
                          color: theme.primary,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(height: ProfileDesignSpec.px(context, 12)),
                      for (final type in NotificationTypeKey.values) ...[
                        _TypeChannelCard(
                          title: AppStrings.profileNotificationTypeLabel(
                            strings,
                            type,
                          ),
                          preferences: settings!.types[type] ??
                              ProfileNotificationSettingsModel.defaultForType(
                                type,
                              ),
                          enabled: !isSaving,
                          onEmailChanged: (value) => toggleTypeChannel(
                            type: type,
                            channel: 'email',
                            enabled: value,
                          ),
                          onPushChanged: (value) => toggleTypeChannel(
                            type: type,
                            channel: 'push',
                            enabled: value,
                          ),
                          onWhatsappChanged: (value) => toggleTypeChannel(
                            type: type,
                            channel: 'whatsapp',
                            enabled: value,
                          ),
                        ),
                        SizedBox(height: ProfileDesignSpec.px(context, 12)),
                      ],
                      Text(
                        AppStrings.profileNotificationNightSilence(strings),
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(context, 13),
                          fontWeight: FontWeight.w800,
                          color: theme.primary,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(height: ProfileDesignSpec.px(context, 8)),
                      ProfileSectionCardWidget(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ProfileDesignSpec.px(context, 8),
                          ),
                          child: Column(
                            children: [
                              _CompactToggleRow(
                                label: AppStrings.profileNotificationNightSilence(
                                  strings,
                                ),
                                subtitle: AppStrings
                                    .profileNotificationNightSilenceDesc(strings),
                                value: settings!.nightSilence.enabled,
                                onChanged: isSaving ? null : toggleNightSilence,
                              ),
                              if (settings!.nightSilence.enabled) ...[
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: theme.rowDivider,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: ProfileDesignSpec.px(context, 4),
                                  ),
                                  title: Text(
                                    AppStrings.profileNotificationNightSilenceFrom(
                                      strings,
                                    ),
                                    style: TextStyle(
                                      fontSize: ProfileDesignSpec.px(context, 14),
                                      fontWeight: FontWeight.w600,
                                      color: theme.valueText,
                                    ),
                                  ),
                                  subtitle: Text(
                                    _formatLocalHour(
                                      context,
                                      settings!.nightSilence.fromHour ?? 23,
                                    ),
                                    style: TextStyle(
                                      fontSize: ProfileDesignSpec.px(context, 13),
                                      color: theme.labelText,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.schedule,
                                    color: theme.primary,
                                  ),
                                  onTap: isSaving ? null : pickNightSilenceTime,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: ProfileDesignSpec.px(context, 20)),
                      Text(
                        AppStrings.profileNotificationCriticalTitle(strings),
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(context, 13),
                          fontWeight: FontWeight.w800,
                          color: theme.primary,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(height: ProfileDesignSpec.px(context, 8)),
                      ProfileSectionCardWidget(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: ProfileDesignSpec.px(context, 8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final key in settings!.criticalAlwaysOn) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: ProfileDesignSpec.px(context, 10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lock_outline,
                                        size: ProfileDesignSpec.px(context, 18),
                                        color: theme.labelText,
                                      ),
                                      SizedBox(
                                        width: ProfileDesignSpec.px(context, 10),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppStrings
                                              .profileNotificationCriticalLabel(
                                            strings,
                                            key,
                                          ),
                                          style: TextStyle(
                                            fontSize: ProfileDesignSpec.px(
                                              context,
                                              14,
                                            ),
                                            fontWeight: FontWeight.w600,
                                            color: theme.valueText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (key != settings!.criticalAlwaysOn.last)
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: theme.rowDivider,
                                  ),
                              ],
                              SizedBox(height: ProfileDesignSpec.px(context, 8)),
                              Text(
                                AppStrings.profileNotificationCriticalDisclaimer(
                                  strings,
                                ),
                                style: TextStyle(
                                  fontSize: ProfileDesignSpec.px(context, 12),
                                  color: theme.labelText,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  String _formatLocalHour(BuildContext context, int hour) {
    return TimeOfDay(hour: hour, minute: 0).format(context);
  }
}

class _TypeChannelCard extends StatelessWidget {
  const _TypeChannelCard({
    required this.title,
    required this.preferences,
    required this.onEmailChanged,
    required this.onPushChanged,
    required this.onWhatsappChanged,
    this.enabled = true,
  });

  final String title;
  final NotificationChannelPreferences preferences;
  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onWhatsappChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return ProfileSectionCardWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ProfileDesignSpec.px(context, 4),
          vertical: ProfileDesignSpec.px(context, 4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ProfileDesignSpec.px(context, 8),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ProfileDesignSpec.px(context, 15),
                  fontWeight: FontWeight.w800,
                  color: theme.valueText,
                ),
              ),
            ),
            Divider(height: 1, thickness: 1, color: theme.rowDivider),
            _CompactToggleRow(
              label: AppStrings.profileNotificationChannelEmail(strings),
              value: preferences.email,
              onChanged: enabled ? onEmailChanged : null,
            ),
            Divider(height: 1, thickness: 1, color: theme.rowDivider),
            _CompactToggleRow(
              label: AppStrings.profileNotificationChannelPush(strings),
              value: preferences.push,
              onChanged: enabled ? onPushChanged : null,
            ),
            Divider(height: 1, thickness: 1, color: theme.rowDivider),
            _CompactToggleRow(
              label: AppStrings.profileNotificationChannelWhatsApp(strings),
              value: preferences.whatsapp,
              onChanged: enabled ? onWhatsappChanged : null,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactToggleRow extends StatelessWidget {
  const _CompactToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.showDivider = true,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = ProfileTheme.of(context);
    final enabled = onChanged != null;

    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ProfileDesignSpec.px(context, 8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: ProfileDesignSpec.px(context, 14),
                      fontWeight: FontWeight.w600,
                      color: theme.valueText,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: ProfileDesignSpec.px(context, 4)),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: ProfileDesignSpec.px(context, 12),
                        color: theme.labelText,
                        height: 1.35,
                      ),
                    ),
                  ],
                ],
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
      ),
    );
  }
}
