import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_system_status_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_system_status_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_access_scaffold.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_pin_confirm_dialog.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_system_status_components.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class StaffSupervisorSystemStatusRoute extends StatelessWidget {
  const StaffSupervisorSystemStatusRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorSystemStatusProvider(
        genericError: l10n.staffSupervisorSystemLoadError,
      )..initialize(),
      child: const StaffSupervisorSystemStatusScreen(),
    );
  }
}

/// System status monitoring — operational dashboard for supervisors.
class StaffSupervisorSystemStatusScreen extends StatefulWidget {
  const StaffSupervisorSystemStatusScreen({super.key});

  @override
  State<StaffSupervisorSystemStatusScreen> createState() =>
      _StaffSupervisorSystemStatusScreenState();
}

class _StaffSupervisorSystemStatusScreenState
    extends State<StaffSupervisorSystemStatusScreen> {
  static const _quickActions = [
    StaffSupervisorQuickActionKind.offlineMode,
    StaffSupervisorQuickActionKind.pauseValidations,
    StaffSupervisorQuickActionKind.manualAccess,
    StaffSupervisorQuickActionKind.blockVip,
    StaffSupervisorQuickActionKind.staffAlert,
  ];

  String _generalHealthLabel(dynamic l10n, StaffSupervisorGeneralHealthKind kind) {
    return switch (kind) {
      StaffSupervisorGeneralHealthKind.system =>
        l10n.staffSupervisorSystemHealthSystem,
      StaffSupervisorGeneralHealthKind.sync =>
        l10n.staffSupervisorSystemHealthSync,
      StaffSupervisorGeneralHealthKind.database =>
        l10n.staffSupervisorSystemHealthDatabase,
      StaffSupervisorGeneralHealthKind.offlineMode =>
        l10n.staffSupervisorSystemHealthOfflineMode,
    };
  }

  String _generalStatusLabel(
    dynamic l10n,
    StaffSupervisorSystemHealthStatus status,
  ) {
    return switch (status) {
      StaffSupervisorSystemHealthStatus.online =>
        l10n.staffSupervisorSystemStatusOnline,
      StaffSupervisorSystemHealthStatus.slow =>
        l10n.staffSupervisorSystemStatusSlowSync,
      StaffSupervisorSystemHealthStatus.operational =>
        l10n.staffSupervisorSystemStatusOperational,
      StaffSupervisorSystemHealthStatus.disabled =>
        l10n.staffSupervisorSystemStatusDisabled,
      StaffSupervisorSystemHealthStatus.disconnected =>
        l10n.staffSupervisorSystemStatusDisconnected,
    };
  }

  String _scannerStatusLabel(
    dynamic l10n,
    StaffSupervisorSystemHealthStatus status,
  ) {
    return switch (status) {
      StaffSupervisorSystemHealthStatus.online =>
        l10n.staffSupervisorSystemStatusOnline,
      StaffSupervisorSystemHealthStatus.slow =>
        l10n.staffSupervisorSystemStatusSlowScanner,
      StaffSupervisorSystemHealthStatus.operational =>
        l10n.staffSupervisorSystemStatusOperational,
      StaffSupervisorSystemHealthStatus.disabled =>
        l10n.staffSupervisorSystemStatusDisabled,
      StaffSupervisorSystemHealthStatus.disconnected =>
        l10n.staffSupervisorSystemStatusDisconnected,
    };
  }

  String _alertLabel(dynamic l10n, StaffSupervisorSystemAlertKind kind) {
    return switch (kind) {
      StaffSupervisorSystemAlertKind.duplicateQr =>
        l10n.staffSupervisorSystemAlertDuplicateQr,
      StaffSupervisorSystemAlertKind.vipQueueSaturated =>
        l10n.staffSupervisorSystemAlertVipQueue,
      StaffSupervisorSystemAlertKind.scannerSlow =>
        l10n.staffSupervisorSystemAlertScannerSlow,
    };
  }

  String _flowLabel(dynamic l10n, StaffSupervisorEventFlowKind kind) {
    return switch (kind) {
      StaffSupervisorEventFlowKind.general =>
        l10n.staffSupervisorSystemFlowGeneral,
      StaffSupervisorEventFlowKind.vip => l10n.staffSupervisorSystemFlowVip,
      StaffSupervisorEventFlowKind.backstage =>
        l10n.staffSupervisorSystemFlowBackstage,
      StaffSupervisorEventFlowKind.rejected =>
        l10n.staffSupervisorSystemFlowRejected,
      StaffSupervisorEventFlowKind.duplicates =>
        l10n.staffSupervisorSystemFlowDuplicates,
    };
  }

  String _actionLabel(
    dynamic l10n,
    StaffSupervisorQuickActionKind kind,
    StaffSupervisorSystemStatusResult result,
  ) {
    return switch (kind) {
      StaffSupervisorQuickActionKind.offlineMode =>
        result.offlineModeEnabled
            ? l10n.staffSupervisorSystemActionDeactivateOfflineMode
            : l10n.staffSupervisorSystemActionOfflineMode,
      StaffSupervisorQuickActionKind.pauseValidations =>
        result.validationsPaused
            ? l10n.staffSupervisorSystemActionResumeValidations
            : l10n.staffSupervisorSystemActionPauseValidations,
      StaffSupervisorQuickActionKind.manualAccess =>
        l10n.staffSupervisorSystemActionManualAccess,
      StaffSupervisorQuickActionKind.blockVip =>
        result.vipAccessBlocked
            ? l10n.staffSupervisorSystemActionUnblockVip
            : l10n.staffSupervisorSystemActionBlockVip,
      StaffSupervisorQuickActionKind.staffAlert =>
        l10n.staffSupervisorSystemActionStaffAlert,
    };
  }

  String _logLabel(dynamic l10n, StaffSupervisorSystemLogKind kind) {
    return switch (kind) {
      StaffSupervisorSystemLogKind.offlineActivated =>
        l10n.staffSupervisorSystemLogOfflineActivated,
      StaffSupervisorSystemLogKind.offlineDeactivated =>
        l10n.staffSupervisorSystemLogOfflineDeactivated,
      StaffSupervisorSystemLogKind.validationsPaused =>
        l10n.staffSupervisorSystemLogValidationsPaused,
      StaffSupervisorSystemLogKind.validationsResumed =>
        l10n.staffSupervisorSystemLogValidationsResumed,
      StaffSupervisorSystemLogKind.vipBlocked =>
        l10n.staffSupervisorSystemLogVipBlocked,
      StaffSupervisorSystemLogKind.overrideAuthorized =>
        l10n.staffSupervisorSystemLogOverrideAuthorized,
      StaffSupervisorSystemLogKind.scannerRestarted =>
        l10n.staffSupervisorSystemLogScannerRestarted,
      StaffSupervisorSystemLogKind.duplicateDetected =>
        l10n.staffSupervisorSystemLogDuplicateDetected,
      StaffSupervisorSystemLogKind.staffAlert =>
        l10n.staffSupervisorSystemLogStaffAlert,
    };
  }

  String _riskReasonText(dynamic l10n, String? key) {
    return switch (key) {
      'duplicate_qr' => l10n.staffSupervisorSystemRiskReasonDuplicateQr,
      'scanner_slow' => l10n.staffSupervisorSystemRiskReasonScannerSlow,
      'validations_paused' =>
        l10n.staffSupervisorSystemRiskReasonValidationsPaused,
      _ => l10n.staffSupervisorSystemRiskReasonVipFlow,
    };
  }

  Future<void> _promptPinAndApplyAction(
    BuildContext context,
    StaffSupervisorSystemStatusProvider provider,
    StaffSupervisorQuickActionKind action,
  ) async {
    final l10n = context.l10n;
    final requiresNotes = action == StaffSupervisorQuickActionKind.staffAlert;

    final result = await showStaffSupervisorPinConfirmDialog(
      context: context,
      title: _actionLabel(l10n, action, provider.status!),
      pinLabel: l10n.staffSupervisorSystemPinRequired,
      confirmLabel: l10n.staffSupervisorSystemDialogConfirm,
      cancelLabel: l10n.confirmDialogCancel,
      notesLabel: l10n.staffSupervisorSystemAlertMessageLabel,
      notesPlaceholder: l10n.staffSupervisorSystemAlertMessagePlaceholder,
      requireNotes: requiresNotes,
    );

    if (result == null || !context.mounted) {
      return;
    }

    final success = await provider.applyQuickAction(
      action: action,
      pin: result.pin,
      notes: result.notes,
    );

    if (!context.mounted) {
      return;
    }

    if (success) {
      AppSnackBar.showSuccess(context, l10n.staffSupervisorSystemActionSuccess);
    } else if (provider.actionError != null) {
      AppSnackBar.show(context, provider.actionError!);
    }
  }

  Future<void> _promptPinAndRestartScanner(
    BuildContext context,
    StaffSupervisorSystemStatusProvider provider,
  ) async {
    final l10n = context.l10n;

    final result = await showStaffSupervisorPinConfirmDialog(
      context: context,
      title: l10n.staffSupervisorSystemRestartScannerButton,
      pinLabel: l10n.staffSupervisorSystemPinRequired,
      confirmLabel: l10n.staffSupervisorSystemDialogConfirm,
      cancelLabel: l10n.confirmDialogCancel,
    );

    if (result == null || !context.mounted) {
      return;
    }

    final success = await provider.restartScanner(pin: result.pin);

    if (!context.mounted) {
      return;
    }

    if (success) {
      AppSnackBar.showSuccess(context, l10n.staffSupervisorSystemActionSuccess);
    } else if (provider.actionError != null) {
      AppSnackBar.show(context, provider.actionError!);
    }
  }

  void _handleQuickAction(
    BuildContext context,
    StaffSupervisorSystemStatusProvider provider,
    StaffSupervisorQuickActionKind action,
  ) {
    if (action == StaffSupervisorQuickActionKind.manualAccess) {
      Navigator.of(context).pushNamed(StaffAppRoutes.supervisorEntryManualValidation);
      return;
    }

    _promptPinAndApplyAction(context, provider, action);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorSystemStatusProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.loadError != null || provider.status == null) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(layout.spacing(24)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      provider.loadError ?? l10n.staffSupervisorSystemLoadError,
                      variant: AppTextVariant.body,
                      textAlign: TextAlign.center,
                      color: AppColors.secondaryGrey,
                    ),
                    SizedBox(height: layout.spacing(16)),
                    FilledButton(
                      onPressed: provider.isRefreshing
                          ? null
                          : () => provider.loadStatus(),
                      child: Text(l10n.staffSupervisorSystemRetry),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final result = provider.status!;
        final gap = layout.spacing(14);
        final isWide = layout.isTablet;

        Widget statusCards() {
          final general = StaffSupervisorGeneralStatusCard(
            title: l10n.staffSupervisorSystemGeneralStatusTitle,
            items: result.generalHealth,
            itemLabel: (kind) => _generalHealthLabel(l10n, kind),
            statusLabel: (status) => _generalStatusLabel(l10n, status),
          );
          final scanners = StaffSupervisorActiveScannersCard(
            title: l10n.staffSupervisorSystemActiveScannersTitle,
            scanners: result.scanners,
            restartLabel: l10n.staffSupervisorSystemRestartScannerButton,
            statusLabel: (status) => _scannerStatusLabel(l10n, status),
            onRestartTap: provider.isSubmittingAction
                ? null
                : () => _promptPinAndRestartScanner(context, provider),
          );

          if (isWide) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: general),
                  SizedBox(width: layout.spacing(8)),
                  Expanded(child: scanners),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              general,
              SizedBox(height: gap),
              scanners,
            ],
          );
        }

        Widget flowAndActions() {
          final flow = StaffSupervisorEventFlowCard(
            title: l10n.staffSupervisorSystemEventFlowTitle,
            subtitle: l10n.staffSupervisorSystemEventFlowSubtitle,
            items: result.eventFlow,
            itemLabel: (kind) => _flowLabel(l10n, kind),
          );
          final actions = StaffSupervisorQuickActionsCard(
            title: l10n.staffSupervisorSystemQuickActionsTitle,
            actions: _quickActions,
            actionLabel: (kind) => _actionLabel(l10n, kind, result),
            onActionTap: provider.isSubmittingAction
                ? null
                : (kind) => _handleQuickAction(context, provider, kind),
          );

          if (isWide) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: flow),
                  SizedBox(width: layout.spacing(8)),
                  Expanded(child: actions),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              flow,
              SizedBox(height: gap),
              actions,
            ],
          );
        }

        return StaffSupervisorAccessScaffold(
          onRefresh: () => provider.loadStatus(refresh: true),
          children: [
            if (result.eventTitle.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: gap),
                child: AppText(
                  result.eventTitle,
                  variant: AppTextVariant.bodyEmphasis,
                  fontWeight: FontWeight.w700,
                  color: AppColors.homeBlack,
                ),
              ),
            statusCards(),
            SizedBox(height: gap),
            if (result.alerts.isNotEmpty)
              StaffSupervisorActiveAlertsSection(
                title: l10n.staffSupervisorSystemActiveAlertsTitle,
                alerts: result.alerts,
                alertLabel: (kind) => _alertLabel(l10n, kind),
              ),
            if (result.alerts.isNotEmpty) SizedBox(height: gap),
            flowAndActions(),
            if (result.riskReasonKey != null) ...[
              SizedBox(height: gap),
              StaffSupervisorOperationalSemaphoreCard(
                title: l10n.staffSupervisorSystemOperationalSemaphoreTitle,
                riskLabel: l10n.staffSupervisorSystemRiskModerate,
                reasonLabel: l10n.staffSupervisorSystemRiskReasonLabel,
                reasonText: _riskReasonText(l10n, result.riskReasonKey),
              ),
            ],
            SizedBox(height: gap),
            StaffSupervisorRecentLogsSection(
              title: l10n.staffSupervisorSystemRecentLogsTitle,
              logs: result.logs,
              logLabel: (kind) => _logLabel(l10n, kind),
            ),
          ],
        );
      },
    );
  }
}
