import 'package:equatable/equatable.dart';

class PastTicketsQuery extends Equatable {
  const PastTicketsQuery({
    this.search,
    this.eventTypeSlug,
    this.page = 1,
    this.limit = 20,
  });

  final String? search;
  final String? eventTypeSlug;
  final int page;
  final int limit;

  Map<String, String> toQueryParameters() {
    final params = <String, String>{
      'page': '$page',
      'limit': '$limit',
    };

    final trimmedSearch = search?.trim();
    if (trimmedSearch != null && trimmedSearch.isNotEmpty) {
      params['search'] = trimmedSearch;
    }

    final slug = eventTypeSlug?.trim();
    if (slug != null && slug.isNotEmpty) {
      params['event_type'] = slug;
    }

    return params;
  }

  PastTicketsQuery copyWith({
    String? search,
    String? eventTypeSlug,
    int? page,
    int? limit,
  }) {
    return PastTicketsQuery(
      search: search ?? this.search,
      eventTypeSlug: eventTypeSlug ?? this.eventTypeSlug,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [search, eventTypeSlug, page, limit];
}
