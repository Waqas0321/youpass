import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_labeled_field_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/gender_picker_sheet.dart';

class GenderCheckboxGroupWidget extends StatelessWidget {
  const GenderCheckboxGroupWidget({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  final String? selectedValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final options = GenderPickerSheet.resolveOptions(context);

    return AuthLabeledFieldWidget(
      label: context.l10n.genderLabel,
      child: RadioGroup<String>(
        groupValue: selectedValue,
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final gap = layout.spacing(12);
            final tileWidth = (constraints.maxWidth - gap) / 2;

            return Wrap(
              spacing: gap,
              runSpacing: layout.spacing(4),
              children: [
                for (final option in options)
                  SizedBox(
                    width: tileWidth,
                    child: _GenderOptionTile(
                      value: option.value,
                      label: option.label,
                      groupValue: selectedValue,
                      onChanged: onChanged,
                      layout: layout,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GenderOptionTile extends StatelessWidget {
  const _GenderOptionTile({
    required this.value,
    required this.label,
    required this.groupValue,
    required this.onChanged,
    required this.layout,
  });

  final String value;
  final String label;
  final String? groupValue;
  final ValueChanged<String> onChanged;
  final ResponsiveLayout layout;

  bool get isSelected => groupValue == value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(layout.radius(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: layout.spacing(4)),
        child: Row(
          children: [
            SizedBox(
              width: layout.spacing(22),
              height: layout.spacing(22),
              child: Radio<String>(
                value: value,
                activeColor: AppColors.primaryMustard,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            SizedBox(width: layout.spacing(6)),
            Expanded(
              child: AppText(
                label,
                variant: AppTextVariant.body,
                fontSize: layout.fontSize(13),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.darkNavy : AppColors.secondaryGrey,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
