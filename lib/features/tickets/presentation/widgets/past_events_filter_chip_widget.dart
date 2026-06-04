import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class PastEventsFilterChipWidget extends StatelessWidget {
  const PastEventsFilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final foregroundColor = isSelected
        ? theme.chipSelectedForeground
        : theme.chipUnselectedForeground;
    final fillColor = isSelected
        ? theme.chipSelectedBackground
        : theme.chipUnselectedBackground;
    final borderColor = isSelected
        ? theme.chipSelectedBackground
        : theme.chipUnselectedBorder;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          TicketsDesignSpec.px(context, 20),
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(
              TicketsDesignSpec.px(context, 20),
            ),
            border: Border.all(color: borderColor),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: TicketsDesignSpec.px(context, 16),
            vertical: TicketsDesignSpec.px(context, 8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 13),
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
