import 'package:flutter/material.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/presentation/widgets/add_payment_method_dialog.dart';
import 'package:youpass/core/utils/webview_platform_init.dart';
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

  Future<bool> start(BuildContext context) async {
    final security = await configApi.fetchSecurityConfig();
    final tokenizationRequired =
        security?.paymentTokenizationRequired ?? true;

    if (!tokenizationRequired) {
      if (!context.mounted) {
        return false;
      }
      return AddPaymentMethodDialog.show(
        context,
        onSave: (request) => _saveLegacy(context, request),
      );
    }

    final session = await profileApi.createWalletTokenizeSession();
    if (!context.mounted) {
      return false;
    }

    ensureWebViewPlatformInitialized();
    if (!isWebViewPlatformSupported) {
      return AddPaymentMethodDialog.show(
        context,
        onSave: (request) => _saveLegacy(context, request),
      );
    }

    final tokenResult = await Navigator.of(context).push<PaymentMethodRequestEntity>(
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
      return false;
    }
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
