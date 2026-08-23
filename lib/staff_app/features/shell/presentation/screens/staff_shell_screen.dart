import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_exit_guard.dart';
import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/auth/domain/staff_scan_permissions.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_work_mode.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/screens/staff_access_validator_screen.dart';
import 'package:youpass/staff_app/features/home/presentation/screens/staff_home_screen.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/sync_staff_work_mode.dart';

class StaffShellScreen extends StatefulWidget {
  const StaffShellScreen({super.key});

  @override
  State<StaffShellScreen> createState() => _StaffShellScreenState();
}

class _StaffShellScreenState extends State<StaffShellScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProfileAndSyncMode();
    });
  }

  Future<void> _refreshProfileAndSyncMode() async {
    final authProvider = context.read<StaffAuthProvider>();
    await authProvider.refreshProfile();
    if (!mounted) {
      return;
    }
    syncStaffWorkModeFromAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppExitGuard(
      child: Consumer2<StaffAuthProvider, StaffWorkModeProvider>(
        builder: (context, authProvider, modeProvider, _) {
          final profile = authProvider.profile;

          if (profile == null || !profile.hasAnyScanAccess) {
            return const _StaffNoScanAccessScreen();
          }

          if (!profile.isWorkModeAllowed(modeProvider.mode)) {
            return profile.canScanProducts
                ? const StaffHomeScreen()
                : const StaffAccessValidatorScreen();
          }

          switch (modeProvider.mode) {
            case StaffWorkMode.accessValidator:
              return const StaffAccessValidatorScreen();
            case StaffWorkMode.bar:
              return const StaffHomeScreen();
          }
        },
      ),
    );
  }
}

class _StaffNoScanAccessScreen extends StatelessWidget {
  const _StaffNoScanAccessScreen();

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(layout.spacing(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: layout.spacing(48),
                  color: AppColors.primaryMustard,
                ),
                SizedBox(height: layout.spacing(16)),
                AppText(
                  l10n.staffNoScanAccessTitle,
                  variant: AppTextVariant.headline,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(20),
                ),
                SizedBox(height: layout.spacing(8)),
                AppText(
                  l10n.staffNoScanAccessSubtitle,
                  variant: AppTextVariant.body,
                  textAlign: TextAlign.center,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
