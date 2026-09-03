import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_recent_actions_section.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_tool_card.dart';

class StaffSupervisorDashboardRoute extends StatelessWidget {
  const StaffSupervisorDashboardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorBarDashboardProvider(
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      )..loadRecentActions(),
      child: const StaffSupervisorDashboardScreen(),
    );
  }
}

class StaffSupervisorDashboardScreen extends StatelessWidget {
  const StaffSupervisorDashboardScreen({super.key});

  static const _accent = AppColors.homeAccentYellow;

  String _titleForEntry(dynamic l10n, StaffSupervisorBarActionHistoryEntry entry) {
    switch (entry.result) {
      case StaffSupervisorRedemptionResult.redeemed:
        return l10n.staffSupervisorRedemptionResultRedeemed;
      case StaffSupervisorRedemptionResult.restored:
        return l10n.staffSupervisorRedemptionResultRestored;
      case StaffSupervisorRedemptionResult.duplicateAttempt:
        return l10n.staffSupervisorRedemptionResultDuplicate;
      case StaffSupervisorRedemptionResult.supervisor:
        return l10n.staffSupervisorRedemptionResultSupervisor;
      case StaffSupervisorRedemptionResult.unknown:
        switch (entry.kind) {
          case 'cancel_consumption':
            return l10n.staffSupervisorActionConsumptionCancelled;
          case 'release_qr':
          case 'release_blocked_qr':
            return l10n.staffSupervisorActionQrReleased;
          default:
            return entry.kind.replaceAll('_', ' ');
        }
    }
  }

  List<StaffSupervisorAction> _recentActions(
    dynamic l10n,
    StaffSupervisorBarDashboardProvider provider,
  ) {
    return provider.history?.actions
            .take(3)
            .map(
              (entry) => StaffSupervisorAction(
                type: entry.actionType,
                title: _titleForEntry(l10n, entry),
                timeLabel: entry.timeLabel,
              ),
            )
            .toList() ??
        const [];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorBarDashboardProvider>(
      builder: (context, provider, _) {
        // final latest = provider.history?.actions.firstOrNull;

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
                    // Target menu: SEARCH / MANAGE PURCHASE + REDEMPTION HISTORY only.
                    StaffSupervisorToolCard(
                      icon: Icons.search_rounded,
                      title: l10n.staffSupervisorSearchManagePurchaseTitle,
                      lines: [
                        l10n.staffSupervisorSearchManagePurchaseLine1,
                        l10n.staffSupervisorSearchManagePurchaseLine2,
                      ],
                      actionLabel: l10n.staffSupervisorGoButton,
                      // Reuses existing drink search + restore/revert tools.
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
                    // PREVIOUS top-level tools (commented out — screens kept):
                    // StaffSupervisorToolCard(
                    //   icon: Icons.warning_amber_rounded,
                    //   title: l10n.staffSupervisorCancellationsTitle,
                    //   ...
                    // ),
                    // StaffSupervisorToolCard(
                    //   icon: Icons.check_circle_outline_rounded,
                    //   title: l10n.staffSupervisorManualValidationTitle,
                    //   ...
                    // ),
                    // StaffSupervisorToolCard(
                    //   icon: Icons.lock_outline_rounded,
                    //   title: l10n.staffSupervisorQrOverrideTitle,
                    //   ...
                    // ),
                    SizedBox(height: layout.spacing(28)),
                    if (provider.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      StaffSupervisorRecentActionsSection(
                        actions: _recentActions(l10n, provider),
                        onViewAllTap: () => Navigator.of(context).pushNamed(
                          StaffAppRoutes.supervisorBarActionHistory,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
