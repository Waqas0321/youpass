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
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_override_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_entry_qr_override_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_search_field.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_form_utils.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_buttons.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_override_authorization_card.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_qr_override_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';

class StaffSupervisorEntryQrOverrideScreen extends StatelessWidget {
  const StaffSupervisorEntryQrOverrideScreen({
    super.key,
    this.args,
    this.supervisorApiService,
  });

  final StaffSupervisorEntryQrOverrideRouteArgs? args;
  final StaffSupervisorApiService? supervisorApiService;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorEntryQrOverrideProvider(
        args: args,
        apiService: supervisorApiService,
        genericSearchError: l10n.staffSupervisorSearchEntrySearchError,
        genericLoadError: l10n.staffSupervisorSearchEntrySearchError,
      )..initialize(),
      child: const _StaffSupervisorEntryQrOverrideView(),
    );
  }
}

class _StaffSupervisorEntryQrOverrideView extends StatelessWidget {
  const _StaffSupervisorEntryQrOverrideView();

  static const _accent = AppColors.homeAccentYellow;
  static const _pageBg = Color(0xFFF8F9FA);

  static const _leftColumnActions = [
    StaffSupervisorEntryOverrideAction.releaseQr,
    StaffSupervisorEntryOverrideAction.revalidateQr,
    StaffSupervisorEntryOverrideAction.revertValidation,
  ];

