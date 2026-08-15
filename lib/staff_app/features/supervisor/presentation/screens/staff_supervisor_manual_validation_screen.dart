import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_action_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/providers/staff_supervisor_drink_lookup_provider.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/widgets/staff_supervisor_drink_search_field.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_page_header.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_temporary_qr_dialog.dart';

class StaffSupervisorManualValidationRoute extends StatelessWidget {
  const StaffSupervisorManualValidationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ChangeNotifierProvider(
      create: (_) => StaffSupervisorDrinkLookupProvider(
        genericSearchError: l10n.staffSupervisorSearchDrinkSearchError,
        genericLoadError: l10n.staffSupervisorSearchDrinkSearchError,
      ),
      child: const StaffSupervisorManualValidationScreen(),
    );
  }
}

/// Supervisor manual validation UI — design-only screen matching the YouPass mockup.
class StaffSupervisorManualValidationScreen extends StatefulWidget {
  const StaffSupervisorManualValidationScreen({super.key});

  @override
  State<StaffSupervisorManualValidationScreen> createState() =>
      _StaffSupervisorManualValidationScreenState();
}

class _StaffSupervisorManualValidationScreenState
    extends State<StaffSupervisorManualValidationScreen> {
  static const _accent = Color(0xFFD4A044);
  static const _pageBg = Color(0xFFF8F9FA);
  static const _dangerRed = Color(0xFFDC2626);

  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  StaffSupervisorManualValidationReason? _selectedReason;

  @override
  void dispose() {
    _reasonController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  bool get _canSubmitManualValidation =>
      _selectedReason != null &&
      _reasonController.text.trim().isNotEmpty &&
      _pinController.text.length == 4;

  Future<void> _submitManualValidation(
    BuildContext context,
    StaffSupervisorDrinkLookupProvider provider,
    StaffSupervisorBarManualValidationAction action,
  ) async {
    final reason = _selectedReason;
    if (reason == null || !_canSubmitManualValidation) {
      return;
    }

    final success = await provider.submitManualValidation(
      pin: _pinController.text,
      notes: _reasonController.text.trim(),
      action: action,
      reason: reason,
    );

    if (!context.mounted) {
      return;
    }

    if (!success) {
      if (provider.submitError != null) {
        AppSnackBar.show(context, provider.submitError!);
      }
      return;
    }

    final temporaryQr = provider.temporaryQr;
    if (temporaryQr != null) {
      AppSnackBar.showSuccess(
        context,
        context.l10n.staffSupervisorTemporaryQrGeneratedSuccess,
      );
      await StaffSupervisorTemporaryQrDialog.show(
        context,
        temporaryQr: StaffSupervisorTemporaryQr(
          qrPayload: temporaryQr.qrPayload,
          entryCode: temporaryQr.consumptionId,
          guestName: temporaryQr.guestName,
          expiresAt: DateTime.now().add(
            Duration(minutes: temporaryQr.validityMinutes),
          ),
          validityMinutes: temporaryQr.validityMinutes,
        ),
        l10n: context.l10n,
      );
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(true);
      return;
    }

    AppSnackBar.showSuccess(
      context,
      context.l10n.staffSupervisorEntryManualValidationSuccess,
    );
    Navigator.of(context).pop(true);
  }

  StaffSupervisorManualValidationResult _resultFromDetail(
    StaffSupervisorDrinkSearchDetail detail,
  ) {
    return StaffSupervisorManualValidationResult(
      guestName: detail.guestName,
      eventName: detail.eventTitle,
      productName: detail.productName,
      barName: detail.barName ?? '—',
      lastIdDigits: detail.lastIdDigits,
      isDocumentConfirmed: detail.isDocumentConfirmed,
      isQrUnavailable: detail.isQrUnavailable,
    );
  }

  String _reasonLabel(
    dynamic l10n,
    StaffSupervisorManualValidationReason reason,
  ) {
    return switch (reason) {
      StaffSupervisorManualValidationReason.phoneBattery =>
        l10n.staffSupervisorReasonPhoneBattery,
      StaffSupervisorManualValidationReason.noConnection =>
        l10n.staffSupervisorReasonNoConnection,
      StaffSupervisorManualValidationReason.damagedQr =>
        l10n.staffSupervisorReasonDamagedQr,
      StaffSupervisorManualValidationReason.brokenScreen =>
        l10n.staffSupervisorReasonBrokenScreen,
      StaffSupervisorManualValidationReason.other =>
        l10n.staffSupervisorReasonOther,
    };
  }

  InputDecoration _inputDecoration(
    ResponsiveLayout layout, {
    required String hint,
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
      contentPadding: EdgeInsets.symmetric(
        horizontal: layout.spacing(14),
        vertical: layout.spacing(14),
      ),
      suffixIcon: suffixIcon,
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

        return Scaffold(
          backgroundColor: _pageBg,
          body: Column(
            children: [
              StaffSupervisorPageHeader(
                title: l10n.staffSupervisorManualValidationScreenTitle,
                subtitle: l10n.staffSupervisorCancellationsScreenSubtitle,
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
                    _NoQrBanner(layout: layout, l10n: l10n),
                    SizedBox(height: layout.spacing(14)),
                    StaffSupervisorDrinkSearchField(
                      controller: provider.search,
                      hint: l10n.staffSupervisorSearchPlaceholder,
                      sectionTitle: l10n.staffSupervisorSearchConsumptionHeading,
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
                    else if (result != null && detail != null) ...[
                  SizedBox(height: layout.spacing(14)),
                  _ResultFoundCard(
                    layout: layout,
                    l10n: l10n,
                    result: result,
                    orderCode: detail.orderCode,
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    child: layout.isTablet
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _ValidationReasonSection(
                                  layout: layout,
                                  l10n: l10n,
                                  selectedReason: _selectedReason,
                                  reasonLabel: _reasonLabel,
                                  onReasonSelected: (reason) =>
                                      setState(() => _selectedReason = reason),
                                ),
                              ),
                              SizedBox(width: layout.spacing(16)),
                              Expanded(
                                child: _IdentityValidationSection(
                                  layout: layout,
                                  l10n: l10n,
                                  result: result,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _ValidationReasonSection(
                                layout: layout,
                                l10n: l10n,
                                selectedReason: _selectedReason,
                                reasonLabel: _reasonLabel,
                                onReasonSelected: (reason) =>
                                    setState(() => _selectedReason = reason),
                              ),
                              SizedBox(height: layout.spacing(20)),
                              _IdentityValidationSection(
                                layout: layout,
                                l10n: l10n,
                                result: result,
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    title: l10n.staffSupervisorActionsTitle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: layout.buttonHeight,
                          child: ElevatedButton.icon(
                            onPressed: !provider.isSubmitting &&
                                    _canSubmitManualValidation
                                ? () => _submitManualValidation(
                                      context,
                                      provider,
                                      StaffSupervisorBarManualValidationAction
                                          .authorizeConsumption,
                                    )
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accent,
                              foregroundColor: AppColors.backgroundWhite,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(layout.radius(14)),
                              ),
                            ),
                            icon: Icon(Icons.check_rounded,
                                size: layout.spacing(20)),
                            label: AppText(
                              l10n.staffSupervisorAuthorizeConsumptionButton,
                              variant: AppTextVariant.button,
                              color: AppColors.backgroundWhite,
                              fontWeight: FontWeight.w800,
                              fontSize: layout.fontSize(14),
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                        SizedBox(height: layout.spacing(10)),
                        SizedBox(
                          height: layout.buttonHeight,
                          child: OutlinedButton.icon(
                            onPressed: !provider.isSubmitting &&
                                    _canSubmitManualValidation
                                ? () => _submitManualValidation(
                                      context,
                                      provider,
                                      StaffSupervisorBarManualValidationAction
                                          .generateTemporaryQr,
                                    )
                                : null,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _accent,
                              side: const BorderSide(color: _accent, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(layout.radius(14)),
                              ),
                            ),
                            icon: Icon(Icons.qr_code_scanner_rounded,
                                size: layout.spacing(20), color: _accent),
                            label: AppText(
                              l10n.staffSupervisorGenerateTemporaryQrButton,
                              variant: AppTextVariant.button,
                              color: _accent,
                              fontWeight: FontWeight.w800,
                              fontSize: layout.fontSize(14),
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                        SizedBox(height: layout.spacing(10)),
                        SizedBox(
                          height: layout.buttonHeight,
                          child: OutlinedButton.icon(
                            onPressed: !provider.isSubmitting &&
                                    _canSubmitManualValidation
                                ? () => _submitManualValidation(
                                      context,
                                      provider,
                                      StaffSupervisorBarManualValidationAction
                                          .rejectConsumption,
                                    )
                                : null,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _dangerRed,
                              side: const BorderSide(color: _dangerRed, width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(layout.radius(14)),
                              ),
                            ),
                            icon: Icon(Icons.close_rounded,
                                size: layout.spacing(20), color: _dangerRed),
                            label: AppText(
                              l10n.staffSupervisorRejectButton,
                              variant: AppTextVariant.button,
                              color: _dangerRed,
                              fontWeight: FontWeight.w800,
                              fontSize: layout.fontSize(14),
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  StaffSupervisorSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppText(
                          l10n.staffSupervisorAuthorizationPinLabel,
                          variant: AppTextVariant.label,
                          color: AppColors.secondaryGrey,
                          fontSize: layout.fontSize(13),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: layout.spacing(12)),
                        StaffPinInputWidget(
                          controller: _pinController,
                          style: StaffPinInputStyle.boxes,
                          obscureBoxDigits: true,
                          autofocus: false,
                          onChanged: (_) => setState(() {}),
                        ),
                        SizedBox(height: layout.spacing(20)),
                        AppText(
                          l10n.staffSupervisorReasonTitle,
                          variant: AppTextVariant.label,
                          color: AppColors.secondaryGrey,
                          fontSize: layout.fontSize(13),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: layout.spacing(10)),
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
                            hint: l10n.staffSupervisorValidationReasonPlaceholder,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  _SystemRecordFooter(layout: layout, l10n: l10n),
                ],
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

class _NoQrBanner extends StatelessWidget {
  const _NoQrBanner({required this.layout, required this.l10n});

  static const _accent = Color(0xFFD4A044);
  static const _bannerBg = Color(0xFFFFF8EB);

  final ResponsiveLayout layout;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(layout.spacing(14)),
      decoration: BoxDecoration(
        color: _bannerBg,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: _accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: _accent,
            size: layout.spacing(22),
          ),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  l10n.staffSupervisorNoQrBannerTitle,
                  variant: AppTextVariant.label,
                  color: _accent,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(12),
                  letterSpacing: 0.8,
                ),
                SizedBox(height: layout.spacing(4)),
                AppText(
                  l10n.staffSupervisorNoQrBannerBody,
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
    required this.orderCode,
  });

  static const _accent = Color(0xFFD4A044);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorManualValidationResult result;
  final String orderCode;

  @override
  Widget build(BuildContext context) {
    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorResultFoundTitle,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: layout.spacing(4),
            child: AppText(
              orderCode.isNotEmpty ? orderCode : l10n.staffSupervisorResultPurchaseLabel,
              variant: AppTextVariant.body,
              color: AppColors.homeDividerGrey,
              fontSize: layout.fontSize(28),
              fontWeight: FontWeight.w800,
            ),
          ),
          Column(
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
                          label: l10n.staffSupervisorResultEventLabel,
                          value: result.eventName,
                        ),
                        StaffSupervisorDetailRow(
                          label: l10n.staffSupervisorConsumptionProductLabel,
                          value: result.productName,
                        ),
                        StaffSupervisorDetailRow(
                          label: l10n.staffSupervisorConsumptionBarLabel,
                          value: result.barName,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: layout.spacing(4)),
              Row(
                children: [
                  AppText(
                    '${l10n.staffSupervisorQrStatusLabel}:',
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
                  ),
                  SizedBox(width: layout.spacing(8)),
                  Icon(
                    Icons.warning_amber_rounded,
                    color: _accent,
                    size: layout.spacing(18),
                  ),
                  SizedBox(width: layout.spacing(4)),
                  AppText(
                    l10n.staffSupervisorQrStatusUnavailable,
                    variant: AppTextVariant.bodyEmphasis,
                    color: _accent,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(13),
                    letterSpacing: 0.5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ValidationReasonSection extends StatelessWidget {
  const _ValidationReasonSection({
    required this.layout,
    required this.l10n,
    required this.selectedReason,
    required this.reasonLabel,
    required this.onReasonSelected,
  });

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorManualValidationReason? selectedReason;
  final String Function(dynamic, StaffSupervisorManualValidationReason) reasonLabel;
  final ValueChanged<StaffSupervisorManualValidationReason> onReasonSelected;

  static const _accent = Color(0xFFD4A044);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          l10n.staffSupervisorValidationReasonTitle,
          variant: AppTextVariant.label,
          color: _accent,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(12),
          letterSpacing: 0.9,
        ),
        SizedBox(height: layout.spacing(12)),
        ...StaffSupervisorManualValidationReason.values.map(
          (reason) => _ReasonRadioTile(
            layout: layout,
            label: reasonLabel(l10n, reason),
            selected: selectedReason == reason,
            onTap: () => onReasonSelected(reason),
          ),
        ),
      ],
    );
  }
}

class _IdentityValidationSection extends StatelessWidget {
  const _IdentityValidationSection({
    required this.layout,
    required this.l10n,
    required this.result,
  });

  static const _accent = Color(0xFFD4A044);
  static const _successGreen = Color(0xFF22C55E);

  final ResponsiveLayout layout;
  final dynamic l10n;
  final StaffSupervisorManualValidationResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          l10n.staffSupervisorIdentityValidationTitle,
          variant: AppTextVariant.label,
          color: _accent,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(12),
          letterSpacing: 0.9,
        ),
        SizedBox(height: layout.spacing(12)),
        _IdentityRow(
          layout: layout,
          icon: Icons.person_outline_rounded,
          label: l10n.staffSupervisorIdentityFullNameLabel,
          value: result.guestName,
        ),
        _IdentityRow(
          layout: layout,
          icon: Icons.badge_outlined,
          label: l10n.staffSupervisorIdentityLastDigitsLabel,
          value: result.lastIdDigits,
        ),
        _IdentityRow(
          layout: layout,
          icon: Icons.verified_user_outlined,
          label: l10n.staffSupervisorIdentityDocumentLabel,
          value: l10n.staffSupervisorIdentityConfirmed,
          valueColor: _successGreen,
          trailing: Icon(
            Icons.check_circle_rounded,
            color: _successGreen,
            size: layout.spacing(18),
          ),
        ),
      ],
    );
  }
}

class _IdentityRow extends StatelessWidget {
  const _IdentityRow({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.trailing,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Widget? trailing;

  static const _accent = Color(0xFFD4A044);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _accent, size: layout.spacing(20)),
          SizedBox(width: layout.spacing(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(12),
                ),
                AppText(
                  value,
                  variant: AppTextVariant.bodyEmphasis,
                  color: valueColor ?? AppColors.homeBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(14),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _SystemRecordFooter extends StatelessWidget {
  const _SystemRecordFooter({required this.layout, required this.l10n});

  static const _accent = Color(0xFFD4A044);

  final ResponsiveLayout layout;
  final dynamic l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(16)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(14)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            l10n.staffSupervisorSystemRecordTitle,
            variant: AppTextVariant.label,
            color: _accent,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(12),
            letterSpacing: 0.9,
          ),
          SizedBox(height: layout.spacing(12)),
          Wrap(
            spacing: layout.spacing(8),
            runSpacing: layout.spacing(6),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _RecordChip(
                layout: layout,
                icon: Icons.person_outline_rounded,
                text: l10n.staffSupervisorSystemRecordSupervisor('Admin-02'),
              ),
              _RecordDot(layout: layout),
              _RecordChip(
                layout: layout,
                icon: Icons.schedule_rounded,
                text: l10n.staffSupervisorSystemRecordTime('00:53'),
              ),
              _RecordDot(layout: layout),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: layout.spacing(16),
                    color: AppColors.secondaryGrey,
                  ),
                  SizedBox(width: layout.spacing(4)),
                  AppText(
                    l10n.staffSupervisorSystemRecordStatus,
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
                  ),
                  AppText(
                    l10n.staffSupervisorSystemRecordStatusPending,
                    variant: AppTextVariant.bodyEmphasis,
                    color: _accent,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(13),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordChip extends StatelessWidget {
  const _RecordChip({
    required this.layout,
    required this.icon,
    required this.text,
  });

  final ResponsiveLayout layout;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: layout.spacing(16), color: AppColors.secondaryGrey),
        SizedBox(width: layout.spacing(4)),
        AppText(
          text,
          variant: AppTextVariant.body,
          color: AppColors.homeBlack,
          fontSize: layout.fontSize(13),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _RecordDot extends StatelessWidget {
  const _RecordDot({required this.layout});

  final ResponsiveLayout layout;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: layout.spacing(4),
      height: layout.spacing(4),
      decoration: BoxDecoration(
        color: AppColors.secondaryGrey.withValues(alpha: 0.5),
        shape: BoxShape.circle,
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
        borderRadius: BorderRadius.circular(layout.radius(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(8)),
          child: Row(
            children: [
              Container(
                width: layout.spacing(20),
                height: layout.spacing(20),
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
                          width: layout.spacing(9),
                          height: layout.spacing(9),
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
                  color: AppColors.homeBlack,
                  fontSize: layout.fontSize(13),
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
