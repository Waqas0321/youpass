import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_action_history_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_access_scaffold.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_action_history_components.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_history_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class StaffSupervisorActionHistoryRoute extends StatelessWidget {
  const StaffSupervisorActionHistoryRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorActionHistoryProvider(
        genericError: l10n.staffSupervisorActionHistoryLoadError,
      )..initialize(),
      child: const StaffSupervisorActionHistoryScreen(),
    );
  }
}

class StaffSupervisorActionHistoryScreen extends StatelessWidget {
  const StaffSupervisorActionHistoryScreen({super.key});

  String _entryTitle(dynamic l10n, StaffSupervisorActionHistoryEntry entry) {
    return switch (entry.kind) {
      'release_qr' => l10n.staffSupervisorActionHistoryKindReleaseQr,
      'revalidate_qr' => l10n.staffSupervisorActionHistoryKindRevalidateQr,
      'revert_validation' => l10n.staffSupervisorActionHistoryKindRevertValidation,
      'authorize_reentry' => l10n.staffSupervisorActionHistoryKindAuthorizeReentry,
      'temporary_unlock' => l10n.staffSupervisorActionHistoryKindTemporaryUnlock,
      'release_reentry' => l10n.staffSupervisorActionHistoryKindReleaseReentry,
      'block_qr' => l10n.staffSupervisorActionHistoryKindBlockQr,
      'escalate_alert' => l10n.staffSupervisorActionHistoryKindEscalateAlert,
      'authorize_entry' => l10n.staffSupervisorActionHistoryKindAuthorizeEntry,
      'generate_temporary_qr' =>
        l10n.staffSupervisorActionHistoryKindGenerateTemporaryQr,
      'reject_access' => l10n.staffSupervisorActionHistoryKindRejectAccess,
      'authorize_extra_guest' =>
        l10n.staffSupervisorActionHistoryKindAuthorizeExtraGuest,
      'change_access' => l10n.staffSupervisorActionHistoryKindChangeAccess,
      'move_guest' => l10n.staffSupervisorActionHistoryKindMoveGuest,
      'release_invitation' =>
        l10n.staffSupervisorActionHistoryKindReleaseInvitation,
      'offline_mode_enabled' =>
        l10n.staffSupervisorActionHistoryKindOfflineModeEnabled,
      'offline_mode_disabled' =>
        l10n.staffSupervisorActionHistoryKindOfflineModeDisabled,
      'validations_paused' => l10n.staffSupervisorActionHistoryKindValidationsPaused,
      'validations_resumed' => l10n.staffSupervisorActionHistoryKindValidationsResumed,
      'vip_access_blocked' => l10n.staffSupervisorActionHistoryKindVipAccessBlocked,
      'vip_access_unblocked' =>
        l10n.staffSupervisorActionHistoryKindVipAccessUnblocked,
      'scanner_restarted' => l10n.staffSupervisorActionHistoryKindScannerRestarted,
      'staff_alert' => l10n.staffSupervisorActionHistoryKindStaffAlert,
      _ => entry.kind.replaceAll('_', ' '),
    };
  }

  String? _targetLabel(StaffSupervisorActionHistoryEntry entry) {
    if (entry.targetLabel != null && entry.targetLabel!.trim().isNotEmpty) {
      return entry.targetLabel;
    }

    if (entry.notes != null && entry.notes!.trim().isNotEmpty) {
      return entry.notes;
    }

    return null;
  }

  void _openEntryHistory(
    BuildContext context,
    StaffSupervisorActionHistoryEntry entry,
    StaffSupervisorActionHistoryResult history,
  ) {
    final ticketId = entry.ticketId;
    if (ticketId == null || ticketId.isEmpty) {
      return;
    }

    Navigator.of(context).pushNamed(
      StaffAppRoutes.supervisorEntryHistory,
      arguments: StaffSupervisorEntryHistoryRouteArgs(
        ticketId: ticketId,
        guestName: entry.targetLabel ?? history.eventTitle,
        eventTitle: history.eventTitle,
        qrId: entry.entryCode ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorActionHistoryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.loadError != null || provider.history == null) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(layout.spacing(24)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      provider.loadError ?? l10n.staffSupervisorActionHistoryLoadError,
                      variant: AppTextVariant.body,
                      textAlign: TextAlign.center,
                      color: AppColors.secondaryGrey,
                    ),
                    SizedBox(height: layout.spacing(16)),
                    FilledButton(
                      onPressed: provider.isRefreshing
                          ? null
                          : () => provider.loadHistory(),
                      child: Text(l10n.staffSupervisorSystemRetry),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final history = provider.history!;

        return StaffSupervisorAccessScaffold(
          onRefresh: () => provider.loadHistory(refresh: true),
          children: [
            if (history.eventTitle.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: layout.spacing(14)),
                child: AppText(
                  history.eventTitle,
                  variant: AppTextVariant.bodyEmphasis,
                  fontWeight: FontWeight.w700,
                  color: AppColors.homeBlack,
                ),
              ),
            if (history.actions.isEmpty)
              AppText(
                l10n.staffSupervisorActionHistoryEmpty,
                variant: AppTextVariant.body,
                textAlign: TextAlign.center,
                color: AppColors.secondaryGrey,
              )
            else
              StaffSupervisorActionHistoryList(
                entries: history.actions,
                entryTitle: (entry) => _entryTitle(l10n, entry),
                supervisorPrefix: l10n.staffSupervisorVipHistorySupervisorPrefix,
                targetLabel: _targetLabel,
                onEntryTap: (entry) => _openEntryHistory(context, entry, history),
              ),
          ],
        );
      },
    );
  }
}
