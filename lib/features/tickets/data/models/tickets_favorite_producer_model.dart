class TicketsFavoriteProducerModel {
  const TicketsFavoriteProducerModel({
    this.name,
    this.eventsAttended,
  });

  final String? name;
  final int? eventsAttended;

  factory TicketsFavoriteProducerModel.fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return const TicketsFavoriteProducerModel();
    }

    final count = json['events_attended'] ?? json['eventsAttended'];
    int? eventsAttended;
    if (count is num) {
      eventsAttended = count.toInt();
    } else {
      eventsAttended = int.tryParse(count?.toString() ?? '');
    }

    return TicketsFavoriteProducerModel(
      name: json['name']?.toString(),
      eventsAttended: eventsAttended,
    );
  }
}
