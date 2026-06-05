import 'package:youpass/features/tickets/data/models/tickets_favorite_producer_model.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/data/utils/ticket_model_json_reader.dart';

class TicketsYearlySummaryModel extends TicketsYearlySummaryEntity {
  const TicketsYearlySummaryModel({
    required super.year,
    required super.eventsAttended,
    super.currentCategory,
    super.favoriteProducerName,
    super.favoriteProducerEventsAttended,
  });

  factory TicketsYearlySummaryModel.fromJson(Map<String, dynamic> json) {
    final favoriteProducer = TicketsFavoriteProducerModel.fromJson(
      json['favorite_producer'] ?? json['favoriteProducer'],
    );

    return TicketsYearlySummaryModel(
      year: TicketModelJsonReader.readInt(json['year'],
          fallback: DateTime.now().year),
      eventsAttended: TicketModelJsonReader.readInt(
        json['events_attended'] ?? json['eventsAttended'],
      ),
      currentCategory: json['current_category']?.toString() ??
          json['currentCategory']?.toString(),
      favoriteProducerName: favoriteProducer.name,
      favoriteProducerEventsAttended: favoriteProducer.eventsAttended,
    );
  }
}
