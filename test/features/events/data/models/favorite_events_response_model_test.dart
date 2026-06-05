import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/events/data/models/favorite_events_response_model.dart';

void main() {
  test('fromRawData parses events array directly', () {
    final response = FavoriteEventsResponseModel.fromRawData([
      {
        'id': 'event-1',
        'title': 'Summer Festival',
        'starts_at_display': '15 Jul 2026',
        'date_time_display': '15 Jul 2026',
        'location_display': 'Santiago, Chile',
        'is_favorite': true,
      },
    ]);

    expect(response.events, hasLength(1));
    expect(response.events.first.id, 'event-1');
    expect(response.events.first.title, 'Summer Festival');
  });

  test('fromRawData parses wrapped events payload', () {
    final response = FavoriteEventsResponseModel.fromRawData({
      'events': [
        {
          'id': 'event-2',
          'title': 'Neon Party',
          'starts_at_display': '7 Aug 2026',
          'date_time_display': '7 Aug 2026',
          'location_display': 'Sky Costanera',
          'is_favorite': true,
        },
      ],
    });

    expect(response.events, hasLength(1));
    expect(response.events.first.id, 'event-2');
    expect(response.events.first.title, 'Neon Party');
  });
}
