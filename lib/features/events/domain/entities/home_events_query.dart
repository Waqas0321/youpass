import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class HomeEventsQuery {
  const HomeEventsQuery({
    this.countryCode,
    this.eventTypeSlug,
    this.page,
    this.limit,
  });

  final String? countryCode;
  final String? eventTypeSlug;
  final int? page;
  final int? limit;

  factory HomeEventsQuery.fromCategory(EventCategoryEntity category) {
    return HomeEventsQuery(
      countryCode: category.countryCode,
      eventTypeSlug: category.eventTypeSlug,
    );
  }

  Map<String, String> toQueryParameters() {
    final params = <String, String>{};
    if (countryCode != null && countryCode!.isNotEmpty) {
      params['country_code'] = countryCode!;
    }
    if (eventTypeSlug != null && eventTypeSlug!.isNotEmpty) {
      params['event_type'] = eventTypeSlug!;
    }
    if (page != null) {
      params['page'] = page.toString();
    }
    if (limit != null) {
      params['limit'] = limit.toString();
    }
    return params;
  }
}
