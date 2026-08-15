import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_entry_manual_validation_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_access_scaffold.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_buttons.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_components.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_search_field.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_manual_access_reason_panel.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_pin_reason_form.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_radio_tile.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_temporary_qr_dialog.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_warning_banner.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_manual_validation_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorEntryManualValidationRoute extends StatelessWidget {
  const StaffSupervisorEntryManualValidationRoute({
    super.key,
    this.args,
  });

  final StaffSupervisorEntryManualValidationRouteArgs? args;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorEntryManualValidationProvider(
        args: args,
        genericSearchError: l10n.staffSupervisorSearchEntrySearchError,
        genericLoadError: l10n.staffSupervisorSearchEntrySearchError,
      )..initialize(),
      child: const StaffSupervisorEntryManualValidationScreen(),
    );
  }
}

class StaffSupervisorEntryManualValidationScreen extends StatelessWidget {
  const StaffSupervisorEntryManualValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffSupervisorEntryManualValidationProvider>(
      builder: (context, provider, _) {
        final l10n = context.l10n;
        final layout = ResponsiveLayout(context);
        final contextData = provider.contextData;
        final result = contextData?.result;

        return StaffSupervisorAccessScaffold(
          footer: contextData != null && contextData.isPending
              ? StaffSupervisorExecuteFooter(
                  label: _footerLabel(l10n, provider.selectedAction),
                  icon: _footerIcon(provider.selectedAction),
                  enabled: provider.canSubmit && !provider.isSubmitting,
                  isLoading: provider.isSubmitting,
                  onPressed: () => _submit(context, provider),
                )
              : null,
          children: [
            StaffSupervisorWarningBanner(
              title: l10n.staffSupervisorEntryNoQrBannerTitle,
              body: l10n.staffSupervisorEntryNoQrBannerBody,
            ),
            SizedBox(height: layout.spacing(14)),
            if (provider.isLoadingContext)
              Padding(
                padding: EdgeInsets.symmetric(vertical: layout.spacing(32)),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: StaffSupervisorDesign.accent,
                  ),
                ),
              )
            else if (contextData == null)
              _EmptySearchState(provider: provider, l10n: l10n)
            else if (result != null)
              _LoadedEntryState(
                provider: provider,
                l10n: l10n,
                layout: layout,
                contextData: contextData,
                result: result,
              ),
          ],
        );
      },
    );
  }

  Future<void> _submit(
    BuildContext context,
    StaffSupervisorEntryManualValidationProvider provider,
  ) async {
    final l10n = context.l10n;
    final result = await provider.submit();
    if (!context.mounted) {
      return;
    }

    if (result == null) {
      final error = provider.submitError;
      if (error != null) {
        AppSnackBar.show(context, error);
      }
      return;
    }

    final temporaryQr = result.temporaryQr;
    if (temporaryQr != null) {
      AppSnackBar.showSuccess(
        context,
        l10n.staffSupervisorTemporaryQrGeneratedSuccess,
      );
      await StaffSupervisorTemporaryQrDialog.show(
        context,
        temporaryQr: temporaryQr,
        l10n: l10n,
      );
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
      return;
    }

    AppSnackBar.showSuccess(
      context,
      l10n.staffSupervisorEntryManualValidationSuccess,
    );
    Navigator.of(context).pop();
  }

  static String _footerLabel(
    AppLocalizations l10n,
    StaffSupervisorEntryManualValidationAction? action,
  ) {
    return switch (action) {
      StaffSupervisorEntryManualValidationAction.authorizeEntry =>
        l10n.staffSupervisorEntryManualAuthorizeEntry,
      StaffSupervisorEntryManualValidationAction.generateTemporaryQr =>
        l10n.staffSupervisorGenerateTemporaryQrButton,
      StaffSupervisorEntryManualValidationAction.rejectAccess =>
        l10n.staffSupervisorEntryManualRejectAccess,
      null => l10n.staffSupervisorEntryManualAuthorizeEntry,
    };
  }

  static IconData _footerIcon(
    StaffSupervisorEntryManualValidationAction? action,
  ) {
    return switch (action) {
      StaffSupervisorEntryManualValidationAction.authorizeEntry =>
        Icons.check_rounded,
      StaffSupervisorEntryManualValidationAction.generateTemporaryQr =>
        Icons.qr_code_scanner_rounded,
      StaffSupervisorEntryManualValidationAction.rejectAccess =>
        Icons.close_rounded,
      null => Icons.check_rounded,
    };
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState({
    required this.provider,
    required this.l10n,
  });

  final StaffSupervisorEntryManualValidationProvider provider;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StaffSupervisorEntrySearchField(
          controller: provider.search,
          hint: l10n.staffSupervisorEntryManualSearchPlaceholder,
          sectionTitle: l10n.staffSupervisorSearchUserHeading,
          onResultSelected: provider.onSearchResultSelected,
        ),
        if (provider.contextError != null) ...[
          SizedBox(height: layout.spacing(16)),
          AppText(
            provider.contextError!,
            variant: AppTextVariant.body,
            textAlign: TextAlign.center,
            color: const Color(0xFFEF4444),
            fontSize: layout.fontSize(14),
          ),
        ],
      ],
    );
  }
}

