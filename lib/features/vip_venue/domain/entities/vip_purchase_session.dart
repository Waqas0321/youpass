import 'package:youpass/core/locale/country_format_helper.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';

class VipPurchaseSession {
  VipPurchaseSession({
    required this.event,
    List<TicketOfferingEntity>? offerings,
    this.selectedZone,
    this.selectedTable,
    this.serviceFeeRate = 0.05,
    this.hasVenueLayout = false,
    this.hasTicketOfferings = true,
    this.tableLockExpiresAt,
  }) : offerings = List.of(offerings ?? const []);

  final EventEntity event;
  List<TicketOfferingEntity> offerings;
  VenueZoneEntity? selectedZone;
  VenueTableEntity? selectedTable;
  double serviceFeeRate;
  bool hasVenueLayout;
  bool hasTicketOfferings;
  DateTime? tableLockExpiresAt;

  int get selectedTicketCount =>
      offerings.fold(0, (sum, offering) => sum + offering.quantity);

  bool get hasSelectedTickets => selectedTicketCount > 0;

  List<TicketOfferingEntity> get selectedOfferings =>
      offerings.where((offering) => offering.quantity > 0).toList();

  int get generalTicketsTotal => offerings.fold(
        0,
        (sum, offering) => sum + offering.lineTotal,
      );

  int get tableSubtotal => selectedTable?.price ?? 0;

  int get subtotal => isVipTablePurchase ? tableSubtotal : generalTicketsTotal;

  int get serviceFee => (subtotal * serviceFeeRate).round();

  int get totalAmount => subtotal + serviceFee;

  bool get isVipTablePurchase => selectedTable != null;

  bool get isGeneralTicketPurchase => !isVipTablePurchase && hasSelectedTickets;

  String get countryIsoCode => event.countryCode ?? 'CL';

  String get currency {
    for (final offering in offerings) {
      if (offering.currency.isNotEmpty) {
        return offering.currency;
      }
    }

    return CountryFormatHelper.countryFor(
      countryIsoCode: countryIsoCode,
    ).defaultCurrency;
  }

  String? get seatLabel {
    final table = selectedTable;
    final zone = selectedZone;
    if (table != null && zone != null) {
      return '${table.label} - ${zone.name}';
    }
    return null;
  }
}
