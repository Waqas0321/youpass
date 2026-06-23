import 'package:equatable/equatable.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_display_status.dart';

class PastEventEntity extends Equatable {
  const PastEventEntity({
    required this.id,
    required this.title,
    required this.locationLabel,
    required this.dateLabel,
    required this.imageAssetPath,
    this.eventId,
    this.eventTypeSlug,
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
  final String? eventTypeSlug;
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
      eventTypeSlug: eventTypeSlug,
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
        eventTypeSlug,
        displayStatus,
        isFavorite,
        showStatistics,
        entryTime,
        consumptionCount,
        stayDurationLabel,
      ];
}
