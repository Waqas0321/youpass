import 'package:equatable/equatable.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_category.dart';

class ProducerEventEntity extends Equatable {
  const ProducerEventEntity({
    required this.id,
    required this.producerId,
    required this.title,
    required this.dateLabel,
    required this.timeLabel,
    required this.locationLabel,
    required this.priceLabel,
    required this.imageAssetPath,
    required this.category,
  });

  final String id;
  final String producerId;
  final String title;
  final String dateLabel;
  final String timeLabel;
  final String locationLabel;
  final String priceLabel;
  final String imageAssetPath;
  final ProducerEventCategory category;

  @override
  List<Object?> get props => [
        id,
        producerId,
        title,
        dateLabel,
        timeLabel,
        locationLabel,
        priceLabel,
        imageAssetPath,
        category,
      ];
}
