import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';

class LeaveWaitlistDialog extends StatelessWidget {
  const LeaveWaitlistDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const LeaveWaitlistDialog(),
    );
    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return AlertDialog(
      title: AppText(AppStrings.waitlistLeaveTitle(strings)),
      content: AppText(AppStrings.waitlistLeaveMessage(strings)),
      actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: AppText(AppStrings.confirmDialogCancel(strings)),
            ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: AppText(AppStrings.waitlistLeaveConfirm(strings)),
        ),
      ],
    );
  }
}
