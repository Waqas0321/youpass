import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationOutlineActionButtonWidget extends StatelessWidget {
  const InvitationOutlineActionButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: InvitationsDesignSpec.px(context, 38),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: InvitationsDesignSpec.primary,
          side: const BorderSide(
            color: InvitationsDesignSpec.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              InvitationsDesignSpec.px(context, 10),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 11),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
