import 'package:equatable/equatable.dart';

class TicketsYearlySummaryEntity extends Equatable {
  const TicketsYearlySummaryEntity({
    required this.year,
    required this.eventsAttended,
    this.currentCategory,
    this.favoriteProducerName,
    this.favoriteProducerEventsAttended,
  });

  final int year;
  final int eventsAttended;
  final String? currentCategory;
  final String? favoriteProducerName;
  final int? favoriteProducerEventsAttended;

  @override
  List<Object?> get props => [
        year,
        eventsAttended,
        currentCategory,
        favoriteProducerName,
        favoriteProducerEventsAttended,
      ];
}
