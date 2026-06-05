import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';

class PastTicketEventTypeModel {
  const PastTicketEventTypeModel({this.slug, this.name});

  final String? slug;
  final String? name;

  factory PastTicketEventTypeModel.fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return PastTicketEventTypeModel(
        slug: json['slug']?.toString(),
        name: json['name']?.toString(),
      );
    }

    return PastTicketEventTypeModel(
      slug: json?.toString(),
      name: json?.toString(),
    );
  }

  PastEventFilter toPastEventFilter() {
    final normalized = (slug ?? name)?.toLowerCase();
    switch (normalized) {
      case 'parties':
      case 'party':
        return PastEventFilter.parties;
      case 'concerts':
      case 'concert':
        return PastEventFilter.concerts;
      case 'bar':
        return PastEventFilter.bar;
      default:
        return PastEventFilter.all;
    }
  }
}
