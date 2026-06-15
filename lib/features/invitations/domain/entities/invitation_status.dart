/// Section 14.7 invitation lifecycle statuses (stored in DB and returned by API).
enum InvitationStatus {
  sent,
  viewed,
  accepted,
  rejected,
  expired,
  canceled,
  validated,
  charged,
  failed,
  /// Legacy aliases kept for backward-compatible parsing.
  pending,
  confirmed,
}
