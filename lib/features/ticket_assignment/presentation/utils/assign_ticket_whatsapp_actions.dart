import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';

class AssignTicketWhatsAppActions {
  const AssignTicketWhatsAppActions(this.context);

  final BuildContext context;

  Future<bool> openGuestInviteUrl(String? url) async {
    final strings = context.l10n;
    if (url == null || url.trim().isEmpty) {
      return false;
    }

    final canOpen = await PaymentUrlLauncher.canOpenExternalUrl(url);
    if (!context.mounted) {
      return false;
    }

    if (!canOpen) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.profileWhatsAppNotInstalled(strings))),
      );
      return false;
    }

    final opened = await PaymentUrlLauncher.openExternalUrl(url);
    if (!context.mounted) {
      return opened;
    }

    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.profileWhatsAppNotInstalled(strings))),
      );
    }

    return opened;
  }
}
