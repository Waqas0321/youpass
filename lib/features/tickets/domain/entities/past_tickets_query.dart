import 'package:equatable/equatable.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';

class PastTicketsQuery extends Equatable {
  const PastTicketsQuery({
    this.search,
    this.filter = PastEventFilter.all,
    this.page = 1,
    this.limit = 20,
  });

  final String? search;
  final PastEventFilter filter;
  final int page;
  final int limit;

  String? get eventType {
    switch (filter) {
      case PastEventFilter.all:
        return null;
      case PastEventFilter.parties:
        return 'parties';
      case PastEventFilter.concerts:
        return 'concerts';
      case PastEventFilter.bar:
        return 'bar';
    }
  }

  Map<String, String> toQueryParameters() {
    final params = <String, String>{
      'page': '$page',
      'limit': '$limit',
    };

    final trimmedSearch = search?.trim();
    if (trimmedSearch != null && trimmedSearch.isNotEmpty) {
      params['search'] = trimmedSearch;
    }

    final type = eventType;
    if (type != null) {
      params['event_type'] = type;
    }

    return params;
  }

  PastTicketsQuery copyWith({
    String? search,
    PastEventFilter? filter,
    int? page,
    int? limit,
  }) {
    return PastTicketsQuery(
      search: search ?? this.search,
      filter: filter ?? this.filter,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [search, filter, page, limit];
}
