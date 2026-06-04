import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';

class EventTypeModel extends EventTypeEntity {
  const EventTypeModel({
    required super.id,
    required super.slug,
    required super.name,
    super.iconEmoji,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(
      id: JsonReaders.readId(json),
      slug: JsonReaders.string(json, 'slug'),
      name: JsonReaders.string(json, 'name'),
      iconEmoji: JsonReaders.nullableString(json, 'icon'),
    );
  }

  static List<EventTypeModel> listFromJson(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map(EventTypeModel.fromJson)
        .toList();
  }
}
