import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationFilledActionButtonWidget extends StatelessWidget {
  const InvitationFilledActionButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor = InvitationsDesignSpec.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: InvitationsDesignSpec.px(context, 38),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
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
