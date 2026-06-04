import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/widgets/shimmer/profile_screen_shimmer.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/widgets/youpass_confirm_dialog.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/profile/presentation/utils/profile_photo_actions.dart';
import 'package:youpass/features/profile/presentation/utils/profile_view_data_factory.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_action_tile_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_header_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_notifications_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_personal_data_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_support_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_wallet_section_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationsEnabled = true;
  bool isLoadingProfile = false;

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
    if (mounted) {
      setState(() => isLoadingProfile = false);
    }
  }

  void openWalletScreen() {
    Navigator.of(context).pushNamed(AppRoutes.profileWallet);
  }

  Future<void> handlePhotoUpdate() async {
    await ProfilePhotoActions(context).pickAndUploadFromGallery();
  }

  Future<void> handleDeleteAccount() async {
    final confirmed = await YouPassConfirmDialog.showDeleteAccount(context);
    if (!confirmed || !mounted) {
      return;
    }

    final strings = context.l10n;
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
      ),
    );
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

    return Scaffold(
      backgroundColor: ProfileDesignSpec.screenBackground,
      appBar: ProfileAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
      ),
      body: isLoadingProfile && authProvider.userProfile == null
          ? const ProfileScreenShimmer()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileHeaderCardWidget(
                    data: profileData,
                    isUploadingPhoto: authProvider.isUploadingProfilePhoto,
                    onHeaderTap: openWalletScreen,
                    onPhotoTap: handlePhotoUpdate,
                    onViewBenefitsTap: openWalletScreen,
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.cardToSectionGap,
                    ),
                  ),
                  ProfilePersonalDataSectionWidget(data: profileData),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.sectionToNextGap,
                    ),
                  ),
                  ProfileWalletSectionWidget(
                    onViewWalletTap: openWalletScreen,
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.sectionToNextGap,
                    ),
                  ),
                  ProfileNotificationsSectionWidget(
                    notificationsEnabled: notificationsEnabled,
                    onChanged: (value) =>
                        setState(() => notificationsEnabled = value),
                  ),
                  SizedBox(
                    height: ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.sectionToNextGap,
                    ),
                  ),
                  const ProfileSupportSectionWidget(),
                  SizedBox(height: ProfileDesignSpec.px(context, 16)),
                  ProfileActionTileWidget(
                    icon: Icons.logout,
                    label: AppStrings.profileLogout(strings),
                    onTap: () => handleLogout(context),
                  ),
                  ProfileActionTileWidget(
                    icon: Icons.delete_outline,
                    label: AppStrings.profileDeleteAccount(strings),
                    onTap: handleDeleteAccount,
                  ),
                  SizedBox(height: ProfileDesignSpec.px(context, 24)),
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
