import 'package:youpass/core/constants/country_code_registry.dart';
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
    this.tableLockId,
    this.purchaseCurrency,
    this.currencyDecimals,
    this.tableLockMinutes = 10,
  }) : offerings = List.of(offerings ?? const []);

  final EventEntity event;
  List<TicketOfferingEntity> offerings;
  VenueZoneEntity? selectedZone;
  VenueTableEntity? selectedTable;
  double serviceFeeRate;
  bool hasVenueLayout;
  bool hasTicketOfferings;
  DateTime? tableLockExpiresAt;
  String? tableLockId;
  String? purchaseCurrency;
  int? currencyDecimals;
  int tableLockMinutes;

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

  String get countryIsoCode {
    final fromCurrency = _isoCodeForCurrency(_resolvedCurrencyCode);
    final fromEvent = event.countryCode?.trim();
    if (fromEvent != null && fromEvent.isNotEmpty) {
      final eventIso = fromEvent.toUpperCase();
      final resolvedCurrency = _resolvedCurrencyCode;
      if (fromCurrency != null &&
          resolvedCurrency != null &&
          CountryCodeRegistry.findByIsoCode(eventIso)
                  .defaultCurrency
                  .toUpperCase() !=
              resolvedCurrency) {
        return fromCurrency;
      }
      return eventIso;
    }

    if (fromCurrency != null) {
      return fromCurrency;
    }

    return CountryCodeRegistry.defaultCountryCode;
  }

  String get currency {
    final resolved = _resolvedCurrencyCode;
    if (resolved != null && resolved.isNotEmpty) {
      return resolved;
    }

    return CountryFormatHelper.countryFor(
      countryIsoCode: countryIsoCode,
    ).defaultCurrency;
  }

  String? get _resolvedCurrencyCode {
    final purchaseCurrencyCode = purchaseCurrency?.trim();
    if (purchaseCurrencyCode != null && purchaseCurrencyCode.isNotEmpty) {
      return purchaseCurrencyCode.toUpperCase();
    }

    for (final offering in offerings) {
      if (offering.currency.isNotEmpty) {
        return offering.currency.toUpperCase();
      }
    }

    return null;
  }

  String? _isoCodeForCurrency(String? currencyCode) {
    if (currencyCode == null || currencyCode.isEmpty) {
      return null;
    }
    return CountryCodeRegistry.findByCurrency(currencyCode)?.isoCode;
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
