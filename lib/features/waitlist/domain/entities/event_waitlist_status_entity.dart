class EventWaitlistStatusEntity {
  const EventWaitlistStatusEntity({
    required this.enabled,
    required this.joinable,
    required this.canJoin,
    required this.canLeave,
    required this.offerHours,
    this.status,
    this.position,
    this.offerId,
    this.offerExpiresAt,
    this.expiresInLabel,
  });

  final bool enabled;
  final bool joinable;
  final bool canJoin;
  final bool canLeave;
  final int offerHours;
  final String? status;
  final int? position;
  final String? offerId;
  final String? offerExpiresAt;
  final String? expiresInLabel;

  factory EventWaitlistStatusEntity.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const EventWaitlistStatusEntity(
        enabled: false,
        joinable: false,
        canJoin: false,
        canLeave: false,
        offerHours: 4,
      );
    }

    return EventWaitlistStatusEntity(
      enabled: json['enabled'] == true,
      joinable: json['joinable'] == true,
      canJoin: json['can_join'] == true,
      canLeave: json['can_leave'] == true,
      offerHours: json['offer_hours'] is num ? (json['offer_hours'] as num).toInt() : 4,
      status: json['status']?.toString(),
      position: json['position'] is num ? (json['position'] as num).toInt() : null,
      offerId: json['offer_id']?.toString(),
      offerExpiresAt: json['offer_expires_at']?.toString(),
      expiresInLabel: json['expires_in_label']?.toString(),
    );
  }
}
