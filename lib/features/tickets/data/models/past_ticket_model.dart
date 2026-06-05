import 'package:youpass/features/tickets/data/models/past_ticket_event_type_model.dart';
import 'package:youpass/features/tickets/data/models/past_ticket_statistics_model.dart';
import 'package:youpass/features/tickets/data/utils/ticket_model_json_reader.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';

class PastTicketModel extends PastEventEntity {
  const PastTicketModel({
    required super.id,
    required super.title,
    required super.locationLabel,
    required super.dateLabel,
    required super.imageAssetPath,
    required super.category,
    super.eventId,
    super.isFavorite = false,
    super.showStatistics = false,
    super.entryTime,
    super.consumptionCount,
    super.stayDurationLabel,
  });

  factory PastTicketModel.fromJson(Map<String, dynamic> json) {
    final status = json['status']?.toString().toLowerCase();
    final statistics = PastTicketStatisticsModel.fromJson(json['statistics']);
    final eventType = PastTicketEventTypeModel.fromJson(
      json['event_type'] ?? json['eventType'],
    );

    final hasStatistics =
        status == 'validated' && statistics.hasEntryTime;

    return PastTicketModel(
      id: json['id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? json['eventId']?.toString(),
      title: TicketModelJsonReader.readString(
        json,
        'event_title',
        'eventTitle',
        'title',
      ),
      locationLabel: TicketModelJsonReader.readString(
        json,
        'location',
        'location_label',
        'venue',
      ),
      dateLabel: TicketModelJsonReader.readString(
        json,
        'date_time_label',
        'dateTimeLabel',
        'dateLabel',
      ),
      imageAssetPath: TicketModelJsonReader.readString(
        json,
        'image_url',
        'imageUrl',
        'image_asset_path',
      ),
      category: eventType.toPastEventFilter(),
      isFavorite: TicketModelJsonReader.readBool(
        json['is_favorite'] ?? json['isFavorite'],
      ),
      showStatistics: hasStatistics,
      entryTime: statistics.entryTime,
      consumptionCount: statistics.consumptionCount,
      stayDurationLabel: statistics.stayLabel,
    );
  }
}
