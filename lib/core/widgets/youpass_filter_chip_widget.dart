import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassFilterChipWidget extends StatelessWidget {
  const YouPassFilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
    this.unselectedTextColor,
    this.unselectedBorderColor,
    this.selectedTextColor,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? unselectedTextColor;
  final Color? unselectedBorderColor;
  final Color? selectedTextColor;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final fillColor =
        isSelected ? (selectedColor ?? theme.chipSelectedBackground) : theme.chipUnselectedBackground;
    final borderColor = isSelected
        ? (selectedColor ?? theme.chipSelectedBackground)
        : (unselectedBorderColor ?? theme.chipUnselectedBorder);
    final textColor = isSelected
        ? (selectedTextColor ?? theme.chipSelectedForeground)
        : (unselectedTextColor ?? theme.chipUnselectedForeground);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
