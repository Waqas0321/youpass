import 'package:youpass/core/network/models/api_list_meta_model.dart';
import 'package:youpass/features/tickets/data/models/past_ticket_model.dart';

class PastTicketsListResponseModel {
  const PastTicketsListResponseModel({
    required this.tickets,
    this.total = 0,
  });

  final List<PastTicketModel> tickets;
  final int total;

  factory PastTicketsListResponseModel.fromJson(Map<String, dynamic> json) {
    final items = json['tickets'];
    final meta = ApiListMetaModel.fromJson(json['meta']);

    return PastTicketsListResponseModel(
      tickets: items is List
          ? items
              .whereType<Map<String, dynamic>>()
              .map(PastTicketModel.fromJson)
              .toList()
          : const [],
      total: meta.total,
    );
  }
}
