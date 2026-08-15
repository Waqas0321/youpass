import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_form_utils.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_radio_tile.dart';

/// Two-column manual access reason picker nested inside the result card.
class StaffSupervisorManualAccessReasonPanel<T> extends StatelessWidget {
  const StaffSupervisorManualAccessReasonPanel({
    super.key,
    required this.title,
    required this.leftOptions,
    required this.rightOptions,
    required this.selectedValue,
    required this.optionLabel,
    required this.onOptionSelected,
    this.showOtherField = false,
    this.otherController,
    this.otherPlaceholder,
    this.onOtherChanged,
  });

  final String title;
  final List<T> leftOptions;
  final List<T> rightOptions;
  final T? selectedValue;
  final String Function(T option) optionLabel;
  final ValueChanged<T> onOptionSelected;
  final bool showOtherField;
  final TextEditingController? otherController;
  final String? otherPlaceholder;
  final VoidCallback? onOtherChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(layout.spacing(14)),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        border: Border.all(color: AppColors.homeDividerGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            title,
            variant: AppTextVariant.label,
            color: StaffSupervisorDesign.accent,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(12),
            letterSpacing: 0.9,
          ),
          SizedBox(height: layout.spacing(12)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: leftOptions
                      .map(
                        (option) => StaffSupervisorRadioTile(
                          label: optionLabel(option),
                          selected: selectedValue == option,
                          onTap: () => onOptionSelected(option),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(width: layout.spacing(8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...rightOptions.map(
                      (option) => StaffSupervisorRadioTile(
                        label: optionLabel(option),
                        selected: selectedValue == option,
                        onTap: () => onOptionSelected(option),
                      ),
                    ),
                    if (showOtherField &&
                        otherController != null &&
                        otherPlaceholder != null) ...[
                      SizedBox(height: layout.spacing(4)),
                      TextField(
                        controller: otherController,
                        onChanged: (_) => onOtherChanged?.call(),
                        style: TextStyle(
                          fontSize: layout.fontSize(14),
                          color: AppColors.homeBlack,
                        ),
                        decoration: staffSupervisorInputDecoration(
                          layout,
                          hint: otherPlaceholder!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
