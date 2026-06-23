import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/widgets/shimmer/profile_screen_shimmer.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/widgets/youpass_confirm_dialog.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/profile/data/models/profile_banner_status_model.dart';
import 'package:youpass/features/profile/data/models/profile_notification_settings_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/data/models/support_faq_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/presentation/screens/delete_account_info_screen.dart';
import 'package:youpass/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:youpass/features/profile/presentation/utils/account_deletion_actions.dart';
import 'package:youpass/features/profile/presentation/utils/profile_photo_actions.dart';
import 'package:youpass/features/profile/presentation/utils/profile_support_actions.dart';
import 'package:youpass/features/profile/presentation/utils/profile_view_data_factory.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_footer_actions_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_footer_action_button.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_completeness_banner_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_header_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_notifications_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_personal_data_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_support_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_wallet_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';
import 'package:youpass/routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final profileApi = sl<ProfileApiService>();

  bool isLoadingProfile = false;
  bool isLoadingExtras = false;
  bool isSavingNotifications = false;
  ProfileBannerStatusModel? bannerStatus;
  ProfileNotificationSettingsModel? notificationSettings;
  List<ProfileWalletCardModel> walletCards = [];
  SupportContactModel? supportContact;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadProfile();
    });
  }

  Future<void> loadProfile() async {
    final authProvider = context.read<AuthProvider>();
    setState(() => isLoadingProfile = true);

    await authProvider.hydrateCachedUserProfile();
    if (authProvider.userProfile == null) {
      await authProvider.refreshUserProfile();
    }

    await loadExtras();

    if (mounted) {
      setState(() => isLoadingProfile = false);
    }
  }

  Future<void> loadExtras() async {
    setState(() => isLoadingExtras = true);
    try {
      final results = await Future.wait([
        profileApi.fetchBannerStatus(),
        profileApi.fetchNotificationSettings(),
        profileApi.fetchWalletCards(),
        profileApi.fetchSupportContact(),
      ]);

      if (!mounted) {
        return;
      }

      setState(() {
        bannerStatus = results[0] as ProfileBannerStatusModel;
        notificationSettings = results[1] as ProfileNotificationSettingsModel;
        walletCards = results[2] as List<ProfileWalletCardModel>;
        supportContact = results[3] as SupportContactModel;
        isLoadingExtras = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() => isLoadingExtras = false);
      }
    }
  }

  void openWalletScreen() {
    Navigator.of(context).pushNamed(AppRoutes.profileWallet).then((_) => loadExtras());
  }

  void openBenefitsScreen() {
    Navigator.of(context).pushNamed(AppRoutes.profileBenefits);
  }

  Future<void> openEditProfileScreen() async {
    final authProvider = context.read<AuthProvider>();
    final profile = authProvider.userProfile;
    if (profile == null) {
      return;
    }

    final updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => EditProfileScreen(profile: profile)),
    );

    if (updated == true && mounted) {
      await loadProfile();
    }
  }

  Future<void> handlePhotoUpdate() async {
    await ProfilePhotoActions(context).pickAndUpload();
    if (mounted) {
      await loadProfile();
    }
  }

  Future<void> dismissBanner() async {
    try {
      await profileApi.dismissBanner();
      if (mounted) {
        setState(() => bannerStatus = null);
      }
    } catch (_) {}
  }

  Future<void> toggleMasterNotifications(bool value) async {
    final previous = notificationSettings;
    if (previous != null) {
      setState(() {
        notificationSettings = previous.copyWith(masterEnabled: value);
        isSavingNotifications = true;
      });
    } else {
      setState(() => isSavingNotifications = true);
    }

    try {
      final updated = await profileApi.toggleNotificationsMaster(value);
      if (mounted) {
        setState(() {
          notificationSettings = updated;
          isSavingNotifications = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          notificationSettings = previous;
          isSavingNotifications = false;
        });
        AppSnackBar.show(
          context,
          AppStrings.profileNotificationUpdateFailed(context.l10n),
        );
      }
    }
  }

  Future<void> toggleNotificationChannel({
    required String channel,
    required bool enabled,
  }) async {
    final previous = notificationSettings;
    if (previous == null) {
      return;
    }

    final optimisticChannels = switch (channel) {
      'email' => previous.channels.copyWith(email: enabled),
      'push' => previous.channels.copyWith(push: enabled),
      'whatsapp' => previous.channels.copyWith(whatsapp: enabled),
      _ => previous.channels,
    };

    setState(() {
      notificationSettings = previous.copyWith(channels: optimisticChannels);
      isSavingNotifications = true;
    });

    try {
      final updated = await profileApi.updateNotificationSettings(
        previous.patchChannel(channel: channel, enabled: enabled),
      );
      if (mounted) {
        setState(() {
          notificationSettings = updated;
          isSavingNotifications = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          notificationSettings = previous;
          isSavingNotifications = false;
        });
        AppSnackBar.show(
          context,
          AppStrings.profileNotificationUpdateFailed(context.l10n),
        );
      }
    }
  }

  void openNotificationAdvancedSettings() {
    Navigator.of(context)
        .pushNamed(AppRoutes.profileNotificationAdvanced)
        .then((_) {
      if (mounted) {
        loadExtras();
      }
    });
  }

  Future<void> handleDeleteAccount() async {
    final profile = context.read<AuthProvider>().userProfile;
    if (profile?.isPendingDeletion == true) {
      await _handleCancelDeletion();
      return;
    }

    final proceed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => DeleteAccountInfoScreen(
          onContinue: () => Navigator.of(context).pop(true),
        ),
      ),
    );

    if (proceed != true || !mounted) {
      return;
    }

    final strings = context.l10n;
    final authenticated = await AccountDeletionActions(context).confirmWithDeviceAuth(
      AppStrings.accountDeletionBiometricReason(strings),
    );

    if (!mounted) {
      return;
    }

    if (!authenticated) {
      AppSnackBar.show(context, AppStrings.accountDeletionBiometricFailed(strings));
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final result = await authProvider.requestDeleteAccount();
    if (!mounted) {
      return;
    }

    if (result == null) {
      final message =
          authProvider.localizedErrorMessage(strings) ?? strings.errorGeneric;
      AppSnackBar.show(context, message);
      return;
    }

    Navigator.of(context).pushNamed(
      AppRoutes.verification,
      arguments: VerificationRouteArgs(
        phone: '',
        countryIsoCode: '',
        purpose: OtpPurpose.deleteAccount,
        phoneDisplay: result.phoneDisplay,
        resendCooldownSeconds: result.resendAvailableInSeconds,
        deliveryChannel: result.channel,
        statusMessage: result.message,
        prefillOtpCode: result.devOtpCode,
      ),
    );
  }

  Future<void> _handleCancelDeletion() async {
    final cancelled = await AccountDeletionActions(context).cancelPendingDeletion();
    if (!cancelled || !mounted) {
      return;
    }

    await context.read<AuthProvider>().refreshUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final authProvider = context.watch<AuthProvider>();
    final profileData = ProfileViewDataFactory.build(
      strings,
      user: authProvider.currentUser,
      profile: authProvider.userProfile,
    );
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);
    final theme = ProfileTheme.of(context);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
      ),
      body: isLoadingProfile && authProvider.userProfile == null
          ? const ProfileScreenShimmer()
          : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                0,
                horizontalPadding,
                ProfileDesignSpec.px(context, 8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeaderCardWidget(
                    data: profileData,
                    isUploadingPhoto: authProvider.isUploadingProfilePhoto,
                    onPhotoTap: handlePhotoUpdate,
                    onViewBenefitsTap: openBenefitsScreen,
                  ),
                  if (bannerStatus?.showBanner == true) ...[
                    SizedBox(height: ProfileDesignSpec.px(context, 12)),
                    ProfileCompletenessBannerWidget(
                      completionPercentage: bannerStatus!.completionPercentage,
                      missingFields: bannerStatus!.missingFields,
                      onCompleteTap: openEditProfileScreen,
                      onDismissTap: dismissBanner,
                    ),
                  ],
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.cardToSectionGap,
                    ),
                  ),
                  ProfilePersonalDataSectionWidget(
                    data: profileData,
                    onEditTap: openEditProfileScreen,
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.sectionToNextGap,
                    ),
                  ),
                  ProfileWalletSectionWidget(
                    cards: walletCards,
                    isLoading: isLoadingExtras,
                    previewMode: true,
                    onViewWalletTap: openWalletScreen,
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.sectionToNextGap,
                    ),
                  ),
                  ProfileNotificationsSectionWidget(
                    isLoading: isLoadingExtras,
                    isSaving: isSavingNotifications,
                    notificationsEnabled:
                        notificationSettings?.masterEnabled ?? true,
                    emailEnabled: notificationSettings?.emailEnabled ?? true,
                    pushEnabled: notificationSettings?.pushEnabled ?? true,
                    whatsappEnabled:
                        notificationSettings?.whatsappEnabled ?? true,
                    onMasterChanged: toggleMasterNotifications,
                    onEmailChanged: (value) => toggleNotificationChannel(
                      channel: 'email',
                      enabled: value,
                    ),
                    onPushChanged: (value) => toggleNotificationChannel(
                      channel: 'push',
                      enabled: value,
                    ),
                    onWhatsappChanged: (value) => toggleNotificationChannel(
                      channel: 'whatsapp',
                      enabled: value,
                    ),
                    onAdvancedSettingsTap: openNotificationAdvancedSettings,
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.sectionToNextGap,
                    ),
                  ),
                  if (supportContact != null &&
                      !supportContact!.isWithinBusinessHours) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(ProfileDesignSpec.px(context, 12)),
                      decoration: BoxDecoration(
                        color: theme.sectionCardBackground,
                        borderRadius: BorderRadius.circular(
                          ProfileDesignSpec.px(context, 12),
                        ),
                        border: Border.all(color: theme.sectionCardBorder),
                      ),
                      child: Text(
                        supportContact!.outsideHoursAutoReplyFor(
                          Localizations.localeOf(context).languageCode,
                        ),
                        style: TextStyle(
                          color: theme.labelText,
                          height: 1.35,
                          fontSize: ProfileDesignSpec.px(context, 13),
                        ),
                      ),
                    ),
                    SizedBox(height: ProfileDesignSpec.px(context, 12)),
                  ],
                  ProfileSupportSectionWidget(
                    onWhatsAppTap: () => ProfileSupportActions(
                      context,
                      contact: supportContact,
                    ).openWhatsApp(),
                    onEmailTap: () => ProfileSupportActions(
                      context,
                      contact: supportContact,
                    ).openEmail(),
                    onFaqTap: () => ProfileSupportActions(
                      context,
                      contact: supportContact,
                    ).openFaq(),
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.footerSectionTopGap,
                    ),
                  ),
                  ProfileFooterActionsWidget(
                    children: [
                      ProfileFooterActionButton(
                        icon: Icons.logout,
                        label: AppStrings.profileLogout(strings),
                        backgroundColor: theme.logoutButtonFill,
                        foregroundColor: theme.logoutButtonForeground,
                        borderColor: theme.logoutButtonBorder,
                        onTap: () => handleLogout(context),
                      ),
                      SizedBox(
                        height: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.footerActionGap,
                        ),
                      ),
                      ProfileFooterActionButton(
                        icon: Icons.delete_outline,
                        label: authProvider.userProfile?.isPendingDeletion == true
                            ? AppStrings.accountDeletionCancelAction(strings)
                            : AppStrings.profileDeleteAccount(strings),
                        backgroundColor: theme.deleteButtonFill,
                        foregroundColor: theme.deleteButtonForeground,
                        borderColor: theme.deleteButtonForeground,
                        onTap: handleDeleteAccount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> handleLogout(BuildContext context) async {
    final confirmed = await YouPassConfirmDialog.showLogout(context);
    if (!confirmed || !context.mounted) {
      return;
    }

    await context.read<AuthProvider>().logout();
    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }
}
