import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_inline_bar_history_section.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_tool_card.dart';

class StaffSupervisorDashboardRoute extends StatelessWidget {
  const StaffSupervisorDashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorBarDashboardProvider(
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      )..loadRecentActions(limit: 20),
      child: const StaffSupervisorDashboardScreen(),
    );
  }
}

class StaffSupervisorDashboardScreen extends StatelessWidget {
  const StaffSupervisorDashboardScreen({super.key});

  static const _accent = AppColors.homeAccentYellow;

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
                layout.spacing(24),
              ),
              children: [
                AppText(
                  l10n.staffSupervisorDashboardTitle,
                  variant: AppTextVariant.headline,
                  color: _accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(22),
                  letterSpacing: 0.4,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  l10n.staffSupervisorDashboardSubtitle,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(14),
                ),
                SizedBox(height: layout.spacing(24)),
                StaffSupervisorToolCard(
                  icon: Icons.search_rounded,
                  title: l10n.staffSupervisorSearchManagePurchaseTitle,
                  lines: [
                    l10n.staffSupervisorSearchManagePurchaseLine1,
                    l10n.staffSupervisorSearchManagePurchaseLine2,
                  ],
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorCancellations,
                  ),
                ),
                SizedBox(height: layout.spacing(14)),
                StaffSupervisorToolCard(
                  icon: Icons.history_rounded,
                  title: l10n.staffSupervisorRedemptionHistoryTitle,
                  lines: [
                    l10n.staffSupervisorRedemptionHistoryLine1,
                    l10n.staffSupervisorRedemptionHistoryLine2,
                  ],
                  actionLabel: l10n.staffSupervisorGoButton,
                  onActionTap: () => Navigator.of(context).pushNamed(
                    StaffAppRoutes.supervisorBarActionHistory,
                  ),
                ),
                const StaffSupervisorInlineBarHistorySection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
