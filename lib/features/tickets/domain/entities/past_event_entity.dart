import 'package:equatable/equatable.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_display_status.dart';

class PastEventEntity extends Equatable {
  const PastEventEntity({
    required this.id,
    required this.title,
    required this.locationLabel,
    required this.dateLabel,
    required this.imageAssetPath,
    required this.category,
    this.eventId,
    this.displayStatus = TicketDisplayStatus.expired,
    this.isFavorite = false,
    this.showStatistics = false,
    this.entryTime,
    this.consumptionCount,
    this.stayDurationLabel,
  });

  final String id;
  final String? eventId;
  final String title;
  final String locationLabel;
  final String dateLabel;
  final String imageAssetPath;
  final PastEventFilter category;
  final TicketDisplayStatus displayStatus;
  final bool isFavorite;
  final bool showStatistics;
  final String? entryTime;
  final int? consumptionCount;
  final String? stayDurationLabel;

  bool get usesNetworkImage {
    final value = imageAssetPath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  PastEventEntity copyWith({
    bool? isFavorite,
  }) {
    return PastEventEntity(
      id: id,
      eventId: eventId,
      title: title,
      locationLabel: locationLabel,
      dateLabel: dateLabel,
      imageAssetPath: imageAssetPath,
      category: category,
      isFavorite: isFavorite ?? this.isFavorite,
      showStatistics: showStatistics,
      entryTime: entryTime,
      consumptionCount: consumptionCount,
      stayDurationLabel: stayDurationLabel,
    );
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        title,
        locationLabel,
        dateLabel,
        imageAssetPath,
        category,
        displayStatus,
        isFavorite,
        showStatistics,
        entryTime,
        consumptionCount,
        stayDurationLabel,
      ];
}
