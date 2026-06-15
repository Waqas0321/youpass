import 'package:youpass/core/network/models/api_list_meta_model.dart';
import 'package:youpass/features/tickets/data/models/past_ticket_model.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';

class PastTicketsListResponseModel {
  const PastTicketsListResponseModel({
    required this.tickets,
    this.meta = const ApiListMetaModel(),
  });

  final List<PastTicketModel> tickets;
  final ApiListMetaModel meta;

  TicketsPageResult<PastEventEntity> toPageResult() {
    return TicketsPageResult(
      items: tickets,
      total: meta.total,
      page: meta.page,
      limit: meta.limit,
      totalPages: meta.totalPages,
    );
  }

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
      meta: meta,
    );
  }
}
