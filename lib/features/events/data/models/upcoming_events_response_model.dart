import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/data/models/event_model.dart';

class UpcomingEventsResponseModel {
  const UpcomingEventsResponseModel({
    required this.events,
    this.hasMore = false,
    this.page = 1,
    this.total = 0,
  });

  final List<EventModel> events;
  final bool hasMore;
  final int page;
  final int total;

  factory UpcomingEventsResponseModel.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'];
    var hasMore = false;
    var page = 1;
    var total = 0;

    if (pagination is Map<String, dynamic>) {
      hasMore = JsonReaders.boolean(pagination, 'has_more', fallback: false) ||
          JsonReaders.boolean(pagination, 'hasMore', fallback: false);
      page = JsonReaders.integer(pagination, 'page', fallback: 1);
      total = JsonReaders.integer(pagination, 'total');
    }

    final items = json['items'] ?? json['events'];

    return UpcomingEventsResponseModel(
      events: EventModel.listFromJson(items),
      hasMore: hasMore,
      page: page,
      total: total,
    );
  }
}
