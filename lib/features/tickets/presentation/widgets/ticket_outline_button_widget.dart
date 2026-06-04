import 'package:flutter/material.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class TicketOutlineButtonWidget extends StatelessWidget {
  const TicketOutlineButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final height = TicketsDesignSpec.px(context, 44);
    final radius = TicketsDesignSpec.px(context, 10);
    final foregroundColor = TicketsScreenTheme.outlineButtonForeground(context);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: TicketsScreenTheme.outlineButtonBorder(context),
            width: 1.5,
          ),
          backgroundColor: TicketsScreenTheme.outlineButtonFill(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: TicketsDesignSpec.px(context, 22),
                height: TicketsDesignSpec.px(context, 22),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: TicketsDesignSpec.px(context, 18)),
                  SizedBox(width: TicketsDesignSpec.px(context, 8)),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: TicketsDesignSpec.px(context, 13),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
