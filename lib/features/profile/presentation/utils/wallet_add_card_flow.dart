import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/core/utils/webview_platform_init.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/presentation/widgets/add_payment_method_dialog.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_data_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/screens/klap_tokenize_webview_screen.dart';

class WalletAddCardFlow {
  WalletAddCardFlow({
    ProfileApiService? profileApi,
    ConfigApiService? configApi,
  })  : profileApi = profileApi ?? sl<ProfileApiService>(),
        configApi = configApi ?? sl<ConfigApiService>();

  final ProfileApiService profileApi;
  final ConfigApiService configApi;

  /// Prevents stacked tokenize screens / dialogs from rapid taps.
  static bool _inFlight = false;

  Future<bool> start(BuildContext context) async {
    if (_inFlight) {
      return false;
    }
    _inFlight = true;

    final loadingNavigator =
        context.mounted ? Navigator.of(context, rootNavigator: true) : null;
    var loadingVisible = false;

    try {
      if (loadingNavigator != null && context.mounted) {
        loadingVisible = true;
        unawaited(
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            useRootNavigator: true,
            builder: (_) => const PopScope(
              canPop: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
        // Let the loading dialog paint before network work.
        await Future<void>.delayed(Duration.zero);
      }

      ensureWebViewPlatformInitialized();

      final securityFuture = configApi.fetchSecurityConfig();
      final Future<ProfileWalletTokenizeSessionModel>? sessionFuture =
          isWebViewPlatformSupported
              ? profileApi.createWalletTokenizeSession()
              : null;

      final security = await securityFuture;
      final tokenizationRequired =
          security?.paymentTokenizationRequired ?? true;

      if (!tokenizationRequired || sessionFuture == null) {
        if (sessionFuture != null) {
          unawaited(
            sessionFuture.then<void>(
              (_) {},
              onError: (_, _) {},
            ),
          );
        }
        _dismissLoading(loadingNavigator, loadingVisible);
        loadingVisible = false;
        if (!context.mounted) {
          return false;
        }
        return await AddPaymentMethodDialog.show(
          context,
          onSave: (request) => _saveLegacy(context, request),
        );
      }

      final session = await sessionFuture;
      _dismissLoading(loadingNavigator, loadingVisible);
      loadingVisible = false;

      if (!context.mounted) {
        return false;
      }

      final tokenResult =
          await Navigator.of(context).push<PaymentMethodRequestEntity>(
        MaterialPageRoute(
          builder: (_) => KlapTokenizeWebViewScreen(session: session),
        ),
      );

      if (tokenResult == null || !context.mounted) {
        return false;
      }

      try {
        await profileApi.saveWalletCard(tokenResult);
        return true;
      } on ApiException {
        if (context.mounted) {
          AppSnackBar.show(
            context,
            AppStrings.errorGeneric(context.l10n),
          );
        }
        return false;
      }
    } catch (_) {
      _dismissLoading(loadingNavigator, loadingVisible);
      loadingVisible = false;
      if (context.mounted) {
        AppSnackBar.show(
          context,
          AppStrings.errorGeneric(context.l10n),
        );
      }
      return false;
    } finally {
      _dismissLoading(loadingNavigator, loadingVisible);
      _inFlight = false;
    }
  }

  void _dismissLoading(NavigatorState? navigator, bool visible) {
    if (!visible || navigator == null || !navigator.canPop()) {
      return;
    }
    navigator.pop();
  }

  Future<bool> _saveLegacy(
    BuildContext context,
    PaymentMethodRequestEntity request,
  ) async {
    try {
      await profileApi.saveWalletCard(request);
      return true;
    } on ApiException {
      return false;
    }
  }
}
