import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassSearchFieldWidget extends StatelessWidget {
  const YouPassSearchFieldWidget({
    super.key,
    required this.hintText,
    this.onChanged,
    this.focusedBorderColor,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final Color? focusedBorderColor;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;
    final focusColor = focusedBorderColor ?? scheme.primary;
    const radius = 12.0;

    return Material(
      color: theme.searchFill,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: theme.searchBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 13,
          color: scheme.onSurface,
        ),
        cursorColor: focusColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13,
            color: scheme.onSurfaceVariant,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: scheme.onSurfaceVariant,
          ),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: focusColor, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
