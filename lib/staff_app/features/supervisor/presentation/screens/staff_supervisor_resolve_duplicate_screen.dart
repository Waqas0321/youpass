import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_connection_status_bar.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_duplicate_alert.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_resolve_duplicate_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_buttons.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_search_field.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_pin_reason_form.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_resolve_duplicate_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorResolveDuplicateScreen extends StatelessWidget {
  const StaffSupervisorResolveDuplicateScreen({
    super.key,
    this.args,
    this.supervisorApiService,
  });

  final StaffSupervisorResolveDuplicateRouteArgs? args;
  final StaffSupervisorApiService? supervisorApiService;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorResolveDuplicateProvider(
        args: args,
        apiService: supervisorApiService,
        genericSearchError: l10n.staffSupervisorSearchEntrySearchError,
        genericLoadError: l10n.staffSupervisorSearchEntrySearchError,
        duplicateNotFoundError: l10n.staffSupervisorDuplicateNotFound,
      )..initialize(),
      child: const _StaffSupervisorResolveDuplicateView(),
    );
  }
}

class _StaffSupervisorResolveDuplicateView extends StatelessWidget {
  const _StaffSupervisorResolveDuplicateView();

  static const _accent = Color(0xFFD4A044);
  static const _pageBg = Color(0xFFF8F9FA);

  static Future<void> _handleSubmit(
    BuildContext context,
    StaffSupervisorResolveDuplicateProvider provider,
  ) async {
    final success = await provider.submit();
    if (!context.mounted) {
      return;
    }

    if (success) {
      AppSnackBar.show(context, context.l10n.staffSupervisorDuplicateResolvedSuccess);
      Navigator.of(context).pop();
      return;
    }

    final error = provider.submitError;
    if (error != null) {
      AppSnackBar.show(context, error);
    }
  }

