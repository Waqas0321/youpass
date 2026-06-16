import 'package:flutter/material.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketActionButtonWidget extends StatelessWidget {
  const AssignTicketActionButtonWidget({
    super.key,
    required this.label,
    required this.foregroundColor,
    this.icon,
    this.leading,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.isLoading = false,
    this.fontSize,
  });

  final String label;
  final IconData? icon;
  final Widget? leading;
  final Color foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? fontSize;

  bool get _hasIcon => leading != null || icon != null;

  @override
  Widget build(BuildContext context) {
    final height = TicketAssignmentDesignSpec.buttonHeight(context);
    final radius = TicketAssignmentDesignSpec.buttonRadius(context);
    final resolvedFontSize = fontSize ?? TicketsDesignSpec.px(context, 11);
    final iconSize = TicketsDesignSpec.px(context, 16);
    final resolvedBorderColor = borderColor ?? foregroundColor;
    final resolvedBackgroundColor =
        backgroundColor ?? TicketAssignmentDesignSpec.fieldFill;
    final labelStyle = TextStyle(
      fontSize: resolvedFontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
    );

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: resolvedBackgroundColor,
          side: BorderSide(color: resolvedBorderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: TicketsDesignSpec.px(context, 6),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: TicketsDesignSpec.px(context, 20),
                height: TicketsDesignSpec.px(context, 20),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foregroundColor,
                ),
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: _hasIcon
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          leading ?? Icon(icon, size: iconSize),
                          SizedBox(width: TicketsDesignSpec.px(context, 4)),
                          Text(
                            label,
                            maxLines: 1,
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: labelStyle,
                          ),
                        ],
                      )
                    : Text(
                        label,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: labelStyle,
                      ),
              ),
      ),
    );
  }
}
