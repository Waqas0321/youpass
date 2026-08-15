class StaffSupervisorEntryHistoryRouteArgs {
  const StaffSupervisorEntryHistoryRouteArgs({
    required this.ticketId,
    required this.guestName,
    required this.eventTitle,
    required this.qrId,
  });

  final String ticketId;
  final String guestName;
  final String eventTitle;
  final String qrId;
}
