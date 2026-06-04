import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';

class PaymentSavedReminderRowWidget extends StatelessWidget {
  const PaymentSavedReminderRowWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: YouPassDialogTheme.iconColor(context)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: YouPassDialogTheme.body(context),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
