import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_brand_logo.dart';
import 'package:youpass/staff_app/features/auth/domain/staff_scan_permissions.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/domain/models/staff_work_mode.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/utils/staff_logout.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/open_staff_supervisor_flow.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/staff_supervisor_access.dart';

class StaffMenuDrawer extends StatelessWidget {
  const StaffMenuDrawer({super.key});

  static const _menuAccent = AppColors.homeAccentYellow;
  static const _menuIconBg = Color(0xFFFEE2E2);

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final authProvider = context.watch<StaffAuthProvider>();
    final modeProvider = context.watch<StaffWorkModeProvider>();
    final profile = authProvider.profile;
    final workMode = modeProvider.mode;
    final isAccessValidator = modeProvider.isAccessValidator;
    final canSwitchScanMode = profile?.canSwitchScanMode ?? false;
    final canScanTickets = profile?.canScanTickets ?? false;
    final canScanProducts = profile?.canScanProducts ?? false;
    final hasSupervisorForMode =
        profile?.hasSupervisorAccessForMode(workMode) ?? false;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final drawerWidth = math.min(screenWidth * 0.74, 300.0);

    return Drawer(
      width: drawerWidth,
      backgroundColor: AppColors.backgroundWhite,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            layout.spacing(16),
            layout.spacing(8),
            layout.spacing(8),
            layout.spacing(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: YouPassBrandLogo(
                          width: (drawerWidth * 0.62).clamp(140.0, 200.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.primaryMustard,
                      size: layout.spacing(28),
                    ),
                  ),
                ],
              ),
              SizedBox(height: layout.spacing(28)),
              if (hasSupervisorForMode)
                _StaffMenuTile(
                  layout: layout,
                  icon: isAccessValidator
                      ? Icons.door_front_door_outlined
                      : Icons.local_bar_outlined,
                  label: isAccessValidator
                      ? l10n.staffTicketsSupervisorMode
                      : l10n.staffBarSupervisorMode,
                  showChevron: true,
                  onTap: () {
                    final navigator = Navigator.of(context);
                    navigator.pop();
                    openStaffSupervisorFlow(navigator.context);
                  },
                ),
              if (hasSupervisorForMode &&
                  canSwitchScanMode &&
                  (canScanTickets || canScanProducts))
                SizedBox(height: layout.spacing(8)),
              if (canSwitchScanMode && canScanTickets && !isAccessValidator)
                _StaffMenuTile(
                  layout: layout,
                  icon: Icons.door_front_door_outlined,
                  label: l10n.staffAccessValidatorMenu,
                  showChevron: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    modeProvider.setMode(StaffWorkMode.accessValidator);
                  },
                ),
              if (canSwitchScanMode && canScanProducts && isAccessValidator)
                _StaffMenuTile(
                  layout: layout,
                  icon: Icons.local_bar_outlined,
                  label: l10n.staffBarMode,
                  showChevron: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    modeProvider.setMode(StaffWorkMode.bar);
                  },
                ),
              const Spacer(),
              _StaffMenuTile(
                layout: layout,
                icon: Icons.logout_rounded,
                label: l10n.staffLogout,
                onTap: () async {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  await performStaffLogout(navigator.context);
                },
              ),
              SizedBox(height: layout.spacing(12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaffMenuTile extends StatelessWidget {
  const _StaffMenuTile({
    required this.layout,
    required this.icon,
    required this.label,
    required this.onTap,
    this.showChevron = false,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(4),
            vertical: layout.spacing(10),
          ),
          child: Row(
            children: [
              Container(
                width: layout.spacing(44),
                height: layout.spacing(44),
                decoration: const BoxDecoration(
                  color: StaffMenuDrawer._menuIconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: StaffMenuDrawer._menuAccent,
                  size: layout.spacing(22),
                ),
              ),
              SizedBox(width: layout.spacing(14)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.bodyEmphasis,
                  color: StaffMenuDrawer._menuAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: layout.fontSize(16),
                ),
              ),
              if (showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  color: StaffMenuDrawer._menuAccent,
                  size: layout.spacing(24),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
