import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/youpass_search_field_widget.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
    required this.onFocusChanged,
    required this.onFilterTap,
    this.onLocationTap,
    this.locationSemanticLabel,
    this.locationIcon,
    this.locationIconSize,
    this.locationSelected = false,
    this.locationLoading = false,
    this.filtersEnabled = true,
  });

  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<bool> onFocusChanged;
  final VoidCallback onFilterTap;
  final VoidCallback? onLocationTap;
  final String? locationSemanticLabel;
  final IconData? locationIcon;
  final double? locationIconSize;
  final bool locationSelected;
  final bool locationLoading;
  final bool filtersEnabled;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locationColor = AppColors.homeBlack;
    final pinSize = locationIconSize ?? layout.fontSize(17 * 1.35 * 1.25);
    final actionSize = layout.spacing(48);

    return Row(
      children: [
        Expanded(
          child: Focus(
            onFocusChange: onFocusChanged,
            child: YouPassSearchFieldWidget(
              hintText: hintText,
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
        ),
        if (onLocationTap != null) ...[
          SizedBox(width: layout.spacing(8)),
          Semantics(
            button: true,
            label: locationSemanticLabel,
            toggled: locationSelected,
            child: _SearchActionButton(
              size: actionSize,
              fill: theme.searchFill,
              border: theme.searchBorder,
              onTap: locationLoading ? null : onLocationTap,
              child: locationLoading
                  ? SizedBox(
                      width: pinSize,
                      height: pinSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: locationColor,
                      ),
                    )
                  : Icon(
                      locationIcon ??
                          (locationSelected
                              ? Icons.location_on
                              : Icons.location_on_outlined),
                      size: pinSize,
                      color: locationColor,
                    ),
            ),
          ),
        ],
        if (filtersEnabled) ...[
          SizedBox(width: layout.spacing(8)),
          _SearchActionButton(
            size: actionSize,
            fill: theme.searchFill,
            border: theme.searchBorder,
            onTap: onFilterTap,
            child: Icon(
              Icons.tune_rounded,
              size: 22,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _SearchActionButton extends StatelessWidget {
  const _SearchActionButton({
    required this.size,
    required this.fill,
    required this.border,
    required this.child,
    this.onTap,
  });

  final double size;
  final Color fill;
  final Color border;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fill,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
