import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class EventMetaRowWidget extends StatelessWidget {
  const EventMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.labelColor,
    this.fontWeight,
    this.maxLines = 2,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? labelColor;
  final FontWeight? fontWeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final resolvedIconColor =
        iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant;
    final resolvedLabelColor =
        labelColor ?? Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: layout.fontSize(13),
          color: resolvedIconColor,
        ),
        SizedBox(width: layout.spacing(5)),
        Expanded(
          child: AppText(
            label,
            variant: AppTextVariant.body,
            color: resolvedLabelColor,
            fontSize: layout.fontSize(11),
            fontWeight: fontWeight ?? FontWeight.w400,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
