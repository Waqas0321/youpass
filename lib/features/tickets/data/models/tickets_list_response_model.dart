import 'package:youpass/core/network/models/api_list_meta_model.dart';
import 'package:youpass/features/tickets/data/models/upcoming_ticket_model.dart';

class UpcomingTicketsResponseModel {
  const UpcomingTicketsResponseModel({
    required this.tickets,
    this.total = 0,
  });

  final List<UpcomingTicketModel> tickets;
  final int total;

  factory UpcomingTicketsResponseModel.fromJson(Map<String, dynamic> json) {
    final items = json['tickets'];
    final meta = ApiListMetaModel.fromJson(json['meta']);

    return UpcomingTicketsResponseModel(
      tickets: items is List
          ? items
              .whereType<Map<String, dynamic>>()
              .map(UpcomingTicketModel.fromJson)
              .toList()
          : const [],
      total: meta.total,
    );
  }
}