  static const _rightColumnActions = [
    StaffSupervisorEntryOverrideAction.authorizeReentry,
    StaffSupervisorEntryOverrideAction.temporaryUnlock,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffSupervisorEntryQrOverrideProvider>(
      builder: (context, provider, _) {
        final l10n = context.l10n;
        final layout = ResponsiveLayout(context);
        final overrideContext = provider.contextData;

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
                    l10n.staffSupervisorEntryOverrideDescription,
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: overrideContext == null && !provider.isLoadingContext
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
                            hint: l10n.staffSupervisorOverrideSearchPlaceholder,
                            sectionTitle: l10n.staffSupervisorOverrideSearchTitle,
                            onResultSelected: provider.onSearchResultSelected,
                          ),
                          if (provider.contextError != null) ...[
                            SizedBox(height: layout.spacing(24)),
                            AppText(
                              provider.contextError!,
                              variant: AppTextVariant.body,
                              textAlign: TextAlign.center,
                              color: const Color(0xFFEF4444),
                              fontSize: layout.fontSize(14),
                            ),
                          ],
                        ],
                      )
                    : ListView(
                        padding: EdgeInsets.fromLTRB(
                          layout.spacing(20),
                          0,
                          layout.spacing(20),
                          layout.spacing(12),
                        ),
                        children: [
                          if (provider.isLoadingContext)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: layout.spacing(32),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(color: _accent),
                              ),
                            )
                          else if (overrideContext != null) ...[
                            _CriticalBanner(layout: layout, l10n: l10n),
                            SizedBox(height: layout.spacing(14)),
                            _ResultCard(
                              layout: layout,
                              l10n: l10n,
                              result: overrideContext.result,
                              statusLabel: _statusLabel(
                                l10n,
                                overrideContext.result,
                              ),
                            ),
                            SizedBox(height: layout.spacing(14)),
                            StaffSupervisorSectionCard(
                              title: provider.isContextualActionLocked
                                  ? l10n.staffSupervisorAuthorizeReentryAction
                                  : l10n.staffSupervisorOverrideActionsTitle,
                              child: _buildActionsGrid(l10n, layout, provider),
                            ),
                            SizedBox(height: layout.spacing(14)),
                            StaffSupervisorSectionCard(
                              title: l10n.staffSupervisorReasonTitle,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextField(
                                    controller: provider.reasonController,
                                    maxLines: 1,
                                    onChanged: (_) => provider.notifyFormChanged(),
                                    decoration: staffSupervisorInputDecoration(
                                      layout,
                                      hint: l10n
                                          .staffSupervisorEntryOverrideReasonPlaceholder,
                                    ),
                                  ),
                                  SizedBox(height: layout.spacing(8)),
                                  AppText(
                                    l10n.staffSupervisorEntryOverrideReasonHint,
                                    variant: AppTextVariant.body,
                                    color: AppColors.secondaryGrey,
                                    fontSize: layout.fontSize(12),
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: layout.spacing(14)),
                            StaffSupervisorOverrideAuthorizationCard(
                              l10n: l10n,
                              pinController: provider.pinController,
                              supervisorName: _supervisorName(context),
                              onPinChanged: provider.notifyFormChanged,
                            ),
                            SizedBox(height: layout.spacing(14)),
                            _ExpectedResultCard(
                              layout: layout,
                              l10n: l10n,
                              selectedAction: provider.selectedAction,
                            ),
                            SizedBox(height: layout.spacing(14)),
                            _LogsCard(
                              layout: layout,
                              l10n: l10n,
                              logs: overrideContext.logs,
                            ),
                          ],
                        ],
                      ),
              ),
              if (overrideContext != null)
                StaffSupervisorExecuteFooter(
                  label: provider.isContextualActionLocked &&
                          provider.selectedAction ==
                              StaffSupervisorEntryOverrideAction.authorizeReentry
                      ? l10n.staffSupervisorAuthorizeReentryAction
                      : l10n.staffSupervisorExecuteOverrideButton,
                  enabled: provider.canSubmit,
                  isLoading: provider.isSubmitting,
                  leading: StaffSupervisorShieldStarIcon(
                    size: layout.spacing(20),
                    color: AppColors.backgroundWhite,
                  ),
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

  static Future<void> _handleSubmit(
    BuildContext context,
    StaffSupervisorEntryQrOverrideProvider provider,
  ) async {
    final success = await provider.submit();
    if (!context.mounted) {
      return;
    }

    if (success) {
      AppSnackBar.showSuccess(
        context,
        context.l10n.staffSupervisorEntryOverrideSuccess,
      );
      Navigator.of(context).pop();
      return;
    }

    final error = provider.submitError;
    if (error != null) {
      AppSnackBar.show(context, error);
    }
  }

  static Widget _buildActionRadio(
    AppLocalizations l10n,
    ResponsiveLayout layout,
    StaffSupervisorEntryQrOverrideProvider provider,
    StaffSupervisorEntryOverrideAction action,
  ) {
    return _ReasonRadioTile(
      layout: layout,
      label: _actionLabel(l10n, action),
      selected: provider.selectedAction == action,
      onTap: () => provider.selectAction(action),
    );
  }

  static Widget _buildActionsGrid(
    AppLocalizations l10n,
    ResponsiveLayout layout,
    StaffSupervisorEntryQrOverrideProvider provider,
  ) {
    // Contextual lock: when opened from Search/Manage with one action,
    // do not show the old multi-option override menu.
    final lockedAction = provider.selectedAction;
    final isContextual = provider.isContextualActionLocked;

    if (isContextual && lockedAction != null) {
      return _ActionRadioTileLocked(
        layout: layout,
        label: _actionLabel(l10n, lockedAction),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _leftColumnActions
                .map(
                  (action) => _buildActionRadio(l10n, layout, provider, action),
                )
                .toList(),
          ),
        ),
        SizedBox(width: layout.spacing(8)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _rightColumnActions
                .map(
                  (action) => _buildActionRadio(l10n, layout, provider, action),
                )
                .toList(),
          ),
        ),
      ],
    );
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

  static String _supervisorName(BuildContext context) {
    final name = context.read<StaffAuthProvider>().profile?.name;
    if (name == null || name.trim().isEmpty) {
      return 'Supervisor';
    }
    return name.trim();
  }

  static String _actionLabel(
    AppLocalizations l10n,
    StaffSupervisorEntryOverrideAction action,
  ) {
    return switch (action) {
      StaffSupervisorEntryOverrideAction.releaseQr =>
        l10n.staffSupervisorOverrideReleaseQr,
      StaffSupervisorEntryOverrideAction.revalidateQr =>
        l10n.staffSupervisorOverrideRevalidateQr,
      StaffSupervisorEntryOverrideAction.revertValidation =>
        l10n.staffSupervisorRevertValidation,
      StaffSupervisorEntryOverrideAction.authorizeReentry =>
        l10n.staffSupervisorOverrideAuthorizeReentry,
      StaffSupervisorEntryOverrideAction.temporaryUnlock =>
        l10n.staffSupervisorOverrideTemporaryUnlock,
    };
  }

  static String _statusLabel(
    AppLocalizations l10n,
    StaffSupervisorEntryOverrideResult result,
  ) {
    if (result.isBlocked) {
      return l10n.staffSupervisorOverrideStatusBlocked;
    }
    if (result.isValidated) {
      return l10n.staffSupervisorEntryStatusValidated;
    }
    return l10n.staffSupervisorEntryStatusPending;
  }
}

