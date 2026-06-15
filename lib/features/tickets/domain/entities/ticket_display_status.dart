enum TicketDisplayStatus {
  active,
  validated,
  expired,
  cancelled,
  refunded,
}

extension TicketDisplayStatusParsing on TicketDisplayStatus {
  static TicketDisplayStatus? fromApi(String? value) {
    switch (value?.toLowerCase()) {
      case 'active':
        return TicketDisplayStatus.active;
      case 'validated':
        return TicketDisplayStatus.validated;
      case 'expired':
        return TicketDisplayStatus.expired;
      case 'cancelled':
      case 'canceled':
        return TicketDisplayStatus.cancelled;
      case 'refunded':
        return TicketDisplayStatus.refunded;
      default:
        return null;
    }
  }
}
