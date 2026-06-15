# Flutter — VIP Venue & Ticket Purchase API

**Production base URL:** `https://youpass-backend.vercel.app/api/v1`

APIs for **VIP venue map**, **ticket offerings**, **table lock**, and **checkout** (general + VIP table).

**Related:** [FLUTTER_EVENTS_FAVORITES_API.md](./FLUTTER_EVENTS_FAVORITES_API.md) · [FLUTTER_API_DEPLOYED.md](./FLUTTER_API_DEPLOYED.md)

---

## What to update in Flutter

| Area | Action required? | Flutter status |
|------|------------------|----------------|
| VIP table lock / checkout flow | **No** — same endpoints | ✅ |
| Table `includes`, `position`, `price`, `label` | **No** — same shape | ✅ |
| Venue layout `venue_id` | **Yes** — catalog id vs layout doc | ✅ `venueId` + `layoutVenueId` |
| Event detail venue fields | **Optional** | ✅ `venueId`, `physicalVenue` |
| Table response extras | **Optional** | ✅ `eventId`, `capacity`, `lockedUntil`, `soldAt` |

**Layout id migration (implemented):**

```dart
final physicalVenueId = layout.venueId;    // catalog id, nullable
final layoutDocId = layout.layoutVenueId;  // floor plan document id
final venueMeta = layout.physicalVenue;    // optional
```

**Model checklist**

- [x] `VenueFloorPlanEntity`: `layoutVenueId`, `physicalVenue`; `venueId` = catalog id
- [x] `EventDetailEntity`: `venueId`, `physicalVenue`
- [x] `VenueTableEntity`: `eventId`, `capacity`, `lockedUntil`, `soldAt`, `internalTableId`
- [x] UI uses API `status` only — `db_status` ignored

---

## Flutter implementation status

| Checklist item | Status | Location |
|----------------|--------|----------|
| `GET /events/:id` + `purchase` meta | ✅ | `EventDetailModel` |
| `physical_venue` on event detail | ✅ | `EventDetailEntity.physicalVenue` |
| `GET /events/:id/ticket-types` | ✅ | `VipVenueApiService.fetchTicketTypes` |
| `GET /events/:id/venue-layout` | ✅ | `VenueFloorPlanModel` |
| `venue_id` vs `layout_venue_id` | ✅ | `VenueFloorPlanEntity` |
| `GET /venues`, `GET /venues/:id` | ✅ | `fetchVenues`, `fetchVenueById` |
| Zone / table parsing | ✅ | `VenueZoneModel`, `VenueTableModel` |
| Table `status` incl. `reserved` | ✅ | `VenueTableStatus` |
| Table lock + `lock_id` checkout | ✅ | `VipPurchaseSessionCheckout` |
| Realtime availability merge | ✅ | `VipVenueAvailabilityMapper` |
| Mock fallback | ✅ | `AppConstants.useVipVenueMockData` |

---

## Quick reference

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/events/:eventId` | Optional | `EventsApiService.fetchEventById` |
| GET | `/events/:eventId/ticket-types` | — | `fetchTicketTypes` |
| GET | `/events/:eventId/venue-layout` | Optional | `fetchVenueLayout` |
| GET | `/venues` | — | `fetchVenues` |
| GET | `/venues/:id` | — | `fetchVenueById` |
| GET | `/events/:eventId/zones/:zoneId/tables` | Optional | `fetchZoneTables` |
| GET | `/events/:eventId/tables/:tableId` | Optional | `fetchTableById` |
| POST | `/events/:eventId/tables/:tableId/lock` | Bearer | `lockTable` |
| DELETE | `/events/:eventId/tables/:tableId/lock` | Bearer | `releaseTableLock` |
| GET | `/events/:eventId/tables/availability/realtime` | Optional | `fetchTableAvailabilityRealtime` |
| POST | `/events/:eventId/checkout` | Bearer | `checkoutEvent` |

Use **`eventId`** = MongoDB event `id` from list/detail (not slug).

---

## Venue layout field note

- `venue_id` → **physical venue** catalog id (`VenueFloorPlanEntity.venueId`)
- `layout_venue_id` → floor-plan document id (`VenueFloorPlanEntity.layoutVenueId`)
- `physical_venue` → optional nested catalog metadata

---

## Zone tables field note

- `id` → external id for lock/checkout (`table-vip-1-m1`)
- `table_id` → internal id (`VenueTableEntity.internalTableId`)
- `status` → UI state (`available`, `locked`, `selected`, `sold`, `premium`, `reserved`)
- `db_status` → **ignored** in Flutter (persisted DB state only)
- `capacity` → preferred over `includes.people`

---

## Data layer map

```
lib/features/vip_venue/data/
  services/vip_venue_api_service.dart
  models/physical_venue_model.dart
  models/vip_venue_models.dart
  datasources/vip_venue_remote_datasource_impl.dart
  repositories/vip_venue_repository_impl.dart
```

---

## Checkout payloads

| Flow | Body |
|------|------|
| Single offering | `{ offering_id, quantity }` |
| Multiple offerings | `{ items: [{ offering_id, quantity }] }` |
| VIP table | `{ table_id, zone_id, tier, type, lock_id? }` |

---

## Error codes

| Code | HTTP | Meaning |
|------|------|---------|
| `TABLE_NOT_AVAILABLE` | 409 | Table sold |
| `TABLE_LOCKED` | 409 | Held by another user |
| `TABLE_LOCK_REQUIRED` | 409 | Checkout without active lock |
| `VENUE_LAYOUT_NOT_FOUND` | 404 | No floor plan |

Handled via `ApiException.code` in `VipVenueProvider`.

---

*End of VIP Venue API doc*
