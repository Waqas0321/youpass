import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/core/widgets/youpass_primary_button.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/providers/staff_supervisor_session_provider.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/utils/staff_supervisor_routes.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';

class StaffSupervisorPinScreen extends StatefulWidget {
  const StaffSupervisorPinScreen({
    super.key,
    this.supervisorApiService,
  });

  final StaffSupervisorApiService? supervisorApiService;

  @override
  State<StaffSupervisorPinScreen> createState() => _StaffSupervisorPinScreenState();
}

class _StaffSupervisorPinScreenState extends State<StaffSupervisorPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  late final StaffSupervisorApiService _supervisorApiService =
      widget.supervisorApiService ?? StaffSupervisorApiService(ApiClient());

  bool _isPinComplete = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _handlePinChanged(String value) {
    setState(() {
      _isPinComplete = value.length == StaffSupervisorSessionProvider.pinLength;
    });
  }

  String _messageForError(ApiException error, AppLocalizations l10n) {
    switch (error.code) {
      case 'SUPERVISOR_PIN_INVALID':
        return l10n.staffSupervisorPinInvalid;
      case 'SUPERVISOR_PIN_NOT_CONFIGURED':
        return l10n.staffSupervisorPinNotConfigured;
      case 'SUPERVISOR_ACCESS_DENIED':
        return l10n.staffSupervisorPinAccessDenied;
      default:
        return error.message;
    }
  }

  Future<void> _handleContinue() async {
    if (_isSubmitting) {
      return;
    }

    final l10n = context.l10n;
    final pin = _pinController.text.trim();

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _supervisorApiService.validatePin(pin: pin);
      if (!mounted) {
        return;
      }

      context.read<StaffSupervisorSessionProvider>().unlock();
      Navigator.of(context).pushReplacementNamed(
        supervisorDashboardRouteForMode(
          context.read<StaffWorkModeProvider>().mode,
        ),
      );
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }
      AppSnackBar.show(context, _messageForError(error, l10n));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
        children: [
          StaffScanScreenHeader(
            onBack: () => Navigator.of(context).pop(),
            showBottomDivider: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(24),
                layout.spacing(32),
                layout.spacing(24),
                layout.spacing(24),
              ),
              child: Column(
                children: [
                  Container(
                    width: layout.spacing(88),
                    height: layout.spacing(88),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8EB),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFDE6B0)),
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.primaryMustard,
                      size: layout.spacing(40),
                    ),
                  ),
                  SizedBox(height: layout.spacing(24)),
                  AppText(
                    l10n.staffSupervisorPinTitle,
                    variant: AppTextVariant.headline,
                    textAlign: TextAlign.center,
                    color: AppColors.homeBlack,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(24),
                  ),
                  SizedBox(height: layout.spacing(10)),
                  AppText(
                    l10n.staffSupervisorPinSubtitle,
                    variant: AppTextVariant.body,
                    textAlign: TextAlign.center,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(14),
                    height: 1.45,
                  ),
                  SizedBox(height: layout.spacing(32)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      l10n.staffSupervisorPinFieldLabel,
                      variant: AppTextVariant.label,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: layout.spacing(12)),
                  StaffPinInputWidget(
                    controller: _pinController,
                    length: StaffSupervisorSessionProvider.pinLength,
                    onChanged: _handlePinChanged,
                    onCompleted: _handleContinue,
                  ),
                  SizedBox(height: layout.spacing(28)),
                  YouPassPrimaryButton(
                    label: l10n.staffSupervisorPinContinueButton,
                    isEnabled: _isPinComplete && !_isSubmitting,
                    onPressed: _handleContinue,
                  ),
                  SizedBox(height: layout.spacing(20)),
                  AppText(
                    l10n.staffSupervisorPinFooter,
                    variant: AppTextVariant.body,
                    textAlign: TextAlign.center,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(12),
                    height: 1.4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
