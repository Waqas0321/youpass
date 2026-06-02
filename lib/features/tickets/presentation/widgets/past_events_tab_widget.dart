import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/past_event_card_widget.dart';

class PastEventsTabWidget extends StatefulWidget {
  const PastEventsTabWidget({
    super.key,
    required this.events,
  });

  final List<PastEventEntity> events;

  @override
  State<PastEventsTabWidget> createState() => _PastEventsTabWidgetState();
}

class _PastEventsTabWidgetState extends State<PastEventsTabWidget> {
  PastEventFilter selectedFilter = PastEventFilter.all;
  String searchQuery = '';
  late List<PastEventEntity> allEvents;
  late List<PastEventEntity> visibleEvents;

  @override
  void initState() {
    super.initState();
    allEvents = List<PastEventEntity>.from(widget.events);
    applyFilters();
  }

  void applyFilters() {
    final query = searchQuery.trim().toLowerCase();
    visibleEvents = allEvents.where((event) {
      final matchesFilter = selectedFilter == PastEventFilter.all ||
          event.category == selectedFilter;
      final matchesSearch = query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.locationLabel.toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      applyFilters();
    });
  }

  void updateFilter(PastEventFilter filter) {
    setState(() {
      selectedFilter = filter;
      applyFilters();
    });
  }

  void toggleFavorite(String eventId) {
    setState(() {
      allEvents = allEvents
          .map(
            (event) => event.id == eventId
                ? PastEventEntity(
                    id: event.id,
                    title: event.title,
                    locationLabel: event.locationLabel,
                    dateLabel: event.dateLabel,
                    imageAssetPath: event.imageAssetPath,
                    entryTime: event.entryTime,
                    consumptionCount: event.consumptionCount,
                    stayDurationLabel: event.stayDurationLabel,
                    category: event.category,
                    isFavorite: !event.isFavorite,
                  )
                : event,
          )
          .toList();
      applyFilters();
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
        const _AttendedSectionHeader(),
        SizedBox(height: TicketsDesignSpec.px(context, 14)),
        _SearchField(onChanged: updateSearch),
        SizedBox(height: TicketsDesignSpec.px(context, 14)),
        Text(
          AppStrings.ticketsFiltersLabel(strings),
          style: TextStyle(
            fontSize: TicketsDesignSpec.px(context, 11),
            fontWeight: FontWeight.w600,
            color: TicketsDesignSpec.bodyText,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 8)),
        _FilterChipsRow(
          selectedFilter: selectedFilter,
          onFilterSelected: updateFilter,
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 16)),
        ...visibleEvents.map(
          (event) => PastEventCardWidget(
            event: event,
            onFavoriteToggle: () => toggleFavorite(event.id),
          ),
        ),
        SizedBox(height: TicketsDesignSpec.px(context, 8)),
        const _FavoritesTip(),
      ],
    );
  }
}

class _AttendedSectionHeader extends StatelessWidget {
  const _AttendedSectionHeader();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: TicketsDesignSpec.px(context, 36),
          height: TicketsDesignSpec.px(context, 36),
          decoration: const BoxDecoration(
            color: TicketsDesignSpec.sectionIconBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.confirmation_number_outlined,
            size: TicketsDesignSpec.px(context, 18),
            color: TicketsDesignSpec.primary,
          ),
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.ticketsAttendedSectionTitle(strings),
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 14),
                  fontWeight: FontWeight.w700,
                  color: TicketsDesignSpec.titleText,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: TicketsDesignSpec.px(context, 4)),
              Text(
                AppStrings.ticketsAttendedSectionSubtitle(strings),
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 12),
                  color: TicketsDesignSpec.bodyText,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, 12);

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: AppStrings.ticketsSearchHint(strings),
        hintStyle: TextStyle(
          fontSize: TicketsDesignSpec.px(context, 13),
          color: TicketsDesignSpec.bodyText,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: TicketsDesignSpec.px(context, 20),
          color: TicketsDesignSpec.metaIcon,
        ),
        filled: true,
        fillColor: TicketsDesignSpec.searchFill,
        contentPadding: EdgeInsets.symmetric(
          vertical: TicketsDesignSpec.px(context, 12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: TicketsDesignSpec.searchBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: TicketsDesignSpec.searchBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: TicketsDesignSpec.primary),
        ),
      ),
    );
  }
}

class _FilterChipsRow extends StatelessWidget {
  const _FilterChipsRow({
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
          _FilterChip(
            label: AppStrings.ticketsFilterAll(strings),
            isSelected: selectedFilter == PastEventFilter.all,
            onTap: () => onFilterSelected(PastEventFilter.all),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 8)),
          _FilterChip(
            label: AppStrings.ticketsFilterParties(strings),
            isSelected: selectedFilter == PastEventFilter.parties,
            onTap: () => onFilterSelected(PastEventFilter.parties),
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 8)),
          _FilterChip(
            label: AppStrings.ticketsFilterConcerts(strings),
            isSelected: selectedFilter == PastEventFilter.concerts,
            onTap: () => onFilterSelected(PastEventFilter.concerts),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          TicketsDesignSpec.px(context, 20),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: TicketsDesignSpec.px(context, 16),
            vertical: TicketsDesignSpec.px(context, 8),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              TicketsDesignSpec.px(context, 20),
            ),
            border: Border.all(
              color: isSelected
                  ? TicketsDesignSpec.primary
                  : TicketsDesignSpec.chipBorder,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 13),
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? TicketsDesignSpec.primary
                  : TicketsDesignSpec.chipText,
            ),
          ),
        ),
      ),
    );
  }
}

class _FavoritesTip extends StatelessWidget {
  const _FavoritesTip();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.favorite,
          size: TicketsDesignSpec.px(context, 16),
          color: TicketsDesignSpec.favoriteActive,
        ),
        SizedBox(width: TicketsDesignSpec.px(context, 8)),
        Expanded(
          child: Text(
            AppStrings.ticketsFavoritesTip(strings),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 12),
              color: TicketsDesignSpec.bodyText,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
