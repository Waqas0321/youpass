import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/events/presentation/event_detail_design_spec.dart';

class EventDetailAboutSectionWidget extends StatefulWidget {
  const EventDetailAboutSectionWidget({
    super.key,
    required this.description,
  });

  final String description;

  @override
  State<EventDetailAboutSectionWidget> createState() =>
      _EventDetailAboutSectionWidgetState();
}

class _EventDetailAboutSectionWidgetState
    extends State<EventDetailAboutSectionWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = EventDetailTheme.of(context);
    final bodyStyle = TextStyle(
      fontSize: EventDetailDesignSpec.px(context, 15),
      color: theme.textSecondary,
      height: 1.55,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.eventDetailAboutHeading(strings),
          style: TextStyle(
            fontSize: EventDetailDesignSpec.px(context, 13),
            fontWeight: FontWeight.w800,
            color: theme.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: EventDetailDesignSpec.px(context, 10)),
        LayoutBuilder(
          builder: (context, constraints) {
            final textPainter = TextPainter(
              text: TextSpan(text: widget.description, style: bodyStyle),
              maxLines: 3,
              textDirection: Directionality.of(context),
            )..layout(maxWidth: constraints.maxWidth);

            final exceedsMaxLines = textPainter.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: bodyStyle,
                  maxLines: expanded ? null : 3,
                  overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
                if (exceedsMaxLines) ...[
                  SizedBox(height: EventDetailDesignSpec.px(context, 6)),
                  GestureDetector(
                    onTap: () => setState(() => expanded = !expanded),
                    child: Text(
                      expanded
                          ? AppStrings.eventDetailReadLess(strings)
                          : AppStrings.eventDetailReadMore(strings),
                      style: TextStyle(
                        fontSize: EventDetailDesignSpec.px(context, 14),
                        fontWeight: FontWeight.w700,
                        color: theme.gold,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
