class PastTicketStatisticsModel {
  const PastTicketStatisticsModel({
    this.entryTime,
    this.consumptionCount,
    this.stayLabel,
  });

  final String? entryTime;
  final int? consumptionCount;
  final String? stayLabel;

  bool get hasEntryTime => entryTime != null && entryTime!.isNotEmpty;

  factory PastTicketStatisticsModel.fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return const PastTicketStatisticsModel();
    }

    final entryTime = json['entry_time']?.toString() ??
        json['entryTime']?.toString();
    final consumptionRaw =
        json['consumption_count'] ?? json['consumptionCount'];
    final consumptionCount = consumptionRaw is num
        ? consumptionRaw.toInt()
        : int.tryParse(consumptionRaw?.toString() ?? '');
    final stayLabel = json['stay_label']?.toString() ??
        json['stayLabel']?.toString();

    return PastTicketStatisticsModel(
      entryTime: entryTime,
      consumptionCount: consumptionCount,
      stayLabel: stayLabel != null && stayLabel.isNotEmpty ? stayLabel : null,
    );
  }
}
