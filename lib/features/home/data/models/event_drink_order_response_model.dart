import 'package:youpass/core/utils/json_readers.dart';

class EventDrinkOrderLineModel {
  const EventDrinkOrderLineModel({
    required this.productName,
    required this.quantity,
    this.lineId,
    this.productId,
    this.unitPriceClp = 0,
    this.lineTotalClp = 0,
    this.volumeMl,
    this.imageUrl,
    this.entryCode,
    this.qrPayload,
    this.qrStatus,
    this.redeemedAt,
  });

  final String? lineId;
  final String? productId;
  final String productName;
  final int quantity;
  final int unitPriceClp;
  final int lineTotalClp;
  final int? volumeMl;
  final String? imageUrl;
  final String? entryCode;
  final String? qrPayload;
  final String? qrStatus;
  final String? redeemedAt;

  bool get isRedeemed =>
      qrStatus == 'redeemed' || (redeemedAt?.isNotEmpty ?? false);

  bool get canViewQr => !isRedeemed && qrStatus != 'expired';

  factory EventDrinkOrderLineModel.fromJson(Map<String, dynamic> json) {
    return EventDrinkOrderLineModel(
      lineId: JsonReaders.nullableString(json, 'line_id') ??
          JsonReaders.nullableString(json, 'lineId'),
      productId: JsonReaders.nullableString(json, 'product_id') ??
          JsonReaders.nullableString(json, 'productId'),
      productName: JsonReaders.string(json, 'product_name',
          fallback: JsonReaders.string(json, 'productName')),
      quantity: JsonReaders.integer(json, 'quantity'),
      unitPriceClp: JsonReaders.integer(json, 'unit_price_clp',
          fallback: JsonReaders.integer(json, 'unitPriceClp')),
      lineTotalClp: JsonReaders.integer(json, 'line_total_clp',
          fallback: JsonReaders.integer(json, 'lineTotalClp')),
      volumeMl: json['volume_ml'] != null || json['volumeMl'] != null
          ? JsonReaders.integer(json, 'volume_ml',
              fallback: JsonReaders.integer(json, 'volumeMl'))
          : null,
      imageUrl: JsonReaders.nullableString(json, 'image_url') ??
          JsonReaders.nullableString(json, 'imageUrl'),
      entryCode: JsonReaders.nullableString(json, 'entry_code') ??
          JsonReaders.nullableString(json, 'entryCode'),
      qrPayload: JsonReaders.nullableString(json, 'qr_payload') ??
          JsonReaders.nullableString(json, 'qrPayload'),
      qrStatus: JsonReaders.nullableString(json, 'qr_status') ??
          JsonReaders.nullableString(json, 'qrStatus'),
      redeemedAt: JsonReaders.nullableString(json, 'redeemed_at') ??
          JsonReaders.nullableString(json, 'redeemedAt'),
    );
  }
}

class EventDrinkOrderModel {
  const EventDrinkOrderModel({
    required this.orderId,
    required this.eventId,
    required this.eventTitle,
    required this.subtotalClp,
    required this.serviceFeeClp,
    required this.totalClp,
    required this.itemCount,
    required this.status,
    required this.lineItems,
    this.displayOrderId,
    this.qrStatus,
    this.createdAt,
    this.redeemedAt,
  });

  final String orderId;
  final String eventId;
  final String eventTitle;
  final int subtotalClp;
  final int serviceFeeClp;
  final int totalClp;
  final int itemCount;
  final String status;
  final String? displayOrderId;
  final String? qrStatus;
  final String? createdAt;
  final String? redeemedAt;
  final List<EventDrinkOrderLineModel> lineItems;

  factory EventDrinkOrderModel.fromJson(Map<String, dynamic> json) {
    final linesRaw = json['line_items'] ?? json['lineItems'];

    return EventDrinkOrderModel(
      orderId: JsonReaders.string(json, 'order_id',
          fallback: JsonReaders.string(json, 'orderId')),
      eventId: JsonReaders.string(json, 'event_id',
          fallback: JsonReaders.string(json, 'eventId')),
      eventTitle: JsonReaders.string(json, 'event_title',
          fallback: JsonReaders.string(json, 'eventTitle')),
      subtotalClp: JsonReaders.integer(json, 'subtotal_clp',
          fallback: JsonReaders.integer(json, 'subtotalClp')),
      serviceFeeClp: JsonReaders.integer(json, 'service_fee_clp',
          fallback: JsonReaders.integer(json, 'serviceFeeClp')),
      totalClp: JsonReaders.integer(json, 'total_clp',
          fallback: JsonReaders.integer(json, 'totalClp')),
      itemCount: JsonReaders.integer(json, 'item_count',
          fallback: JsonReaders.integer(json, 'itemCount')),
      status: JsonReaders.string(json, 'status'),
      displayOrderId: JsonReaders.nullableString(json, 'display_order_id') ??
          JsonReaders.nullableString(json, 'displayOrderId'),
      qrStatus: JsonReaders.nullableString(json, 'qr_status') ??
          JsonReaders.nullableString(json, 'qrStatus'),
      createdAt: JsonReaders.nullableString(json, 'created_at') ??
          JsonReaders.nullableString(json, 'createdAt'),
      redeemedAt: JsonReaders.nullableString(json, 'redeemed_at') ??
          JsonReaders.nullableString(json, 'redeemedAt'),
      lineItems: linesRaw is List
          ? linesRaw
              .whereType<Map<String, dynamic>>()
              .map(EventDrinkOrderLineModel.fromJson)
              .toList()
          : const [],
    );
  }
}

class EventDrinkOrdersListModel {
  const EventDrinkOrdersListModel({required this.orders});

  final List<EventDrinkOrderModel> orders;

  factory EventDrinkOrdersListModel.fromJson(Map<String, dynamic> json) {
    final ordersRaw = json['orders'];

    return EventDrinkOrdersListModel(
      orders: ordersRaw is List
          ? ordersRaw
              .whereType<Map<String, dynamic>>()
              .map(EventDrinkOrderModel.fromJson)
              .toList()
          : const [],
    );
  }
}
