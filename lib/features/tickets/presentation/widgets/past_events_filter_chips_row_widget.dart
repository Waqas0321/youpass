import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/home/data/mappers/event_category_mapper.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_filter_chip_widget.dart';

class PastEventsFilterChipsRowWidget extends StatelessWidget {
  const PastEventsFilterChipsRowWidget({
    super.key,
    required this.eventTypes,
    required this.selectedEventTypeSlug,
    required this.onFilterSelected,
  });

  final List<EventTypeEntity> eventTypes;
  final String? selectedEventTypeSlug;
  final ValueChanged<String?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < eventTypes.length; i++) ...[
            if (i > 0) SizedBox(width: TicketsDesignSpec.px(context, 8)),
            PastEventsFilterChipWidget(
              label: EventCategoryMapper.labelForType(strings, eventTypes[i]),
              isSelected: selectedEventTypeSlug == eventTypes[i].slug,
              onTap: () => onFilterSelected(eventTypes[i].slug),
            ),
          ],
        ],
      ),
    );
  }
}
