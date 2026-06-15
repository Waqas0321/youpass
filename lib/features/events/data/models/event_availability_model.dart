import 'package:youpass/features/events/domain/entities/event_availability_entity.dart';

class EventAvailabilityModel extends EventAvailabilityEntity {
  const EventAvailabilityModel({
    required super.isSoldOut,
    required super.hasGeneralTickets,
    required super.hasVipTickets,
  });

  factory EventAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return EventAvailabilityModel(
      isSoldOut: _readBool(json, 'is_sold_out') || _readBool(json, 'isSoldOut'),
      hasGeneralTickets: _readBool(json, 'has_general_tickets') ||
          _readBool(json, 'hasGeneralTickets'),
      hasVipTickets:
          _readBool(json, 'has_vip_tickets') || _readBool(json, 'hasVipTickets'),
    );
  }

  static bool _readBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return false;
  }
}
