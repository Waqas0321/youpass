import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';

class WaitlistEntryModel extends WaitlistEntryEntity {
  const WaitlistEntryModel({
    required super.id,
    required super.eventId,
    required super.eventTitle,
    required super.locationLabel,
    required super.dateTimeLabel,
    required super.imageUrl,
    required super.status,
    required super.position,
    required super.badge,
    required super.statusLabel,
    super.offerId,
    super.expiresAt,
    super.expiresAtLabel,
    super.expiresInLabel,
    super.canLeave = false,
    super.canClaim = false,
    super.isUrgent = false,
  });

  factory WaitlistEntryModel.fromJson(Map<String, dynamic> json) {
    return WaitlistEntryModel(
      id: json['id']?.toString() ?? '',
      eventId: json['event_id']?.toString() ?? '',
      eventTitle: json['event_title']?.toString() ?? '',
      locationLabel: json['location']?.toString() ?? '',
      dateTimeLabel: json['date_time_label']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      status: json['status']?.toString() ?? 'waiting',
      position: json['position'] is num ? (json['position'] as num).toInt() : 0,
      badge: json['badge']?.toString() ?? 'WAITING LIST',
      statusLabel: json['status_label']?.toString() ?? '',
      offerId: json['offer_id']?.toString(),
      expiresAt: json['expires_at']?.toString(),
      expiresAtLabel: json['expires_at_label']?.toString(),
      expiresInLabel: json['expires_in_label']?.toString(),
      canLeave: json['can_leave'] == true,
      canClaim: json['can_claim'] == true,
      isUrgent: json['is_urgent'] == true,
    );
  }

  static List<WaitlistEntryModel> listFromPayload(dynamic payload) {
    if (payload is! List) {
      return const [];
    }
    return payload
        .whereType<Map<String, dynamic>>()
        .map(WaitlistEntryModel.fromJson)
        .toList();
  }
}
