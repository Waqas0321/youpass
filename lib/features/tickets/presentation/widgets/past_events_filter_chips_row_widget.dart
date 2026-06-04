import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_filter_chip_widget.dart';

class PastEventsFilterChipsRowWidget extends StatelessWidget {
  const PastEventsFilterChipsRowWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final PastEventFilter selectedFilter;
  final ValueChanged<PastEventFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          PastEventsFilterChipWidget(
            label: AppStrings.ticketsFilterAll(strings),
            isSelected: selectedFilter == PastEventFilter.all,
            onTap: () => onFilterSelected(PastEventFilter.all),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 8)),
          PastEventsFilterChipWidget(
            label: AppStrings.ticketsFilterParties(strings),
            isSelected: selectedFilter == PastEventFilter.parties,
            onTap: () => onFilterSelected(PastEventFilter.parties),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 8)),
          PastEventsFilterChipWidget(
            label: AppStrings.ticketsFilterConcerts(strings),
            isSelected: selectedFilter == PastEventFilter.concerts,
            onTap: () => onFilterSelected(PastEventFilter.concerts),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 8)),
          PastEventsFilterChipWidget(
            label: AppStrings.ticketsFilterBar(strings),
            isSelected: selectedFilter == PastEventFilter.bar,
            onTap: () => onFilterSelected(PastEventFilter.bar),
          ),
        ],
      ),
    );
  }
}
