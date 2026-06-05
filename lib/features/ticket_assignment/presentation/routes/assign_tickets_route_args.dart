class AssignTicketsRouteArgs {
  const AssignTicketsRouteArgs({
    required this.ticketId,
    this.orderId,
    this.eventTitle,
  });

  final String ticketId;
  final String? orderId;
  final String? eventTitle;
}