class _CriticalBanner extends StatelessWidget {
  const _CriticalBanner({required this.layout, required this.l10n});

  static const _accent = AppColors.homeAccentYellow;
  static const _warningBg = Color(0xFFFFF8EB);

  final ResponsiveLayout layout;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(layout.spacing(14)),
      decoration: BoxDecoration(
        color: _warningBg,
        border: Border.all(color: _accent.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(layout.radius(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: _accent, size: layout.spacing(24)),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.staffSupervisorOverrideCriticalTitle,
                  variant: AppTextVariant.bodyEmphasis,
                  color: _accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(13),
                  letterSpacing: 0.6,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  l10n.staffSupervisorEntryOverrideCriticalBody,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(13),
                  height: 1.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.layout,
    required this.l10n,
    required this.result,
    required this.statusLabel,
  });

  static const _accent = AppColors.homeAccentYellow;
  static const _blockedText = Color(0xFFE85D04);
  static const _successGreen = Color(0xFF22C55E);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorEntryOverrideResult result;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final statusColor = result.isBlocked
        ? _blockedText
        : result.isValidated
            ? _successGreen
            : AppColors.secondaryGrey;

    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorResultFoundTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: layout.spacing(22),
                backgroundColor: const Color(0xFFFFF8EB),
                child: AppText(
                  result.initials,
                  variant: AppTextVariant.bodyEmphasis,
                  color: _accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(14),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      result.guestName,
                      variant: AppTextVariant.bodyEmphasis,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w800,
                      fontSize: layout.fontSize(16),
                    ),
                    SizedBox(height: layout.spacing(10)),
                    Row(
                      children: [
                        Expanded(
                          child: _MetaCell(
                            layout: layout,
                            icon: Icons.event_rounded,
                            label: l10n.staffSupervisorResultEventLabel,
                            value: result.eventName,
                          ),
                        ),
                        Expanded(
                          child: _MetaCell(
                            layout: layout,
                            icon: Icons.confirmation_number_outlined,
                            label: l10n.staffEntryValidTicketTypeLabel,
                            value: result.ticketTypeLabel,
                          ),
                        ),
                        Expanded(
                          child: _MetaCell(
                            layout: layout,
                            icon: Icons.shield_outlined,
                            label: l10n.staffSupervisorEntryAccessLabel,
                            value: result.accessLabel,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing(16)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(layout.radius(12)),
              border: Border.all(color: AppColors.homeDividerGrey),
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _ResultGridCell(
                          layout: layout,
                          icon: Icons.qr_code_2_rounded,
                          iconColor: AppColors.homeBlack,
                          label: l10n.staffSupervisorOverrideQrIdLabel,
                          value: result.qrId,
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: AppColors.homeDividerGrey,
                      ),
                      Expanded(
                        child: _ResultStatusGridCell(
                          layout: layout,
                          label: l10n.staffSupervisorOverrideCurrentStatusLabel,
                          statusLabel: statusLabel,
                          isBlocked: result.isBlocked,
                          isValidated: result.isValidated,
                          statusColor: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: AppColors.homeDividerGrey),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _ResultGridCell(
                          layout: layout,
                          icon: Icons.schedule_rounded,
                          iconColor: AppColors.homeBlack,
                          label: l10n.staffSupervisorOverrideLastUseLabel,
                          value: result.lastUsedAtLabel,
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: AppColors.homeDividerGrey,
                      ),
                      Expanded(
                        child: _ResultGridCell(
                          layout: layout,
                          icon: Icons.qr_code_scanner_rounded,
                          iconColor: AppColors.homeBlack,
                          label: l10n.staffSupervisorOverrideScannerLabel,
                          value: result.scannerId,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultGridCell extends StatelessWidget {
  const _ResultGridCell({
    required this.layout,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(layout.spacing(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: layout.spacing(16)),
          SizedBox(height: layout.spacing(6)),
          AppText(
            '$label:',
            variant: AppTextVariant.body,
            color: AppColors.secondaryGrey,
            fontSize: layout.fontSize(11),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: layout.spacing(2)),
          AppText(
            value,
            variant: AppTextVariant.bodyEmphasis,
            color: AppColors.homeBlack,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ResultStatusGridCell extends StatelessWidget {
  const _ResultStatusGridCell({
    required this.layout,
    required this.label,
    required this.statusLabel,
    required this.isBlocked,
    required this.isValidated,
    required this.statusColor,
  });

  static const _dangerRed = Color(0xFFDC2626);

  final ResponsiveLayout layout;
  final String label;
  final String statusLabel;
  final bool isBlocked;
  final bool isValidated;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(layout.spacing(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            '$label:',
            variant: AppTextVariant.body,
            color: AppColors.secondaryGrey,
            fontSize: layout.fontSize(11),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: layout.spacing(8)),
          Row(
            children: [
              if (isBlocked)
                Container(
                  width: layout.spacing(18),
                  height: layout.spacing(18),
                  decoration: const BoxDecoration(
                    color: _dangerRed,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.backgroundWhite,
                    size: layout.spacing(12),
                  ),
                )
              else
                Icon(
                  isValidated
                      ? Icons.check_circle_rounded
                      : Icons.schedule_rounded,
                  color: statusColor,
                  size: layout.spacing(18),
                ),
              SizedBox(width: layout.spacing(6)),
              Flexible(
                child: AppText(
                  statusLabel,
                  variant: AppTextVariant.bodyEmphasis,
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(12),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaCell extends StatelessWidget {
  const _MetaCell({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _accent, size: layout.spacing(16)),
        SizedBox(height: layout.spacing(4)),
        AppText(
          label,
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(10),
        ),
        AppText(
          value,
          variant: AppTextVariant.bodyEmphasis,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w700,
          fontSize: layout.fontSize(12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ExpectedResultCard extends StatelessWidget {
  const _ExpectedResultCard({
    required this.layout,
    required this.l10n,
    required this.selectedAction,
  });

  static const _successGreen = Color(0xFF22C55E);
  static const _successBg = Color(0xFFECFDF5);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorEntryOverrideAction? selectedAction;

  bool get _expectsRelease {
    return switch (selectedAction) {
      StaffSupervisorEntryOverrideAction.releaseQr ||
      StaffSupervisorEntryOverrideAction.revertValidation ||
      StaffSupervisorEntryOverrideAction.authorizeReentry ||
      StaffSupervisorEntryOverrideAction.temporaryUnlock =>
        true,
      StaffSupervisorEntryOverrideAction.revalidateQr || null => false,
    };
  }

  @override
  Widget build(BuildContext context) {
    final statusLabel = _expectsRelease
        ? l10n.staffSupervisorEntryOverrideExpectedValid
        : l10n.staffSupervisorEntryStatusValidated;
    final subtext = _expectsRelease
        ? l10n.staffSupervisorEntryOverrideExpectedSubtext
        : l10n.staffSupervisorOverrideExpectedSubtext;

    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorOverrideExpectedResultTitle,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(layout.spacing(14)),
        decoration: BoxDecoration(
          color: _successBg,
          borderRadius: BorderRadius.circular(layout.radius(12)),
          border: Border.all(color: _successGreen.withValues(alpha: 0.35)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle_rounded,
                color: _successGreen, size: layout.spacing(24)),
            SizedBox(width: layout.spacing(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: layout.spacing(6),
                    runSpacing: layout.spacing(4),
                    children: [
                      AppText(
                        l10n.staffSupervisorOverrideExpectedStatusPrefix,
                        variant: AppTextVariant.body,
                        color: AppColors.homeBlack,
                        fontSize: layout.fontSize(13),
                        fontWeight: FontWeight.w600,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: layout.spacing(8),
                          vertical: layout.spacing(2),
                        ),
                        decoration: BoxDecoration(
                          color: _successGreen.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(layout.radius(8)),
                        ),
                        child: AppText(
                          statusLabel,
                          variant: AppTextVariant.bodyEmphasis,
                          color: _successGreen,
                          fontWeight: FontWeight.w800,
                          fontSize: layout.fontSize(12),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: layout.spacing(4)),
                  AppText(
                    subtext,
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogsCard extends StatelessWidget {
  const _LogsCard({
    required this.layout,
    required this.l10n,
    required this.logs,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final AppLocalizations l10n;
  final List<StaffSupervisorEntryOverrideLog> logs;

  String _logLabel(AppLocalizations l10n, StaffSupervisorEntryOverrideLog log) {
    final normalized = log.label.trim().toLowerCase();
    if (normalized.contains('release')) {
      return l10n.staffSupervisorOverrideReleaseQr;
    }
    if (normalized.contains('revalidate')) {
      return l10n.staffSupervisorOverrideRevalidateQr;
    }
    if (normalized.contains('revert')) {
      return l10n.staffSupervisorRevertValidation;
    }
    if (normalized.contains('authorize') || normalized.contains('reentry')) {
      return l10n.staffSupervisorOverrideAuthorizeReentry;
    }
    if (normalized.contains('temporary') || normalized.contains('unlock')) {
      return l10n.staffSupervisorOverrideTemporaryUnlock;
    }
    if (log.kind == StaffSupervisorEntryOverrideLogKind.validated) {
      return l10n.staffSupervisorDuplicateLogValidated;
    }
    if (log.kind == StaffSupervisorEntryOverrideLogKind.blocked) {
      return l10n.staffSupervisorOverrideLogQrBlocked;
    }
    if (log.isPending) {
      return l10n.staffSupervisorOverrideLogPending;
    }

    return log.label;
  }

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return StaffSupervisorSectionCard(
        title: l10n.staffSupervisorOverrideLogsTitle,
        child: AppText(
          l10n.staffSupervisorOverrideLogsEmpty,
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
        ),
      );
    }

    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorOverrideLogsTitle,
      child: Column(
        children: List.generate(logs.length, (index) {
          final log = logs[index];
          final isLast = index == logs.length - 1;
          final label = _logLabel(l10n, log);

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: layout.spacing(40),
                  child: AppText(
                    log.timeLabel,
                    variant: AppTextVariant.body,
                    color: _accent,
                    fontWeight: FontWeight.w700,
                    fontSize: layout.fontSize(12),
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.schedule_rounded,
                        color: _accent, size: layout.spacing(16)),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: EdgeInsets.symmetric(
                            vertical: layout.spacing(2),
                          ),
                          color: _accent.withValues(alpha: 0.55),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: layout.spacing(10)),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: layout.spacing(1),
                      bottom: layout.spacing(isLast ? 0 : 14),
                    ),
                    child: AppText(
                      label,
                      variant: AppTextVariant.body,
                      color: log.isPending ? _accent : AppColors.homeBlack,
                      fontWeight:
                          log.isPending ? FontWeight.w700 : FontWeight.w500,
                      fontSize: layout.fontSize(14),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
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

  static const _accent = AppColors.homeAccentYellow;

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
          padding: EdgeInsets.symmetric(vertical: layout.spacing(8)),
          child: Row(
            children: [
              Container(
                width: layout.spacing(18),
                height: layout.spacing(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? _accent : AppColors.homeDividerGrey,
                    width: selected ? 2 : 1,
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
              SizedBox(width: layout.spacing(10)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: selected ? AppColors.homeBlack : AppColors.secondaryGrey,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: layout.fontSize(13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRadioTileLocked extends StatelessWidget {
  const _ActionRadioTileLocked({
    required this.layout,
    required this.label,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: layout.spacing(8)),
      child: Row(
        children: [
          Container(
            width: layout.spacing(18),
            height: layout.spacing(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _accent, width: 2),
            ),
            child: Center(
              child: Container(
                width: layout.spacing(8),
                height: layout.spacing(8),
                decoration: const BoxDecoration(
                  color: _accent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.body,
              color: AppColors.homeBlack,
              fontWeight: FontWeight.w700,
              fontSize: layout.fontSize(13),
            ),
          ),
        ],
      ),
    );
  }
}
