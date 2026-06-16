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
    this.foregroundColor,
    this.borderColor,
    this.fontSize,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final height = TicketsDesignSpec.px(context, 44);
    final radius = height / 2;
    final resolvedForegroundColor =
        foregroundColor ?? TicketsScreenTheme.outlineButtonForeground(context);
    final resolvedBorderColor =
        borderColor ?? TicketsScreenTheme.outlineButtonBorder(context);
    final resolvedFontSize = fontSize ?? TicketsDesignSpec.px(context, 13);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: resolvedForegroundColor,
          side: BorderSide(
            color: resolvedBorderColor,
            width: 1.5,
          ),
          backgroundColor: TicketsScreenTheme.outlineButtonFill(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: TicketsDesignSpec.px(context, 8),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: TicketsDesignSpec.px(context, 22),
                height: TicketsDesignSpec.px(context, 22),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: resolvedForegroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: TicketsDesignSpec.px(context, 18)),
                  SizedBox(width: TicketsDesignSpec.px(context, 6)),
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: resolvedFontSize,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
