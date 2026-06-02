import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

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
        Icon(icon, size: 18, color: InvitationsDesignSpec.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: InvitationsDesignSpec.bodyText,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
