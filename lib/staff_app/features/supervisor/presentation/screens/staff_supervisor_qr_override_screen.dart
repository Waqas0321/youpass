import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_qr_override_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/widgets/staff_supervisor_drink_search_field.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_page_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

class StaffSupervisorQrOverrideRoute extends StatelessWidget {
  const StaffSupervisorQrOverrideRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorDrinkLookupProvider(
        genericSearchError: l10n.staffSupervisorSearchDrinkSearchError,
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      ),
      child: const StaffSupervisorQrOverrideScreen(),
    );
  }
}

/// Supervisor QR override UI — design-only screen matching the YouPass mockup.
class StaffSupervisorQrOverrideScreen extends StatefulWidget {
  const StaffSupervisorQrOverrideScreen({super.key});

  @override
  State<StaffSupervisorQrOverrideScreen> createState() =>
      _StaffSupervisorQrOverrideScreenState();
}

class _StaffSupervisorQrOverrideScreenState
    extends State<StaffSupervisorQrOverrideScreen> {
  static const _accent = Color(0xFFD4A044);
  static const _pageBg = Color(0xFFF8F9FA);

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  StaffSupervisorQrOverrideAction? _selectedAction;

  @override
  void dispose() {
    _reasonController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  StaffSupervisorQrOverrideResult _resultFromDetail(
    StaffSupervisorDrinkSearchDetail detail,
  ) {
    return StaffSupervisorQrOverrideResult(
      guestName: detail.guestName,
      productName: detail.productName,
      eventName: detail.eventTitle,
      qrId: detail.qrId,
      isBlocked: detail.isBlocked,
      lastUsedAtLabel: detail.lastUsedAtLabel ?? detail.validatedAtLabel ?? '—',
      barName: detail.barName ?? '—',
      scannerId: detail.scannerId ?? '—',
    );
  }

  Future<void> _submitOverride(
    BuildContext context,
    StaffSupervisorDrinkLookupProvider provider,
  ) async {
    final action = _selectedAction;
    if (action == null) {
      return;
    }

    final success = await provider.submitOverride(
      pin: _pinController.text,
      notes: _reasonController.text.trim(),
      action: action,
    );

    if (!context.mounted) {
      return;
    }

    if (success) {
      AppSnackBar.showSuccess(
        context,
        context.l10n.staffSupervisorEntryOverrideSuccess,
      );
      Navigator.of(context).pop(true);
      return;
    }

    if (provider.submitError != null) {
      AppSnackBar.show(context, provider.submitError!);
    }
  }

  String _actionLabel(dynamic l10n, StaffSupervisorQrOverrideAction action) {
    return switch (action) {
      StaffSupervisorQrOverrideAction.releaseQr =>
        l10n.staffSupervisorOverrideReleaseQr,
      StaffSupervisorQrOverrideAction.revalidateQr =>
        l10n.staffSupervisorOverrideRevalidateQr,
      StaffSupervisorQrOverrideAction.revertValidation =>
        l10n.staffSupervisorRevertValidation,
      StaffSupervisorQrOverrideAction.authorizeReconsumption =>
        l10n.staffSupervisorOverrideAuthorizeReconsumption,
      StaffSupervisorQrOverrideAction.temporaryUnlock =>
        l10n.staffSupervisorOverrideTemporaryUnlock,
    };
  }

  InputDecoration _inputDecoration(
    ResponsiveLayout layout, {
    required String hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.secondaryGrey.withValues(alpha: 0.85),
        fontSize: layout.fontSize(14),
      ),
      filled: true,
      fillColor: AppColors.backgroundWhite,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: layout.spacing(14),
        vertical: layout.spacing(14),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(layout.radius(12)),
        borderSide: const BorderSide(color: AppColors.homeDividerGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(layout.radius(12)),
        borderSide: const BorderSide(color: AppColors.homeDividerGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(layout.radius(12)),
        borderSide: const BorderSide(color: _accent, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Consumer<StaffSupervisorDrinkLookupProvider>(
      builder: (context, provider, _) {
        final detail = provider.detail;
        final result = detail == null ? null : _resultFromDetail(detail);
        final logEntries = _logEntriesFromDetail(detail, l10n);

        return Scaffold(
          backgroundColor: _pageBg,
          body: Column(
            children: [
              StaffSupervisorPageHeader(
                title: l10n.staffSupervisorQrOverrideScreenTitle,
                subtitle: l10n.staffSupervisorCancellationsScreenSubtitle,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    layout.spacing(20),
                    layout.spacing(16),
                    layout.spacing(20),
                    layout.spacing(12),
                  ),
                  children: [
                    _CriticalWarningBanner(layout: layout, l10n: l10n),
                    SizedBox(height: layout.spacing(14)),
                    StaffSupervisorDrinkSearchField(
                      controller: provider.search,
                      hint: l10n.staffSupervisorOverrideSearchPlaceholder,
                      sectionTitle: l10n.staffSupervisorOverrideSearchTitle,
                      onResultSelected: provider.onSearchResultSelected,
                    ),
                    if (provider.isLoadingDetail)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
                        child: const Center(
                          child: CircularProgressIndicator(color: _accent),
                        ),
                      )
                    else if (provider.detailError != null)
                      Padding(
                        padding: EdgeInsets.only(top: layout.spacing(14)),
                        child: AppText(
                          provider.detailError!,
                          variant: AppTextVariant.body,
                          color: const Color(0xFFEF4444),
                          fontSize: layout.fontSize(13),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else if (provider.submitError != null)
                      Padding(
                        padding: EdgeInsets.only(top: layout.spacing(14)),
                        child: AppText(
                          provider.submitError!,
                          variant: AppTextVariant.body,
                          color: const Color(0xFFEF4444),
                          fontSize: layout.fontSize(13),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else if (result != null && detail != null) ...[
                  SizedBox(height: layout.spacing(14)),
                  _ResultFoundCard(
                    layout: layout,
                    l10n: l10n,
                    result: result,
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    title: l10n.staffSupervisorOverrideActionsTitle,
                    child: Column(
                      children: StaffSupervisorQrOverrideAction.values
                          .map(
                            (action) => _OverrideRadioTile(
                              layout: layout,
                              label: _actionLabel(l10n, action),
                              selected: _selectedAction == action,
                              onTap: () =>
                                  setState(() => _selectedAction = action),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    title: l10n.staffSupervisorReasonTitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _reasonController,
                          maxLines: 3,
                          onChanged: (_) => setState(() {}),
                          style: TextStyle(
                            fontSize: layout.fontSize(14),
                            color: AppColors.homeBlack,
                          ),
                          decoration: _inputDecoration(
                            layout,
                            hint: l10n.staffSupervisorOverrideReasonPlaceholder,
                          ),
                        ),
                        SizedBox(height: layout.spacing(8)),
                        AppText(
                          l10n.staffSupervisorOverrideReasonHint,
                          variant: AppTextVariant.body,
                          color: AppColors.secondaryGrey,
                          fontSize: layout.fontSize(12),
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    child: layout.isTablet
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _AuthorizationSection(
                                  layout: layout,
                                  l10n: l10n,
                                  pinController: _pinController,
                                  onPinChanged: () => setState(() {}),
                                ),
                              ),
                              SizedBox(width: layout.spacing(16)),
                              Expanded(
                                child: _ExpectedResultSection(
                                  layout: layout,
                                  l10n: l10n,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _AuthorizationSection(
                                layout: layout,
                                l10n: l10n,
                                pinController: _pinController,
                                onPinChanged: () => setState(() {}),
                              ),
                              SizedBox(height: layout.spacing(20)),
                              _ExpectedResultSection(
                                layout: layout,
                                l10n: l10n,
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    title: l10n.staffSupervisorOverrideLogsTitle,
                    child: Column(
                      children: logEntries
                          .map(
                            (entry) => _QrLogTimelineItem(
                              layout: layout,
                              entry: entry,
                              isLast: entry == logEntries.last,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
                  ],
                ),
              ),
              _ExecuteFooter(
                layout: layout,
                label: l10n.staffSupervisorExecuteOverrideButton,
                enabled: result != null &&
                    !provider.isSubmitting &&
                    _selectedAction != null &&
                    _reasonController.text.trim().isNotEmpty &&
                    _pinController.text.length == 4,
                onPressed: () => _submitOverride(context, provider),
              ),
            ],
          ),
        );
      },
    );
  }

  List<StaffSupervisorQrLogEntry> _logEntriesFromDetail(
    StaffSupervisorDrinkSearchDetail? detail,
    dynamic l10n,
  ) {
    if (detail == null || detail.recentEvents.isEmpty) {
      return StaffSupervisorQrLogEntry.demoLogs;
    }

    return detail.recentEvents
        .map(
          (event) => StaffSupervisorQrLogEntry(
            timeLabel: event.timeLabel,
            label: event.detail,
            isBlocked: event.kind == StaffSupervisorDrinkEventKind.duplicate,
            isPending: event.kind == StaffSupervisorDrinkEventKind.supervisor,
          ),
        )
        .toList();
  }
}

class _CriticalWarningBanner extends StatelessWidget {
  const _CriticalWarningBanner({required this.layout, required this.l10n});

  static const _dangerRed = Color(0xFFDC2626);
  static const _bannerBg = Color(0xFFFFF1F2);

  final ResponsiveLayout layout;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(layout.spacing(14)),
      decoration: BoxDecoration(
        color: _bannerBg,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: _dangerRed.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: _dangerRed,
            size: layout.spacing(22),
          ),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.staffSupervisorOverrideCriticalTitle,
                  variant: AppTextVariant.label,
                  color: _dangerRed,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(12),
                  letterSpacing: 0.8,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  l10n.staffSupervisorOverrideCriticalBody,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(13),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultFoundCard extends StatelessWidget {
  const _ResultFoundCard({
    required this.layout,
    required this.l10n,
    required this.result,
  });

  static const _dangerRed = Color(0xFFDC2626);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorQrOverrideResult result;

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: AppColors.homeDividerGrey,
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.secondaryGrey,
                  size: layout.spacing(24),
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
                    SizedBox(height: layout.spacing(8)),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorConsumptionProductLabel,
                      value: result.productName,
                    ),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorResultEventLabel,
                      value: result.eventName,
                    ),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorOverrideQrIdLabel,
                      value: result.qrId,
                    ),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorOverrideCurrentStatusLabel,
                      value: l10n.staffSupervisorOverrideStatusBlocked,
                      valueColor: _dangerRed,
                      trailing: Icon(
                        Icons.cancel_rounded,
                        color: _dangerRed,
                        size: layout.spacing(18),
                      ),
                    ),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorOverrideLastUseLabel,
                      value: result.lastUsedAtLabel,
                    ),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorConsumptionBarLabel,
                      value: result.barName,
                    ),
                    StaffSupervisorDetailRow(
                      label: l10n.staffSupervisorOverrideScannerLabel,
                      value: result.scannerId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthorizationSection extends StatelessWidget {
  const _AuthorizationSection({
    required this.layout,
    required this.l10n,
    required this.pinController,
    required this.onPinChanged,
  });

  static const _accent = Color(0xFFD4A044);
  static const _dangerRed = Color(0xFFDC2626);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final TextEditingController pinController;
  final VoidCallback onPinChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          l10n.staffSupervisorAuthorizationTitle,
          variant: AppTextVariant.label,
          color: _accent,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(12),
          letterSpacing: 0.9,
        ),
        SizedBox(height: layout.spacing(12)),
        StaffSupervisorDetailRow(
          label: l10n.staffSupervisorAuthorizationSupervisorLabel,
          value: 'Admin-02',
        ),
        AppText(
          l10n.staffSupervisorAuthorizationPinLabel,
          variant: AppTextVariant.label,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: layout.spacing(12)),
        StaffPinInputWidget(
          controller: pinController,
          style: StaffPinInputStyle.boxes,
          obscureBoxDigits: true,
          autofocus: false,
          onChanged: (_) => onPinChanged(),
        ),
        SizedBox(height: layout.spacing(14)),
        Row(
          children: [
            AppText(
              l10n.staffSupervisorOverrideAuthLevelLabel,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
            ),
            SizedBox(width: layout.spacing(8)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: layout.spacing(10),
                vertical: layout.spacing(4),
              ),
              decoration: BoxDecoration(
                color: _dangerRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(layout.radius(20)),
                border: Border.all(color: _dangerRed.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: layout.spacing(8),
                    height: layout.spacing(8),
                    decoration: const BoxDecoration(
                      color: _dangerRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: layout.spacing(6)),
                  AppText(
                    l10n.staffSupervisorOverrideAuthLevelHigh,
                    variant: AppTextVariant.bodyEmphasis,
                    color: _dangerRed,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(12),
                    letterSpacing: 0.6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExpectedResultSection extends StatelessWidget {
  const _ExpectedResultSection({required this.layout, required this.l10n});

  static const _accent = Color(0xFFD4A044);
  static const _successGreen = Color(0xFF22C55E);
  static const _successBg = Color(0xFFECFDF5);

  final ResponsiveLayout layout;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          l10n.staffSupervisorOverrideExpectedResultTitle,
          variant: AppTextVariant.label,
          color: _accent,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(12),
          letterSpacing: 0.9,
        ),
        SizedBox(height: layout.spacing(12)),
        Container(
          padding: EdgeInsets.all(layout.spacing(14)),
          decoration: BoxDecoration(
            color: _successBg,
            borderRadius: BorderRadius.circular(layout.radius(12)),
            border: Border.all(color: _successGreen.withValues(alpha: 0.35)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: _successGreen,
                size: layout.spacing(22),
              ),
              SizedBox(width: layout.spacing(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      l10n.staffSupervisorOverrideExpectedStatus,
                      variant: AppTextVariant.bodyEmphasis,
                      color: _successGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: layout.fontSize(14),
                    ),
                    SizedBox(height: layout.spacing(4)),
                    AppText(
                      l10n.staffSupervisorOverrideExpectedSubtext,
                      variant: AppTextVariant.body,
                      color: AppColors.homeBlack,
                      fontSize: layout.fontSize(13),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QrLogTimelineItem extends StatelessWidget {
  const _QrLogTimelineItem({
    required this.layout,
    required this.entry,
    required this.isLast,
  });

  static const _accent = Color(0xFFD4A044);
  static const _dangerRed = Color(0xFFDC2626);

  final ResponsiveLayout layout;
  final StaffSupervisorQrLogEntry entry;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final labelColor = entry.isBlocked
        ? _dangerRed
        : entry.isPending
            ? _accent
            : AppColors.homeBlack;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: layout.spacing(56),
            child: Column(
              children: [
                AppText(
                  entry.timeLabel,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(12),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: layout.spacing(10),
                height: layout.spacing(10),
                decoration: BoxDecoration(
                  color: entry.isPending ? _accent : AppColors.homeDividerGrey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: entry.isPending ? _accent : AppColors.lightGreyBorder,
                    width: 2,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.homeDividerGrey,
                  ),
                ),
            ],
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: layout.spacing(isLast ? 0 : 14)),
              child: AppText(
                entry.label,
                variant: AppTextVariant.body,
                color: labelColor,
                fontSize: layout.fontSize(14),
                fontWeight: entry.isPending ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExecuteFooter extends StatelessWidget {
  const _ExecuteFooter({
    required this.layout,
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  static const _accent = Color(0xFFD4A044);
  static const _pageBg = Color(0xFFF8F9FA);

  final ResponsiveLayout layout;
  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _pageBg,
      padding: EdgeInsets.fromLTRB(
        layout.spacing(20),
        layout.spacing(8),
        layout.spacing(20),
        layout.spacing(24),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: layout.buttonHeight,
          child: ElevatedButton.icon(
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _accent,
              disabledBackgroundColor: _accent.withValues(alpha: 0.42),
              foregroundColor: AppColors.backgroundWhite,
              disabledForegroundColor:
                  AppColors.backgroundWhite.withValues(alpha: 0.85),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(layout.radius(16)),
              ),
            ),
            icon: Icon(Icons.lock_outline_rounded, size: layout.spacing(20)),
            label: AppText(
              label,
              variant: AppTextVariant.button,
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(14),
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class _OverrideRadioTile extends StatelessWidget {
  const _OverrideRadioTile({
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
        borderRadius: BorderRadius.circular(layout.radius(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
          child: Row(
            children: [
              Container(
                width: layout.spacing(22),
                height: layout.spacing(22),
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
                          width: layout.spacing(10),
                          height: layout.spacing(10),
                          decoration: const BoxDecoration(
                            color: _accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(14),
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
