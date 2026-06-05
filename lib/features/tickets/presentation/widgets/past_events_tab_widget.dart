import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/youpass_search_field_widget.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_event_card_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_attended_header_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_favorites_tip_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_events_filter_chips_row_widget.dart';

class PastEventsTabWidget extends StatefulWidget {
  const PastEventsTabWidget({
    super.key,
    required this.events,
    required this.headerSubtitle,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterSelected,
    required this.onFavoriteToggle,
  });

  final List<PastEventEntity> events;
  final String headerSubtitle;
  final PastEventFilter selectedFilter;
  final Future<void> Function(String search) onSearchChanged;
  final Future<void> Function(PastEventFilter filter) onFilterSelected;
  final Future<bool> Function(PastEventEntity event) onFavoriteToggle;

  @override
  State<PastEventsTabWidget> createState() => PastEventsTabWidgetState();
}

class PastEventsTabWidgetState extends State<PastEventsTabWidget> {
  Timer? searchDebounce;

  @override
  void dispose() {
    searchDebounce?.cancel();
    super.dispose();
  }

  void handleSearchChanged(String value) {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 400), () {
      widget.onSearchChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding);

    return ListView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        TicketsDesignSpec.px(context, 12),
        horizontalPadding,
        TicketsDesignSpec.px(context, 24),
      ),
      children: [
        PastEventsAttendedHeaderWidget(subtitle: widget.headerSubtitle),
        SizedBox(height: TicketsDesignSpec.px(context, 14)),
        YouPassSearchFieldWidget(
          hintText: AppStrings.ticketsSearchHint(strings),
          onChanged: handleSearchChanged,
          focusedBorderColor: TicketsScreenTheme.accent(context),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 14)),
        Text(
          AppStrings.ticketsFiltersLabel(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 11),
            fontWeight: FontWeight.w600,
            color: TicketsScreenTheme.body(context),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 8)),
        PastEventsFilterChipsRowWidget(
          selectedFilter: widget.selectedFilter,
          onFilterSelected: widget.onFilterSelected,
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 16)),
        if (widget.events.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: TicketsDesignSpec.px(context, 24),
            ),
            child: Text(
              AppStrings.ticketsEmptyPast(strings),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TicketsDesignSpec.px(context, 14),
                color: TicketsScreenTheme.body(context),
              ),
            ),
          )
        else
          ...widget.events.map(
            (event) => PastEventCardWidget(
              event: event,
              onFavoriteToggle: () => widget.onFavoriteToggle(event),
            ),
          ),
        SizedBox(height: TicketsDesignSpec.px(context, 8)),
        const PastEventsFavoritesTipWidget(),
      ],
    );
  }
}
