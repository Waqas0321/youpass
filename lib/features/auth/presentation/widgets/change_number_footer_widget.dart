import 'package:flutter/material.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/auth_divider_link_footer_widget.dart';

class ChangeNumberFooterWidget extends StatelessWidget {
  const ChangeNumberFooterWidget({
    super.key,
    required this.onChangeNumber,
  });

  final VoidCallback onChangeNumber;

  Future<void> _handleTap(BuildContext context) async {
    final confirmMessage = AppProductConfig.uiMessages.changeNumberConfirm;
    if (confirmMessage == null || confirmMessage.isEmpty) {
      onChangeNumber();
      return;
    }

    final strings = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: Text(confirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(strings.confirmDialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(strings.changeNumberLink),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      onChangeNumber();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AuthDividerLinkFooterWidget(
      caption: strings.incorrectNumberQuestion,
      linkLabel: strings.changeNumberLink,
      onLinkTap: () => _handleTap(context),
    );
  }
}
