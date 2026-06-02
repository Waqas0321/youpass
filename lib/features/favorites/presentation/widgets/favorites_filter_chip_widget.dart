import 'package:flutter/material.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';

class FavoritesFilterChipWidget extends StatelessWidget {
  const FavoritesFilterChipWidget({
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          FavoritesDesignSpec.px(context, 20),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: FavoritesDesignSpec.px(context, 16),
            vertical: FavoritesDesignSpec.px(context, 8),
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? FavoritesDesignSpec.chipSelectedFill
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              FavoritesDesignSpec.px(context, 20),
            ),
            border: Border.all(
              color: isSelected
                  ? FavoritesDesignSpec.chipSelectedFill
                  : FavoritesDesignSpec.chipBorder,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 13),
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? FavoritesDesignSpec.chipSelectedText
                  : FavoritesDesignSpec.chipText,
            ),
          ),
        ),
      ),
    );
  }
}
