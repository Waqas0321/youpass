import 'package:equatable/equatable.dart';

class HomeSearchFiltersConfigEntity extends Equatable {
  const HomeSearchFiltersConfigEntity({
    required this.datePresets,
    required this.venueTypes,
    required this.cities,
    required this.priceRange,
    this.debounceMs = 300,
    this.emptyMessage = "We couldn't find any events with that term.",
    this.historyLimit = 10,
    this.filtersEnabled = true,
    this.searchEndpoint = '/events',
    this.searchParam = 'q',
  });

  final List<HomeFilterOptionEntity> datePresets;
  final List<HomeFilterOptionEntity> venueTypes;
  final List<HomeCityFilterEntity> cities;
  final HomePriceRangeEntity priceRange;
  final int debounceMs;
  final String emptyMessage;
  final int historyLimit;
  final bool filtersEnabled;
  final String searchEndpoint;
  final String searchParam;

  static const HomeSearchFiltersConfigEntity defaults = HomeSearchFiltersConfigEntity(
    datePresets: [],
    venueTypes: [],
    cities: [],
    priceRange: HomePriceRangeEntity(min: 0, max: 500000, currency: 'CLP'),
  );

  @override
  List<Object?> get props => [
        datePresets,
        venueTypes,
        cities,
        priceRange,
        debounceMs,
        emptyMessage,
        historyLimit,
        filtersEnabled,
        searchEndpoint,
        searchParam,
      ];
}

class HomeFilterOptionEntity extends Equatable {
  const HomeFilterOptionEntity({required this.id, required this.label});

  final String id;
  final String label;

  @override
  List<Object?> get props => [id, label];
}

class HomeCityFilterEntity extends Equatable {
  const HomeCityFilterEntity({
    required this.id,
    required this.label,
    this.zones = const [],
  });

  final String id;
  final String label;
  final List<String> zones;

  @override
  List<Object?> get props => [id, label, zones];
}

class HomePriceRangeEntity extends Equatable {
  const HomePriceRangeEntity({
    required this.min,
    required this.max,
    required this.currency,
    this.freeToggleEnabled = true,
  });

  final double min;
  final double max;
  final String currency;
  final bool freeToggleEnabled;

  @override
  List<Object?> get props => [min, max, currency, freeToggleEnabled];
}

class HomeEventsFiltersEntity extends Equatable {
  const HomeEventsFiltersEntity({
    this.datePreset,
    this.dateFrom,
    this.dateTo,
    this.city,
    this.zone,
    this.venueKind,
    this.minPrice,
    this.maxPrice,
    this.freeOnly = false,
  });

  final String? datePreset;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? city;
  final String? zone;
  final String? venueKind;
  final double? minPrice;
  final double? maxPrice;
  final bool freeOnly;

  static const HomeEventsFiltersEntity empty = HomeEventsFiltersEntity();

  bool get hasActiveFilters =>
      (datePreset != null && datePreset!.isNotEmpty) ||
      dateFrom != null ||
      dateTo != null ||
      (city != null && city!.isNotEmpty) ||
      (zone != null && zone!.isNotEmpty) ||
      (venueKind != null && venueKind!.isNotEmpty) ||
      freeOnly ||
      minPrice != null ||
      maxPrice != null;

  HomeEventsFiltersEntity copyWith({
    String? datePreset,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? city,
    String? zone,
    String? venueKind,
    double? minPrice,
    double? maxPrice,
    bool? freeOnly,
    bool clearDatePreset = false,
    bool clearDateFrom = false,
    bool clearDateTo = false,
    bool clearCity = false,
    bool clearZone = false,
    bool clearVenueKind = false,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
  }) {
    return HomeEventsFiltersEntity(
      datePreset: clearDatePreset ? null : (datePreset ?? this.datePreset),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      city: clearCity ? null : (city ?? this.city),
      zone: clearZone ? null : (zone ?? this.zone),
      venueKind: clearVenueKind ? null : (venueKind ?? this.venueKind),
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
      freeOnly: freeOnly ?? this.freeOnly,
    );
  }

  HomeEventsFiltersEntity cleared() => HomeEventsFiltersEntity.empty;

  @override
  List<Object?> get props => [
        datePreset,
        dateFrom,
        dateTo,
        city,
        zone,
        venueKind,
        minPrice,
        maxPrice,
        freeOnly,
      ];
}
