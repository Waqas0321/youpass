import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_button_theme.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';

class SupportEmailDialog extends StatelessWidget {
  const SupportEmailDialog({
    super.key,
    required this.email,
    this.mailtoUrl,
  });

  final String email;
  final String? mailtoUrl;

  static Future<void> show({
    required BuildContext context,
    required String email,
    String? mailtoUrl,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => SupportEmailDialog(
        email: email,
        mailtoUrl: mailtoUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return YouPassThemedDialogShell(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            AppStrings.profileWriteEmail(strings),
            variant: AppTextVariant.title,
            textAlign: TextAlign.center,
            color: YouPassDialogTheme.title(context),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 12),
          AppText(
            AppStrings.profileSupportEmailMessage(strings, email),
            variant: AppTextVariant.body,
            textAlign: TextAlign.center,
            color: YouPassDialogTheme.body(context),
            fontSize: 14,
            height: 1.45,
          ),
          const SizedBox(height: 24),
          YouPassDialogPrimaryButton(
            label: AppStrings.profileSupportEmailOpen(strings),
            onPressed: () async {
              final url = mailtoUrl ?? 'mailto:$email';
              final opened = await PaymentUrlLauncher.openMailto(url);
              if (!context.mounted) {
                return;
              }
              if (opened) {
                Navigator.of(context).pop();
              } else {
                AppSnackBar.show(context, strings.errorGeneric);
              }
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: email));
                if (!context.mounted) {
                  return;
                }
                Navigator.of(context).pop();
                AppSnackBar.show(
                  context,
                  AppStrings.profileSupportEmailCopied(strings),
                );
              },
              style: YouPassButtonTheme.outlineElevatedStyle(context).copyWith(
                elevation: WidgetStateProperty.all(0),
              ),
              child: Text(AppStrings.profileSupportEmailCopy(strings)),
            ),
          ),
        ],
      ),
    );
  }
}
