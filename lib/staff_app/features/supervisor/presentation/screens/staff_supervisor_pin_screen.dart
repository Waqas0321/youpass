import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/network/staff_connectivity.dart';
import 'package:youpass/staff_app/core/storage/staff_token_store.dart';
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
    this.tokenStore,
    this.connectivity,
  });

  final StaffSupervisorApiService? supervisorApiService;
  final StaffTokenStore? tokenStore;
  final Connectivity? connectivity;

  @override
  State<StaffSupervisorPinScreen> createState() =>
      _StaffSupervisorPinScreenState();
}

class _StaffSupervisorPinScreenState extends State<StaffSupervisorPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  late final StaffSupervisorApiService _supervisorApiService =
      widget.supervisorApiService ?? StaffSupervisorApiService(ApiClient());
  late final StaffTokenStore _tokenStore =
      widget.tokenStore ?? StaffTokenStore();
  late final Connectivity _connectivity = widget.connectivity ?? Connectivity();

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
      case 'SUPERVISOR_PIN_OFFLINE_UNAVAILABLE':
        return error.message;
      default:
        return error.message;
    }
  }

  Future<void> _unlockAndContinue() async {
    final session = context.read<StaffSupervisorSessionProvider>();
    final mode = context.read<StaffWorkModeProvider>().mode;
    await session.unlock();
    if (!mounted) {
      return;
    }
    Navigator.of(
      context,
    ).pushReplacementNamed(supervisorDashboardRouteForMode(mode));
  }

  Future<bool> _tryOfflinePin(String pin) async {
    final secret = await _tokenStore.readOfflineSigningSecret();
    if (secret == null || secret.isEmpty) {
      return false;
    }
    return _tokenStore.verifySupervisorPinLocally(
      pin: pin,
      signingSecret: secret,
    );
  }

  Future<void> _cachePinVerifier(String pin) async {
    final secret = await _tokenStore.readOfflineSigningSecret();
    if (secret == null || secret.isEmpty) {
      return;
    }
    await _tokenStore.saveSupervisorPinVerifier(
      pin: pin,
      signingSecret: secret,
    );
  }

  bool _looksLikeNetworkError(Object error) {
    if (error is ApiException && error.code == 'NETWORK_ERROR') {
      return true;
    }
    final message = error.toString().toLowerCase();
    return message.contains('timeout') ||
        message.contains('socket') ||
        message.contains('network') ||
        message.contains('connection') ||
        message.contains('failed host lookup') ||
        message.contains('unreachable');
  }

  Future<void> _handleContinue() async {
    if (_isSubmitting) {
      return;
    }

    final l10n = context.l10n;
    final pin = _pinController.text.trim();
    if (pin.length != StaffSupervisorSessionProvider.pinLength) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    var unlocked = false;
    try {
      final online = await staffIsOnline(_connectivity);

      if (!online) {
        final ok = await _tryOfflinePin(pin);
        if (!mounted) {
          return;
        }
        if (!ok) {
          final hasVerifier = await _tokenStore.hasSupervisorPinVerifier();
          if (!mounted) {
            return;
          }
          AppSnackBar.show(
            context,
            hasVerifier
                ? l10n.staffSupervisorPinInvalid
                : l10n.staffSupervisorPinOfflineSetupRequired,
          );
          return;
        }
        unlocked = true;
        await _unlockAndContinue();
        return;
      }

      try {
        await _supervisorApiService.validatePin(pin: pin);
        await _cachePinVerifier(pin);
        if (!mounted) {
          return;
        }
        unlocked = true;
        await _unlockAndContinue();
      } catch (error) {
        if (!mounted) {
          return;
        }
        if (_looksLikeNetworkError(error)) {
          final ok = await _tryOfflinePin(pin);
          if (!mounted) {
            return;
          }
          if (ok) {
            unlocked = true;
            await _unlockAndContinue();
            return;
          }
          final hasVerifier = await _tokenStore.hasSupervisorPinVerifier();
          if (!mounted) {
            return;
          }
          AppSnackBar.show(
            context,
            hasVerifier
                ? l10n.staffSupervisorPinInvalid
                : l10n.staffSupervisorPinOfflineSetupRequired,
          );
          return;
        }
        if (error is ApiException) {
          AppSnackBar.show(context, _messageForError(error, l10n));
        } else {
          AppSnackBar.show(context, error.toString());
        }
      }
    } finally {
      if (mounted) {
        // A rejected PIN is cleared so the supervisor can retype it straight away.
        if (!unlocked) {
          _pinController.clear();
        }
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
