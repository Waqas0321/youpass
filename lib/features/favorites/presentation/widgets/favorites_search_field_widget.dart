import 'package:flutter/material.dart';
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
    final radius = FavoritesDesignSpec.px(context, 12);

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: FavoritesDesignSpec.px(context, 13),
          color: FavoritesDesignSpec.bodyText,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: FavoritesDesignSpec.px(context, 20),
          color: FavoritesDesignSpec.metaIcon,
        ),
        filled: true,
        fillColor: FavoritesDesignSpec.searchFill,
        contentPadding: EdgeInsets.symmetric(
          vertical: FavoritesDesignSpec.px(context, 12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: FavoritesDesignSpec.searchBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: FavoritesDesignSpec.searchBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: FavoritesDesignSpec.primary),
        ),
      ),
    );
  }
}
