import 'package:flutter/material.dart';

class YouPassSearchFieldWidget extends StatelessWidget {
  const YouPassSearchFieldWidget({
    super.key,
    required this.hintText,
    this.onChanged,
    this.fillColor = const Color(0xFFF5F5F5),
    this.borderColor = const Color(0xFFE8E8E8),
    this.focusedBorderColor = const Color(0xFFE69D17),
    this.hintColor = const Color(0xFF757575),
    this.iconColor = const Color(0xFF9E9E9E),
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final Color fillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color hintColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13, color: hintColor),
        prefixIcon: Icon(Icons.search, size: 20, color: iconColor),
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
      ),
    );
  }
}
