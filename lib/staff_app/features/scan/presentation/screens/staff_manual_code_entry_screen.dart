import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/l10n/staff_scan_message_localizer.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/scan/data/staff_scan_api_service.dart';
import 'package:youpass/staff_app/features/scan/domain/models/staff_qr_scan_result.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_result_route_args.dart';
import 'package:youpass/staff_app/features/scan/routes/staff_qr_scan_route_args.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

/// Regular-staff manual code validation (same API path as QR scanning).
class StaffManualCodeEntryScreen extends StatefulWidget {
  const StaffManualCodeEntryScreen({
    super.key,
    required this.purpose,
  });

  final StaffQrScanPurpose purpose;

  @override
  State<StaffManualCodeEntryScreen> createState() =>
      _StaffManualCodeEntryScreenState();
}

class _StaffManualCodeEntryScreenState extends State<StaffManualCodeEntryScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final StaffScanApiService _scanApiService = StaffScanApiService(ApiClient());

  bool _isSubmitting = false;

  bool get _isEntry => widget.purpose == StaffQrScanPurpose.entry;

  bool get _canSubmit => _codeController.text.trim().length >= 4;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _codeController.text.trim().toUpperCase();
    if (code.length < 4 || _isSubmitting) {
      return;
    }

    setState(() => _isSubmitting = true);

    StaffQrScanResult result;
    try {
      result = _isEntry
          ? await _scanApiService.scanEntry(qrPayload: code)
          : await _scanApiService.scanProduct(qrPayload: code);
    } catch (error) {
      if (!mounted) {
        return;
      }
      AppSnackBar.show(
        context,
        StaffScanMessageLocalizer.fromError(context.l10n, error),
      );
      if (error is ApiException &&
          (error.code == 'UNAUTHORIZED' || error.code == 'SESSION_INVALID')) {
        Navigator.of(context).pop();
        return;
      }
      setState(() => _isSubmitting = false);
      return;
    }

    if (!mounted) {
      return;
    }

    final delivered = await Navigator.of(context).pushNamed<bool>(
      StaffAppRoutes.qrScanResult,
      arguments: StaffQrScanResultRouteArgs(result: result),
    );

    if (!mounted) {
      return;
    }

    if (delivered == true) {
      Navigator.of(context).pop(true);
      return;
    }

    _codeController.clear();
    setState(() => _isSubmitting = false);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final title = _isEntry
        ? l10n.staffManualEntryScreenTitle
        : l10n.staffManualConsumptionScreenTitle;
    final subtitle = _isEntry
        ? l10n.staffManualEntryScreenSubtitle
        : l10n.staffManualConsumptionScreenSubtitle;

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
                layout.spacing(24),
                layout.spacing(20),
                layout.spacing(24),
              ),
              children: [
                AppText(
                  title,
                  variant: AppTextVariant.headline,
                  color: AppColors.homeBlack,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(22),
                ),
                SizedBox(height: layout.spacing(8)),
                AppText(
                  subtitle,
                  variant: AppTextVariant.body,
                  color: AppColors.secondaryGrey,
                  fontSize: layout.fontSize(14),
                  height: 1.45,
                ),
                SizedBox(height: layout.spacing(28)),
                TextField(
                  controller: _codeController,
                  focusNode: _focusNode,
                  enabled: !_isSubmitting,
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                    LengthLimitingTextInputFormatter(12),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                        text: newValue.text.toUpperCase(),
                        selection: newValue.selection,
                      );
                    }),
                  ],
                  style: TextStyle(
                    fontSize: layout.fontSize(28),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 4,
                    color: AppColors.homeBlack,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.staffManualEntryCodeHint,
                    hintStyle: TextStyle(
                      fontSize: layout.fontSize(22),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: AppColors.secondaryGrey.withValues(alpha: 0.5),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: layout.spacing(18),
                      vertical: layout.spacing(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(layout.radius(16)),
                      borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(layout.radius(16)),
                      borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(layout.radius(16)),
                      borderSide: const BorderSide(
                        color: AppColors.primaryMustard,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: layout.spacing(20)),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSubmitting || !_canSubmit
                        ? null
                        : _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryMustard,
                      foregroundColor: AppColors.backgroundWhite,
                      disabledBackgroundColor:
                          AppColors.primaryMustard.withValues(alpha: 0.4),
                      padding: EdgeInsets.symmetric(
                        vertical: layout.spacing(16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(layout.radius(16)),
                      ),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            width: layout.spacing(22),
                            height: layout.spacing(22),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: AppColors.backgroundWhite,
                            ),
                          )
                        : AppText(
                            l10n.staffManualEntryValidateButton,
                            variant: AppTextVariant.button,
                            color: AppColors.backgroundWhite,
                            fontWeight: FontWeight.w800,
                            fontSize: layout.fontSize(15),
                            letterSpacing: 0.6,
                          ),
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
