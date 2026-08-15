import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_page_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_recent_actions_section.dart';

class StaffSupervisorBarActionHistoryRoute extends StatelessWidget {
  const StaffSupervisorBarActionHistoryRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorBarActionHistoryProvider(
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      )..loadHistory(),
      child: const StaffSupervisorBarActionHistoryScreen(),
    );
  }
}

class StaffSupervisorBarActionHistoryScreen extends StatelessWidget {
  const StaffSupervisorBarActionHistoryScreen({super.key});

  String _titleForEntry(dynamic l10n, StaffSupervisorBarActionHistoryEntry entry) {
    switch (entry.kind) {
      case 'cancel_consumption':
        return l10n.staffSupervisorActionConsumptionCancelled;
      case 'release_qr':
      case 'release_blocked_qr':
        return l10n.staffSupervisorActionQrReleased;
      case 'authorize_consumption':
      case 'generate_temporary_qr':
        return l10n.staffSupervisorActionManualValidation;
      default:
        return entry.kind.replaceAll('_', ' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorBarActionHistoryProvider>(
      builder: (context, provider, _) {
        final entries = provider.history?.actions ?? const [];

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: Column(
            children: [
              StaffSupervisorPageHeader(
                title: l10n.staffSupervisorRecentActionsTitle,
                subtitle: provider.history?.eventTitle ?? '',
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.loadError != null
                        ? Center(
                            child: AppText(
                              provider.loadError!,
                              variant: AppTextVariant.body,
                              color: const Color(0xFFEF4444),
                              fontSize: layout.fontSize(13),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : entries.isEmpty
                            ? Center(
                                child: AppText(
                                  l10n.staffSupervisorSearchDrinkNoResults,
                                  variant: AppTextVariant.body,
                                  color: AppColors.secondaryGrey,
                                  fontSize: layout.fontSize(13),
                                ),
                              )
                            : ListView(
                                padding: EdgeInsets.all(layout.spacing(20)),
                                children: [
                                  StaffSupervisorRecentActionsSection(
                                    actions: entries
                                        .map(
                                          (entry) => StaffSupervisorAction(
                                            type: entry.actionType,
                                            title: _titleForEntry(l10n, entry),
                                            timeLabel: entry.timeLabel,
                                          ),
                                        )
                                        .toList(),
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
