import 'package:flutter/material.dart';
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
    this.filtersEnabled = true,
  });

  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<bool> onFocusChanged;
  final VoidCallback onFilterTap;
  final bool filtersEnabled;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;

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
        if (filtersEnabled) ...[
          SizedBox(width: layout.spacing(10)),
          Material(
            color: theme.searchFill,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.searchBorder),
            ),
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: layout.spacing(48),
                height: layout.spacing(48),
                child: Icon(
                  Icons.tune_rounded,
                  size: 22,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
