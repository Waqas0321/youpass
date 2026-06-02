import 'package:equatable/equatable.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';

class PastEventEntity extends Equatable {
  const PastEventEntity({
    required this.id,
    required this.title,
    required this.locationLabel,
    required this.dateLabel,
    required this.imageAssetPath,
    required this.entryTime,
    required this.consumptionCount,
    required this.stayDurationLabel,
    required this.category,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String locationLabel;
  final String dateLabel;
  final String imageAssetPath;
  final String entryTime;
  final int consumptionCount;
  final String stayDurationLabel;
  final PastEventFilter category;
  final bool isFavorite;

  @override
  List<Object?> get props => [
        id,
        title,
        locationLabel,
        dateLabel,
        imageAssetPath,
        entryTime,
        consumptionCount,
        stayDurationLabel,
        category,
        isFavorite,
      ];
}