class _LoadedEntryState extends StatelessWidget {
  const _LoadedEntryState({
    required this.provider,
    required this.l10n,
    required this.layout,
    required this.contextData,
    required this.result,
  });

  final StaffSupervisorEntryManualValidationProvider provider;
  final AppLocalizations l10n;
  final ResponsiveLayout layout;
  final StaffSupervisorEntryManualValidationContext contextData;
  final StaffSupervisorEntryManualValidationResult result;

  @override
  Widget build(BuildContext context) {
    final supervisorName = _supervisorName(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StaffSupervisorEntryResultCard(
          sectionTitle: l10n.staffSupervisorResultFoundTitle,
          guestName: result.guestName,
          initials: result.initials,
          eventLabel: l10n.staffSupervisorResultEventLabel,
          eventName: result.eventName,
          ticketTypeLabel: l10n.staffEntryValidTicketTypeLabel,
          ticketTypeName: result.ticketTypeLabel,
          accessLabel: l10n.staffSupervisorEntryAccessLabel,
          accessName: result.accessLabel,
          qrStatusLabel: l10n.staffSupervisorQrStatusLabel,
          qrStatusText: l10n.staffSupervisorQrStatusUnavailable,
          footer: contextData.isPending
              ? StaffSupervisorManualAccessReasonPanel<
                  StaffSupervisorEntryManualReason>(
                  title: l10n.staffSupervisorEntryManualReasonTitle,
                  leftOptions: const [
                    StaffSupervisorEntryManualReason.phoneBattery,
                    StaffSupervisorEntryManualReason.noConnection,
                    StaffSupervisorEntryManualReason.damagedQr,
                  ],
                  rightOptions: const [
                    StaffSupervisorEntryManualReason.brokenScreen,
                    StaffSupervisorEntryManualReason.other,
                  ],
                  selectedValue: provider.selectedReason,
                  optionLabel: (reason) => _reasonLabel(l10n, reason),
                  onOptionSelected: provider.selectReason,
                  showOtherField: provider.selectedReason ==
                      StaffSupervisorEntryManualReason.other,
                  otherController: provider.otherReasonController,
                  otherPlaceholder:
                      l10n.staffSupervisorEntryManualReasonOtherPlaceholder,
                  onOtherChanged: provider.notifyFormChanged,
                )
              : null,
        ),
        SizedBox(height: layout.spacing(14)),
        StaffSupervisorIdentitySection(
          title: l10n.staffSupervisorIdentityValidationTitle,
          fullNameLabel: l10n.staffSupervisorIdentityFullNameLabel,
          fullName: result.guestName,
          phoneDigitsLabel: l10n.staffSupervisorEntryManualIdentityPhoneLabel,
          phoneDigits: result.phoneLastDigits,
          documentLabel: l10n.staffSupervisorIdentityDocumentLabel,
          documentConfirmed: l10n.staffSupervisorIdentityConfirmed,
          documentPendingLabel: l10n.staffSupervisorSearchEntryNoResults,
          isDocumentConfirmed: result.isDocumentConfirmed,
        ),
        if (contextData.isPending) ...[
          SizedBox(height: layout.spacing(14)),
          StaffSupervisorSectionCard(
            title: l10n.staffSupervisorDuplicateSupervisorActionsTitle,
            child: Row(
              children: [
                Expanded(
                  child: StaffSupervisorActionTile(
                    icon: Icons.check_rounded,
                    label: l10n.staffSupervisorEntryManualAuthorizeEntry,
                    selected: provider.selectedAction ==
                        StaffSupervisorEntryManualValidationAction.authorizeEntry,
                    onTap: () => provider.selectAction(
                      StaffSupervisorEntryManualValidationAction.authorizeEntry,
                    ),
                  ),
                ),
                SizedBox(width: layout.spacing(8)),
                Expanded(
                  child: StaffSupervisorActionTile(
                    icon: Icons.qr_code_scanner_rounded,
                    label: l10n.staffSupervisorGenerateTemporaryQrButton,
                    selected: provider.selectedAction ==
                        StaffSupervisorEntryManualValidationAction
                            .generateTemporaryQr,
                    onTap: () => provider.selectAction(
                      StaffSupervisorEntryManualValidationAction
                          .generateTemporaryQr,
                    ),
                  ),
                ),
                SizedBox(width: layout.spacing(8)),
                Expanded(
                  child: StaffSupervisorActionTile(
                    icon: Icons.close_rounded,
                    label: l10n.staffSupervisorEntryManualRejectAccess,
                    borderColor: StaffSupervisorDesign.dangerRed,
                    foregroundColor: StaffSupervisorDesign.dangerRed,
                    selected: provider.selectedAction ==
                        StaffSupervisorEntryManualValidationAction.rejectAccess,
                    onTap: () => provider.selectAction(
                      StaffSupervisorEntryManualValidationAction.rejectAccess,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: layout.spacing(14)),
          StaffSupervisorPinReasonForm(
            pinController: provider.pinController,
            reasonController: provider.reasonController,
            pinLabel: l10n.staffSupervisorAuthorizationPinLabel,
            reasonLabel: l10n.staffSupervisorEntryManualReasonTitle,
            reasonHint: l10n.staffSupervisorEntryManualReasonOtherPlaceholder,
            onChanged: provider.notifyFormChanged,
            reasonMaxLines: 1,
          ),
        ],
        SizedBox(height: layout.spacing(14)),
        StaffSupervisorSystemRecordBar(
          title: l10n.staffSupervisorSystemRecordTitle,
          supervisorText: l10n.staffSupervisorSystemRecordSupervisor(supervisorName),
          timeText: l10n.staffSupervisorSystemRecordTime(
            contextData.systemRecordTimeLabel,
          ),
          statusLabel: l10n.staffSupervisorEntryManualSystemStatusLabel,
          statusValue: _systemStatusLabel(l10n, contextData),
          statusAsPill: contextData.isPending,
        ),
      ],
    );
  }

  String _reasonLabel(
    AppLocalizations l10n,
    StaffSupervisorEntryManualReason reason,
  ) {
    return switch (reason) {
      StaffSupervisorEntryManualReason.phoneBattery =>
        l10n.staffSupervisorReasonPhoneBattery,
      StaffSupervisorEntryManualReason.noConnection =>
        l10n.staffSupervisorReasonNoConnection,
      StaffSupervisorEntryManualReason.damagedQr =>
        l10n.staffSupervisorReasonDamagedQr,
      StaffSupervisorEntryManualReason.brokenScreen =>
        l10n.staffSupervisorReasonBrokenScreen,
      StaffSupervisorEntryManualReason.other => l10n.staffSupervisorReasonOther,
    };
  }

  String _systemStatusLabel(
    AppLocalizations l10n,
    StaffSupervisorEntryManualValidationContext contextData,
  ) {
    return switch (contextData.systemStatus) {
      StaffSupervisorEntryManualValidationSystemStatus.authorized =>
        l10n.staffSupervisorEntryStatusValidated,
      StaffSupervisorEntryManualValidationSystemStatus.rejected =>
        l10n.staffSupervisorEntryStatusBlocked,
      StaffSupervisorEntryManualValidationSystemStatus.pending =>
        l10n.staffSupervisorEntryManualSystemStatusPending,
    };
  }

  String _supervisorName(BuildContext context) {
    final name = context.read<StaffAuthProvider>().profile?.name;
    if (name == null || name.trim().isEmpty) {
      return 'Supervisor';
    }
    return name.trim();
  }
}
