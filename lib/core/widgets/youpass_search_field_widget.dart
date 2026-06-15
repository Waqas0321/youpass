import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';

class YouPassSearchFieldWidget extends StatelessWidget {
  const YouPassSearchFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusedBorderColor,
  });

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
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
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
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
