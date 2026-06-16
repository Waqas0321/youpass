class AssignTicketsRouteArgs {
  const AssignTicketsRouteArgs({
    required this.ticketId,
    this.orderId,
    this.eventTitle,
    this.isVip = false,
  });

  final String ticketId;
  final String? orderId;
  final String? eventTitle;
  final bool isVip;
}
