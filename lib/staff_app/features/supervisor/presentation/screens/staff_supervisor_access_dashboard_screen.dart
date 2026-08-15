import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_connection_status_bar.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_session_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_access_tool_card.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

/// Supervisor dashboard for access/ticket validation — design-only tools hub.
class StaffSupervisorAccessDashboardScreen extends StatelessWidget {
  const StaffSupervisorAccessDashboardScreen({super.key});

  static const _accent = Color(0xFFE8873A);

  void _showComingSoon(BuildContext context, String feature) {
    AppSnackBar.show(context, '$feature — ${context.l10n.staffSupervisorComingSoon}');
  }

  void _exitSupervisorMode(BuildContext context) {
    context.read<StaffSupervisorSessionProvider>().lock();
    Navigator.of(context).popUntil((route) {
      return route.settings.name != StaffAppRoutes.supervisorPin &&
          route.settings.name != StaffAppRoutes.supervisorAccessDashboard;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
        children: [
          StaffScanScreenHeader(
            onBack: () => Navigator.of(context).pop(),
            showBottomDivider: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(20),
                layout.spacing(16),
                layout.spacing(20),
                layout.spacing(16),
              ),
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: _accent,
                      size: layout.spacing(24),
                    ),
                    SizedBox(width: layout.spacing(10)),
                    Expanded(
                      child: AppText(
                        l10n.staffSupervisorMode,
                        variant: AppTextVariant.headline,
                        color: _accent,
                        fontWeight: FontWeight.w800,
                        fontSize: layout.fontSize(22),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: layout.spacing(6)),
                AppText(
                  l10n.staffSupervisorAccessDashboardSubtitle,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(14),
                  height: 1.45,
                ),
                SizedBox(height: layout.spacing(24)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.search_rounded,
                  title: l10n.staffSupervisorSearchEntryTitle,
                  description: l10n.staffSupervisorSearchEntryDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorSearchEntry,
                  ),
                ),
                SizedBox(height: layout.spacing(12)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.content_copy_rounded,
                  title: l10n.staffSupervisorResolveDuplicateTitle,
                  description: l10n.staffSupervisorResolveDuplicateDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorResolveDuplicate,
                  ),
                ),
                SizedBox(height: layout.spacing(12)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.qr_code_2_rounded,
                  title: l10n.staffSupervisorQrOverrideTitle,
                  description: l10n.staffSupervisorEntryOverrideDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorEntryQrOverride,
                  ),
                ),
                SizedBox(height: layout.spacing(12)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.verified_user_outlined,
                  title: l10n.staffSupervisorEntryManualValidationTitle,
                  description: l10n.staffSupervisorEntryManualValidationDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorEntryManualValidation,
                  ),
                ),
                SizedBox(height: layout.spacing(12)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.star_outline_rounded,
                  title: l10n.staffSupervisorVipManagementTitle,
                  description: l10n.staffSupervisorVipManagementDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorVipManagement,
                  ),
                ),
                SizedBox(height: layout.spacing(12)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.monitor_heart_outlined,
                  title: l10n.staffSupervisorSystemStatusTitle,
                  description: l10n.staffSupervisorSystemStatusDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorSystemStatus,
                  ),
                ),
                SizedBox(height: layout.spacing(12)),
                StaffSupervisorAccessToolCard(
                  icon: Icons.history_rounded,
                  title: l10n.staffSupervisorActionHistoryTitle,
                  description: l10n.staffSupervisorActionHistoryDescription,
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorActionHistory,
                  ),
                ),
                SizedBox(height: layout.spacing(24)),
                OutlinedButton.icon(
                  onPressed: () => _exitSupervisorMode(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondaryGrey,
                    side: const BorderSide(color: AppColors.homeDividerGrey),
                    padding: EdgeInsets.symmetric(vertical: layout.spacing(14)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(layout.radius(14)),
                    ),
                  ),
                  icon: Icon(Icons.logout_rounded, size: layout.spacing(20)),
                  label: AppText(
                    l10n.staffSupervisorExitModeButton,
                    variant: AppTextVariant.button,
                    color: AppColors.secondaryGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(14),
                  ),
                ),
              ],
            ),
          ),
          StaffConnectionStatusBar(
            validatorLabel: l10n.staffSupervisorValidatorLabel('VAL-AC-02'),
          ),
        ],
      ),
    );
  }
}