  static String _validatorFooterLabel(BuildContext context, AppLocalizations l10n) {
    final zoneLabel = context.read<StaffAuthProvider>().profile?.zoneLabel;
    if (zoneLabel == null || zoneLabel.isEmpty) {
      return l10n.staffSupervisorValidatorLabel('VAL-AC-02');
    }

    final code = zoneLabel
        .trim()
        .toUpperCase()
        .replaceAll(RegExp(r'[^\w]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');

    return l10n.staffSupervisorValidatorLabel(
      code.length >= 3 ? code : zoneLabel,
    );
  }

  static String _reasonLabel(AppLocalizations l10n, StaffSupervisorDuplicateReason reason) {
    return switch (reason) {
      StaffSupervisorDuplicateReason.sharedScreenshot =>
        l10n.staffSupervisorDuplicateReasonScreenshot,
      StaffSupervisorDuplicateReason.resoldQr =>
        l10n.staffSupervisorDuplicateReasonResold,
      StaffSupervisorDuplicateReason.validationError =>
        l10n.staffSupervisorDuplicateReasonValidationError,
      StaffSupervisorDuplicateReason.authorizedReentry =>
        l10n.staffSupervisorDuplicateReasonAuthorizedReentry,
      StaffSupervisorDuplicateReason.other => l10n.staffSupervisorReasonOther,
    };
  }

  static String _actionLabel(AppLocalizations l10n, StaffSupervisorDuplicateAction action) {
    return switch (action) {
      StaffSupervisorDuplicateAction.revalidateQr =>
        l10n.staffSupervisorOverrideRevalidateQr,
      StaffSupervisorDuplicateAction.releaseReentry =>
        l10n.staffSupervisorDuplicateReleaseReentry,
      StaffSupervisorDuplicateAction.blockQr =>
        l10n.staffSupervisorDuplicateBlockQr,
      StaffSupervisorDuplicateAction.escalateAlert =>
        l10n.staffSupervisorDuplicateEscalateAlert,
    };
  }

  static String _logTitle(AppLocalizations l10n, StaffSupervisorDuplicateQrLog log) {
    return switch (log.kind) {
      StaffSupervisorDuplicateQrLogKind.validated =>
        l10n.staffSupervisorDuplicateLogValidated,
      StaffSupervisorDuplicateQrLogKind.reentryRejected =>
        l10n.staffSupervisorDuplicateLogReentryRejected,
      StaffSupervisorDuplicateQrLogKind.supervisorPending =>
        l10n.staffSupervisorDuplicateLogSupervisorPending,
      StaffSupervisorDuplicateQrLogKind.supervisorResolved =>
        l10n.staffSupervisorDuplicateLogSupervisorResolved,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffSupervisorResolveDuplicateProvider>(
      builder: (context, provider, _) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final alert = provider.alert;

    return Scaffold(
      backgroundColor: _pageBg,
      body: Column(
        children: [
          StaffScanScreenHeader(showBottomDivider: true),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(8),
              layout.spacing(20),
              layout.spacing(12),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                l10n.staffSupervisorSearchEntryHeaderSubtitle,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: alert == null && !provider.isLoadingAlert
                ? ListView(
                    padding: EdgeInsets.fromLTRB(
                      layout.spacing(20),
                      0,
                      layout.spacing(20),
                      layout.spacing(12),
                    ),
                    children: [
                      StaffSupervisorEntrySearchField(
                        controller: provider.search,
                        hint: l10n.staffSupervisorDuplicateSearchHint,
                        wrapInCard: false,
                        onResultSelected: provider.onSearchResultSelected,
                      ),
                      if (provider.alertError != null) ...[
                        SizedBox(height: layout.spacing(24)),
                        AppText(
                          provider.alertError!,
                          variant: AppTextVariant.body,
                          textAlign: TextAlign.center,
                          color: const Color(0xFFEF4444),
                          fontSize: layout.fontSize(14),
                        ),
                      ],
                    ],
                  ): ListView(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(20),
                0,
                layout.spacing(20),
                layout.spacing(12),
              ),
              children: [
                if (provider.isLoadingAlert)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: layout.spacing(32)),
                    child: const Center(
                      child: CircularProgressIndicator(color: _accent),
                    ),
                  )
                else if (alert != null) ...[
                  _DuplicateAlertBanner(layout: layout, l10n: l10n),
                  if (!alert.isPending) ...[
                    SizedBox(height: layout.spacing(10)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(layout.spacing(12)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(layout.radius(12)),
                        border: Border.all(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.35),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: const Color(0xFF22C55E),
                            size: layout.spacing(20),
                          ),
                          SizedBox(width: layout.spacing(8)),
                          Expanded(
                            child: AppText(
                              l10n.staffSupervisorDuplicateAlreadyResolved,
                              variant: AppTextVariant.body,
                              color: AppColors.homeBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: layout.fontSize(13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: layout.spacing(14)),
                  _GuestInfoCard(
                    layout: layout,
                    l10n: l10n,
                    alert: alert,
                  ),
                  SizedBox(height: layout.spacing(16)),
                  AppText(
                    l10n.staffSupervisorDuplicateCurrentStatusTitle,
                    variant: AppTextVariant.label,
                    color: AppColors.secondaryGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(12),
                    letterSpacing: 0.8,
                  ),
                  SizedBox(height: layout.spacing(10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _AccessSnapshotCard(
                          layout: layout,
                          l10n: l10n,
                          title: l10n.staffSupervisorDuplicateLastValidTitle,
                          snapshot: alert.lastValidAccess,
                          isValid: true,
                        ),
                      ),
                      SizedBox(width: layout.spacing(10)),
                      Expanded(
                        child: _AccessSnapshotCard(
                          layout: layout,
                          l10n: l10n,
                          title: l10n.staffSupervisorDuplicateNewAttemptTitle,
                          snapshot: alert.newAttempt,
                          isValid: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: layout.spacing(18)),
                  if (alert.isPending) ...[
                  AppText(
                    l10n.staffSupervisorDuplicatePossibleReasonTitle,
                    variant: AppTextVariant.label,
                    color: AppColors.secondaryGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(12),
                    letterSpacing: 0.8,
                  ),
                  SizedBox(height: layout.spacing(10)),
                  Container(
                    padding: EdgeInsets.all(layout.spacing(14)),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(layout.radius(14)),
                      border: Border.all(color: AppColors.homeDividerGrey),
                    ),
                    child: Wrap(
                      spacing: layout.spacing(12),
                      runSpacing: layout.spacing(8),
                      children: StaffSupervisorDuplicateReason.values
                          .map(
                            (reason) => SizedBox(
                              width: (MediaQuery.sizeOf(context).width -
                                      layout.spacing(68)) /
                                  2,
                              child: _ReasonRadioTile(
                                layout: layout,
                                label: _reasonLabel(l10n, reason),
                                selected: provider.selectedReason == reason,
                                onTap: () => provider.selectReason(reason),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: layout.spacing(18)),
                  AppText(
                    l10n.staffSupervisorDuplicateSupervisorActionsTitle,
                    variant: AppTextVariant.label,
                    color: AppColors.secondaryGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(12),
                    letterSpacing: 0.8,
                  ),
                  SizedBox(height: layout.spacing(10)),
                  Row(
                    children: [
                      Expanded(
                        child: _SupervisorActionTile(
                          layout: layout,
                          icon: Icons.refresh_rounded,
                          label: _actionLabel(
                            l10n,
                            StaffSupervisorDuplicateAction.revalidateQr,
                          ),
                          selected: provider.selectedAction ==
                              StaffSupervisorDuplicateAction.revalidateQr,
                          onTap: () => provider.selectAction(
                            StaffSupervisorDuplicateAction.revalidateQr,
                          ),
                        ),
                      ),
                      SizedBox(width: layout.spacing(8)),
                      Expanded(
                        child: _SupervisorActionTile(
                          layout: layout,
                          icon: Icons.lock_open_rounded,
                          label: _actionLabel(
                            l10n,
                            StaffSupervisorDuplicateAction.releaseReentry,
                          ),
                          selected: provider.selectedAction ==
                              StaffSupervisorDuplicateAction.releaseReentry,
                          onTap: () => provider.selectAction(
                            StaffSupervisorDuplicateAction.releaseReentry,
                          ),
                        ),
                      ),
                      SizedBox(width: layout.spacing(8)),
                      Expanded(
                        child: _SupervisorActionTile(
                          layout: layout,
                          icon: Icons.block_rounded,
                          label: _actionLabel(
                            l10n,
                            StaffSupervisorDuplicateAction.blockQr,
                          ),
                          selected: provider.selectedAction ==
                              StaffSupervisorDuplicateAction.blockQr,
                          onTap: () => provider.selectAction(
                            StaffSupervisorDuplicateAction.blockQr,
                          ),
                        ),
                      ),
                      SizedBox(width: layout.spacing(8)),
                      Expanded(
                        child: _SupervisorActionTile(
                          layout: layout,
                          icon: Icons.warning_amber_rounded,
                          label: _actionLabel(
                            l10n,
                            StaffSupervisorDuplicateAction.escalateAlert,
                          ),
                          selected: provider.selectedAction ==
                              StaffSupervisorDuplicateAction.escalateAlert,
                          onTap: () => provider.selectAction(
                            StaffSupervisorDuplicateAction.escalateAlert,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: layout.spacing(18)),
                  StaffSupervisorPinReasonForm(
                    pinController: provider.pinController,
                    reasonController: provider.reasonController,
                    pinLabel: l10n.staffSupervisorAuthorizationPinLabel,
                    reasonLabel: l10n.staffSupervisorReasonTitle,
                    reasonHint: l10n.staffSupervisorDuplicateReasonPlaceholder,
                    onChanged: provider.notifyFormChanged,
                    reasonMaxLines: 3,
                  ),
                  ],
                  SizedBox(height: layout.spacing(18)),
                  _QrHistoryCard(
                    layout: layout,
                    l10n: l10n,
                    logs: alert.qrHistory,
                    titleForLog: (log) => _logTitle(l10n, log),
                  ),
                ],
              ],
            ),
          ),
          if (alert != null && alert.isPending)
            StaffSupervisorExecuteFooter(
              label: l10n.staffSupervisorExecuteDuplicateButton,
              enabled: provider.canSubmit,
              isLoading: provider.isSubmitting,
              icon: Icons.verified_user_outlined,
              onPressed: () => _handleSubmit(context, provider),
            ),
          StaffConnectionStatusBar(
            validatorLabel: _validatorFooterLabel(context, l10n),
          ),
        ],
      ),
    );
      },
    );
  }
}

class _DuplicateAlertBanner extends StatelessWidget {
  const _DuplicateAlertBanner({required this.layout, required this.l10n});

  static const _accent = Color(0xFFD4A044);
  static const _warningBg = Color(0xFFFFF8EB);

  final ResponsiveLayout layout;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(14),
        vertical: layout.spacing(12),
      ),
      decoration: BoxDecoration(
        color: _warningBg,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: _accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: _accent, size: layout.spacing(22)),
          SizedBox(width: layout.spacing(10)),
          AppText(
            l10n.staffSupervisorDuplicateAlertTitle,
            variant: AppTextVariant.bodyEmphasis,
            color: _accent,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(14),
            letterSpacing: 0.6,
          ),
        ],
      ),
    );
  }
}

class _GuestInfoCard extends StatelessWidget {
  const _GuestInfoCard({
    required this.layout,
    required this.l10n,
    required this.alert,
  });

  static const _accent = Color(0xFFD4A044);

  final ResponsiveLayout layout;
  final AppLocalizations l10n;
  final StaffSupervisorDuplicateAlert alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(layout.spacing(16)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(16)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: layout.spacing(24),
                    backgroundColor: const Color(0xFFFFF8EB),
                    child: Icon(
                      Icons.person_rounded,
                      color: _accent,
                      size: layout.spacing(28),
                    ),
                  ),
                  if (alert.isVip)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: layout.spacing(6),
                          vertical: layout.spacing(2),
                        ),
                        decoration: BoxDecoration(
                          color: _accent,
                          borderRadius: BorderRadius.circular(layout.radius(8)),
                        ),
                        child: AppText(
                          'VIP',
                          variant: AppTextVariant.label,
                          color: AppColors.backgroundWhite,
                          fontWeight: FontWeight.w800,
                          fontSize: layout.fontSize(9),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoLine(
                      layout: layout,
                      label: l10n.staffSupervisorConsumptionUserLabel,
                      value: alert.guestName,
                    ),
                    _InfoLine(
                      layout: layout,
                      label: l10n.staffSupervisorResultEventLabel,
                      value: alert.eventName,
                    ),
                    _InfoLine(
                      layout: layout,
                      label: l10n.staffEntryValidTicketTypeLabel,
                      value: alert.ticketTypeLabel,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: layout.spacing(56),
                    height: layout.spacing(56),
                    decoration: BoxDecoration(
                      color: AppColors.homeBlack,
                      borderRadius: BorderRadius.circular(layout.radius(8)),
                    ),
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      color: AppColors.backgroundWhite,
                      size: layout.spacing(32),
                    ),
                  ),
                  SizedBox(height: layout.spacing(6)),
                  AppText(
                    l10n.staffSupervisorOverrideQrIdLabel,
                    variant: AppTextVariant.label,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(10),
                  ),
                  AppText(
                    alert.qrId,
                    variant: AppTextVariant.bodyEmphasis,
                    color: _accent,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: layout.spacing(12)),
          Divider(color: AppColors.homeDividerGrey, height: 1),
          SizedBox(height: layout.spacing(10)),
          Row(
            children: [
              AppText(
                '${l10n.staffSupervisorSearchEntryPurchaseIdLabel}:',
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
              ),
              SizedBox(width: layout.spacing(8)),
              AppText(
                alert.purchaseId,
                variant: AppTextVariant.bodyEmphasis,
                color: AppColors.homeBlack,
                fontWeight: FontWeight.w800,
                fontSize: layout.fontSize(14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.layout,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(4)),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: layout.fontSize(13),
            color: AppColors.secondaryGrey,
            height: 1.4,
          ),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: AppColors.homeBlack,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccessSnapshotCard extends StatelessWidget {
  const _AccessSnapshotCard({
    required this.layout,
    required this.l10n,
    required this.title,
    required this.snapshot,
    required this.isValid,
  });

  static const _successGreen = Color(0xFF22C55E);
  static const _dangerRed = Color(0xFFDC2626);

  final ResponsiveLayout layout;
  final AppLocalizations l10n;
  final String title;
  final StaffSupervisorDuplicateAccessSnapshot snapshot;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final color = isValid ? _successGreen : _dangerRed;
    final bg = isValid ? const Color(0xFFECFDF5) : const Color(0xFFFFF1F2);

    return Container(
      padding: EdgeInsets.all(layout.spacing(12)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(layout.radius(14)),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                isValid ? Icons.check_circle_rounded : Icons.error_rounded,
                color: color,
                size: layout.spacing(18),
              ),
              SizedBox(width: layout.spacing(6)),
              Expanded(
                child: AppText(
                  title,
                  variant: AppTextVariant.bodyEmphasis,
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(11),
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing(10)),
          _SnapshotRow(
            layout: layout,
            icon: Icons.schedule_rounded,
            label: l10n.staffSupervisorDuplicateTimeLabel,
            value: snapshot.timeLabel,
          ),
          _SnapshotRow(
            layout: layout,
            icon: Icons.star_outline_rounded,
            label: l10n.staffSupervisorDuplicateAccessLabel,
            value: snapshot.accessLabel,
          ),
          _SnapshotRow(
            layout: layout,
            icon: isValid ? Icons.shield_outlined : Icons.smartphone_rounded,
            label: isValid
                ? l10n.staffSupervisorSearchEntryValidatorLabel
                : l10n.staffSupervisorDuplicateDeviceLabel,
            value: snapshot.deviceLabel,
          ),
        ],
      ),
    );
  }
}

class _SnapshotRow extends StatelessWidget {
  const _SnapshotRow({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(6)),
      child: Row(
        children: [
          Icon(icon, size: layout.spacing(14), color: AppColors.secondaryGrey),
          SizedBox(width: layout.spacing(6)),
          Expanded(
            child: AppText(
              '$label: $value',
              variant: AppTextVariant.body,
              color: AppColors.homeBlack,
              fontSize: layout.fontSize(11),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonRadioTile extends StatelessWidget {
  const _ReasonRadioTile({
    required this.layout,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _accent = Color(0xFFD4A044);

  final ResponsiveLayout layout;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(6)),
          child: Row(
            children: [
              Container(
                width: layout.spacing(18),
                height: layout.spacing(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? _accent : AppColors.lightGreyBorder,
                    width: selected ? 2 : 1.5,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: layout.spacing(8),
                          height: layout.spacing(8),
                          decoration: const BoxDecoration(
                            color: _accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: layout.spacing(8)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(12),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupervisorActionTile extends StatelessWidget {
  const _SupervisorActionTile({
    required this.layout,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _accent = Color(0xFFD4A044);
  static const _tileBg = Color(0xFFFFF8EB);

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _accent.withValues(alpha: 0.12) : _tileBg,
      borderRadius: BorderRadius.circular(layout.radius(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: layout.spacing(12),
            horizontal: layout.spacing(2),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(layout.radius(12)),
            border: Border.all(
              color: selected ? _accent : const Color(0xFFFDE6B0),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: _accent, size: layout.spacing(22)),
              SizedBox(height: layout.spacing(6)),
              AppText(
                label,
                variant: AppTextVariant.label,
                color: _accent,
                fontWeight: FontWeight.w700,
                fontSize: layout.fontSize(9),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrHistoryCard extends StatelessWidget {
  const _QrHistoryCard({
    required this.layout,
    required this.l10n,
    required this.logs,
    required this.titleForLog,
  });

  static const _accent = Color(0xFFD4A044);
  static const _successGreen = Color(0xFF22C55E);
  static const _dangerRed = Color(0xFFDC2626);

  final ResponsiveLayout layout;
  final AppLocalizations l10n;
  final List<StaffSupervisorDuplicateQrLog> logs;
  final String Function(StaffSupervisorDuplicateQrLog log) titleForLog;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(layout.spacing(16)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(16)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            l10n.staffSupervisorOverrideLogsTitle,
            variant: AppTextVariant.label,
            color: AppColors.secondaryGrey,
            fontWeight: FontWeight.w700,
            fontSize: layout.fontSize(12),
            letterSpacing: 0.8,
          ),
          SizedBox(height: layout.spacing(14)),
          ...List.generate(logs.length, (index) {
            final log = logs[index];
            final isLast = index == logs.length - 1;
            final color = log.isSuccess
                ? _successGreen
                : log.isRejected
                    ? _dangerRed
                    : log.isResolved
                        ? _successGreen
                        : _accent;
            final icon = log.isSuccess
                ? Icons.check_circle_rounded
                : log.isRejected
                    ? Icons.cancel_rounded
                    : log.isResolved
                        ? Icons.verified_user_rounded
                        : Icons.schedule_rounded;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(icon, color: color, size: layout.spacing(20)),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: EdgeInsets.symmetric(
                              vertical: layout.spacing(4),
                            ),
                            color: AppColors.homeDividerGrey,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: layout.spacing(12)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: layout.spacing(isLast ? 0 : 14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  titleForLog(log),
                                  variant: AppTextVariant.bodyEmphasis,
                                  color: AppColors.homeBlack,
                                  fontWeight: FontWeight.w700,
                                  fontSize: layout.fontSize(14),
                                ),
                                AppText(
                                  log.timeLabel,
                                  variant: AppTextVariant.body,
                                  color: AppColors.secondaryGrey,
                                  fontSize: layout.fontSize(12),
                                ),
                              ],
                            ),
                          ),
                          AppText(
                            log.detail,
                            variant: AppTextVariant.body,
                            color: log.isPending ? _accent : AppColors.homeBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: layout.fontSize(13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
