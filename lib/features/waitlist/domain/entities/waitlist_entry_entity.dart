class WaitlistEntryEntity {
  const WaitlistEntryEntity({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.locationLabel,
    required this.dateTimeLabel,
    required this.imageUrl,
    required this.status,
    required this.position,
    required this.badge,
    required this.statusLabel,
    this.offerId,
    this.expiresAt,
    this.expiresAtLabel,
    this.expiresInLabel,
    this.canLeave = false,
    this.canClaim = false,
    this.isUrgent = false,
  });

  final String id;
  final String eventId;
  final String eventTitle;
  final String locationLabel;
  final String dateTimeLabel;
  final String imageUrl;
  final String status;
  final int position;
  final String badge;
  final String statusLabel;
  final String? offerId;
  final String? expiresAt;
  final String? expiresAtLabel;
  final String? expiresInLabel;
  final bool canLeave;
  final bool canClaim;
  final bool isUrgent;
}
