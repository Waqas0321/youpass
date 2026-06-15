import 'package:youpass/core/network/models/api_list_meta_model.dart';
import 'package:youpass/features/tickets/data/models/upcoming_ticket_model.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';

class UpcomingTicketsResponseModel {
  const UpcomingTicketsResponseModel({
    required this.tickets,
    this.meta = const ApiListMetaModel(),
  });

  final List<UpcomingTicketModel> tickets;
  final ApiListMetaModel meta;

  TicketsPageResult<UpcomingTicketEntity> toPageResult() {
    return TicketsPageResult(
      items: tickets,
      total: meta.total,
      page: meta.page,
      limit: meta.limit,
      totalPages: meta.totalPages,
    );
  }

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
      meta: meta,
    );
  }
}
