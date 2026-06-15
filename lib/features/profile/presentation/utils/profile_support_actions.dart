import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/profile/data/models/support_faq_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/routes/faq_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class ProfileSupportActions {
  const ProfileSupportActions(
    this.context, {
    this.contact,
    this.sourceContext = 'My Profile',
  });

  final BuildContext context;
  final SupportContactModel? contact;
  final String sourceContext;

  ProfileApiService get _api => sl<ProfileApiService>();

  Future<void> openWhatsApp() async {
    final strings = context.l10n;

    try {
      final data = await _api.fetchWhatsAppTemplate(context: sourceContext);
      if (!context.mounted) {
        return;
      }

      final url = data['whatsapp_url'] as String?;
      final outsideReply = data['outside_hours_auto_reply'] as String?;

      if (url == null || url.isEmpty) {
        AppSnackBar.show(context, strings.errorGeneric);
        return;
      }

      final canOpen = await PaymentUrlLauncher.canOpenExternalUrl(url);
      if (!context.mounted) {
        return;
      }

      if (!canOpen) {
        AppSnackBar.show(context, AppStrings.profileWhatsAppNotInstalled(strings));
        return;
      }

      final opened = await PaymentUrlLauncher.openExternalUrl(url);
      if (!context.mounted) {
        return;
      }

      if (!opened) {
        AppSnackBar.show(context, AppStrings.profileWhatsAppNotInstalled(strings));
        return;
      }

      if (outsideReply != null && outsideReply.isNotEmpty) {
        AppSnackBar.show(context, outsideReply);
      }
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.show(context, strings.errorGeneric);
      }
    }
  }

  Future<void> openEmail() async {
    final strings = context.l10n;

    try {
      final data = await _api.fetchEmailTemplate(context: sourceContext);
      if (!context.mounted) {
        return;
      }

      final mailtoUrl = data['mailto_url'] as String?;

      if (mailtoUrl == null || mailtoUrl.isEmpty) {
        AppSnackBar.show(context, strings.errorGeneric);
        return;
      }

      final opened = await PaymentUrlLauncher.openMailto(mailtoUrl);
      if (!opened && context.mounted) {
        AppSnackBar.show(context, strings.errorGeneric);
      }
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.show(context, strings.errorGeneric);
      }
    }
  }

  void openFaq() {
    Navigator.of(context).pushNamed(
      AppRoutes.profileFaq,
      arguments: FaqRouteArgs(contact: contact),
    );
  }
}
