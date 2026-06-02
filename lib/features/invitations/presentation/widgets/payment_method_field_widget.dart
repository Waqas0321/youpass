import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class PaymentMethodFieldWidget extends StatelessWidget {
  const PaymentMethodFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: InvitationsDesignSpec.titleText,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon == null
                ? null
                : Icon(icon, size: 18, color: InvitationsDesignSpec.metaIcon),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: InvitationsDesignSpec.cardBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: InvitationsDesignSpec.cardBorder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
