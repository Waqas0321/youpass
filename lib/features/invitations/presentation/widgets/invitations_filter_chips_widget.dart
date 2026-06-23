import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/core/widgets/youpass_filter_chip_widget.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/home/data/mappers/event_category_mapper.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsFilterChipsWidget extends StatelessWidget {
  const InvitationsFilterChipsWidget({
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.invitationsFiltersLabel(strings),
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 11),
            fontWeight: FontWeight.w700,
            color: InvitationsScreenTheme.body(context),
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 8)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < eventTypes.length; i++) ...[
                if (i > 0) SizedBox(width: InvitationsDesignSpec.px(context, 8)),
                YouPassFilterChipWidget(
                  label: EventCategoryMapper.labelForType(
                    strings,
                    eventTypes[i],
                  ),
                  isSelected: selectedEventTypeSlug == eventTypes[i].slug,
                  onTap: () => onFilterSelected(eventTypes[i].slug),
                  selectedColor: InvitationsScreenTheme.accent(context),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
