import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/youpass_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesSearchFieldWidget extends StatelessWidget {
  const FavoritesSearchFieldWidget({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return YouPassSearchFieldWidget(
      hintText: hintText,
      onChanged: onChanged,
      focusedBorderColor: FavoritesDesignSpec.primary,
    );
  }
}
