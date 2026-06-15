import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/events/data/models/event_detail_model.dart';
import 'package:youpass/features/ticket_assignment/data/models/event_checkout_models.dart';
import 'package:youpass/features/vip_venue/data/models/physical_venue_model.dart';
import 'package:youpass/features/vip_venue/data/models/vip_venue_models.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_kind.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_status.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_checkout.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';

void main() {
  group('VIP venue models', () {
    test('parses early_bird offering with type and checkout id', () {
      final offering = TicketOfferingModel.fromJson({
        'id': 'early_bird',
        'offering_id': 'mongo-123',
        'type': 'early_bird',
        'name': 'Early Bird',
        'label': 'Early Bird',
        'section': 'general',
        'price': 10000,
        'currency': 'CLP',
        'status': 'active',
        'is_sold_out': false,
        'is_selectable': true,
      });

      expect(offering.id, 'early_bird');
      expect(offering.type, 'early_bird');
      expect(offering.name, 'Early Bird');
      expect(offering.checkoutOfferingId, 'mongo-123');
      expect(offering.isQuantitySelectable, isTrue);
    });

    test('marks sold out from status without stock fields', () {
      final offering = TicketOfferingModel.fromJson({
        'id': 'preventa_2',
        'offering_id': 'mongo-456',
        'type': 'preventa_2',
        'name': 'Pre-sale 2nd wave',
        'section': 'general',
        'price': 13000,
        'status': 'sold_out',
        'stock_total': 100,
        'stock_remaining': 0,
      });

      expect(offering.isSoldOut, isTrue);
      expect(offering.isSelectable, isFalse);
    });

    test('parses ticket offerings from flat and grouped payloads', () {
      final flat = TicketTypesBundleModel.fromJson({
        'event_id': 'evt-1',
        'service_fee_rate': 0.05,
        'offerings': [
          {
            'slug': 'preventa-1',
            'offering_id': 'off-1',
            'label': 'Preventa 1',
            'section': 'general',
            'price': 10000,
            'currency': 'CLP',
            'vouchers_per_ticket': 2,
          },
        ],
      });

      expect(flat.offerings.first.id, 'preventa-1');
      expect(flat.offerings.first.offeringId, 'off-1');
      expect(flat.offerings.first.vouchersPerTicket, 2);

      final grouped = TicketTypesBundleModel.fromJson({
        'event_id': 'evt-1',
        'offerings': {
          'general': [
            {'id': 'preventa-1', 'label': 'Preventa 1', 'price': 10000},
          ],
          'vip': [
            {'id': 'vip-general', 'label': 'VIP General', 'section': 'vip', 'price': 35000},
          ],
        },
      });

      expect(grouped.offerings.length, 2);
    });

    test('parses venue layout with physical venue metadata', () {
      final layout = VenueFloorPlanModel.fromJson({
        'venue_id': 'venue-1',
        'layout_venue_id': 'layout-1',
        'table_lock_minutes': 10,
        'event_id': 'evt-1',
        'name': 'BICENTENNIAL PARK - Main Hall',
        'physical_venue': {
          'id': 'venue-1',
          'name': 'Bicentennial Park',
          'city': 'Santiago',
          'country': 'CL',
          'dimensions': {'width_meters': 36, 'height_meters': 18},
        },
        'zones': [
          {
            'id': 'vip-1',
            'name': 'VIP 1',
            'type': 'vip_table_zone',
            'selectable': true,
          },
        ],
      });

      expect(layout.venueId, 'venue-1');
      expect(layout.layoutVenueId, 'layout-1');
      expect(layout.tableLockMinutes, 10);
      expect(layout.physicalVenue?.name, 'Bicentennial Park');
      expect(layout.dimensionsLabel, '36m × 18m');
    });

    test('parses zone tables with external id, metadata, and ignores db_status', () {
      final bundle = ZoneTablesBundleModel.fromJson({
        'zone_id': 'vip-1',
        'zone_name': 'VIP 1',
        'tables': [
          {
            'id': 'table-vip-1-m1',
            'table_id': 'mongo-table-1',
            'event_id': 'evt-1',
            'number': 1,
            'label': 'M1',
            'zone_id': 'vip-1',
            'status': 'locked',
            'db_status': 'available',
            'price': 320000.5,
            'currency': 'CLP',
            'capacity': 10,
            'includes': {'people': 8, 'bottles': 2, 'bar_vouchers': 20},
            'locked_until': '2026-06-08T12:40:00.000Z',
          },
        ],
      });

      final table = bundle.tables.first;
      expect(table.id, 'table-vip-1-m1');
      expect(table.internalTableId, 'mongo-table-1');
      expect(table.eventId, 'evt-1');
      expect(table.capacity, 10);
      expect(table.price, 320001);
      expect(table.status, VenueTableStatus.locked);
      expect(table.lockedUntil, isNotNull);
    });

    test('maps reserved status from API status field', () {
      final table = VenueTableModel.fromJson({
        'id': 'table-vip-1-m2',
        'label': 'M2',
        'zone_id': 'vip-1',
        'status': 'reserved',
        'price': 320000,
      });

      expect(table.status, VenueTableStatus.reserved);
      expect(table.isSelectable, isFalse);
    });

    test('parses zone tables with table_id fallback and currency', () {
      final bundle = ZoneTablesBundleModel.fromJson({
        'zone_id': 'vip-1',
        'zone_name': 'VIP 1',
        'tables': [
          {
            'table_id': 'table-vip-1-m1',
            'label': 'M1',
            'zone_id': 'vip-1',
            'status': 'available',
            'price': 320000,
            'currency': 'CLP',
            'includes': {'people': 10, 'bottles': 2, 'bar_vouchers': 20},
          },
        ],
      });

      expect(bundle.tables.first.id, 'table-vip-1-m1');
      expect(bundle.tables.first.currency, 'CLP');
      expect(bundle.tables.first.capacity, 10);
    });

    test('parses physical venue catalog item', () {
      final venue = PhysicalVenueModel.fromJson({
        'id': 'venue-1',
        'name': 'Club Amanda - Main Hall',
        'address': 'Av. Providencia 1234',
        'city': 'Santiago',
        'country': 'CL',
        'dimensions': {'width_meters': 40, 'height_meters': 30},
      });

      expect(venue.dimensionsLabel, '40m × 30m');
    });

    test('parses event detail physical venue and purchase meta', () {
      final detail = EventDetailModel.fromJson({
        'id': 'evt-1',
        'title': 'URBAN NIGHT LIVE',
        'venue_id': 'venue-1',
        'physical_venue': {
          'id': 'venue-1',
          'name': 'Bicentennial Park',
          'city': 'Santiago',
        },
        'purchase': {
          'service_fee_rate': 0.05,
          'currency': 'CLP',
          'has_ticket_offerings': true,
          'has_venue_layout': true,
        },
      });

      expect(detail.venueId, 'venue-1');
      expect(detail.physicalVenue?.name, 'Bicentennial Park');
      expect(detail.purchase?.currency, 'CLP');
      expect(detail.purchase?.hasVenueLayout, isTrue);
    });
  });

  group('VIP checkout payloads', () {
    test('includes lock_id for VIP table checkout', () {
      final session = VipPurchaseSession(
        event: const EventEntity(
          id: 'evt-1',
          title: 'Test',
          dateTimeLabel: 'Today',
          dateLabel: 'Today',
          locationLabel: 'Santiago',
        ),
        tableLockId: 'lock-123',
      );
      session.selectedZone = const VenueZoneModel(
        id: 'vip-1',
        kind: VenueZoneKind.vip1,
        name: 'VIP 1',
        status: VenueZoneStatus.available,
      );
      session.selectedTable = const VenueTableModel(
        id: 'table-vip-1-m1',
        label: 'M1',
        zoneId: 'vip-1',
        status: VenueTableStatus.available,
        price: 320000,
        capacity: 10,
        bottleCount: 2,
        voucherCount: 20,
      );

      final request = session.buildCheckoutRequest();
      final json = EventCheckoutRequestModel(
        tableId: request.tableId,
        zoneId: request.zoneId,
        tier: request.tier,
        type: request.type,
        lockId: request.lockId,
      ).toJson();

      expect(json['lock_id'], 'lock-123');
      expect(json['table_id'], 'table-vip-1-m1');
    });
  });
}
