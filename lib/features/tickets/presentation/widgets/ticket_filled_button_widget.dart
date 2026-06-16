import 'package:flutter/material.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class TicketFilledButtonWidget extends StatelessWidget {
  const TicketFilledButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final height = TicketsDesignSpec.px(context, 44);
    final radius = height / 2;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.7),
          disabledForegroundColor: foregroundColor,
          elevation: 0,
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
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
