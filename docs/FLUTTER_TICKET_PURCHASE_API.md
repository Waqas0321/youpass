# Flutter — Ticket Purchase Integration Guide

**Production base URL:** `https://youpass-backend-two.vercel.app/api/v1`

Handoff for the **Buy tickets** flow: general pre-sales, VIP General, VIP tables, floor plan, lock, and checkout.

**Related:** [FLUTTER_VIP_VENUE_API.md](./FLUTTER_VIP_VENUE_API.md) · [FLUTTER_EVENTS_FAVORITES_API.md](./FLUTTER_EVENTS_FAVORITES_API.md) · [FLUTTER_API_DEPLOYED.md](./FLUTTER_API_DEPLOYED.md)

---

## Flutter implementation status

| Requirement | Status | Location |
|-------------|--------|----------|
| Ticket type model (`type`, `name`, `offering_id`, flags) | ✅ | `TicketOfferingEntity`, `TicketOfferingModel` |
| No stock numbers in UI | ✅ | Stock fields not parsed/displayed |
| Sold out = disabled row, still visible | ✅ | `TicketOfferingRowWidget`, ticket selection |
| No client quantity cap | ✅ | `VipTicketQuantityStepperWidget` (unbounded +) |
| Checkout uses `offering_id` | ✅ | `checkoutOfferingId` → `VipPurchaseSessionCheckout` |
| `venue_id` vs `layout_venue_id` | ✅ | `VenueFloorPlanEntity` |
| `table_lock_minutes` from layout | ✅ | `VipPurchaseSession.tableLockMinutes` |
| Table `capacity` from API | ✅ | `VenueTableModel`, `VipTableDetailCardWidget` |
| Table lock → checkout + `lock_id` | ✅ | `PurchaseSummaryScreen._attemptCheckout` |
| Checkout errors (409) | ✅ | `VipCheckoutMessageLocalizer` |
| `TABLE_LOCK_REQUIRED` re-lock retry | ✅ | `_attemptCheckout` |
| `INSUFFICIENT_STOCK` / sold out refresh | ✅ | `_refreshTicketTypes` |
| VIP includes display (bottles, vouchers) | ✅ | `VipTableDetailCardWidget` (copy TBD) |

---

## Ticket offering model

```dart
// Checkout id — prefer MongoDB offering_id
offering.checkoutOfferingId

// Display — prefer API name
offering.displayName

// UX flags — no stock fields
offering.isSoldOut
offering.isSelectable
offering.isQuantitySelectable
```

**Type enum:** `early_bird` · `preventa_2` · `preventa_3` · `general` · `vip_general`

---

## UX rules (enforced)

1. Never show `stock_total`, `stock_remaining`, or zone table counts.
2. Sold-out waves stay in the list with a disabled “Sold out” badge.
3. Quantity stepper has no app-side maximum — backend returns `INSUFFICIENT_STOCK`.
4. VIP table capacity shown as guest count (`table.capacity`), not remaining stock.

---

## Checkout error codes

| Code | Flutter action |
|------|----------------|
| `INSUFFICIENT_STOCK` | Snackbar + refresh ticket types |
| `TICKET_OFFERING_SOLD_OUT` | Snackbar + refresh ticket types |
| `TABLE_LOCK_REQUIRED` | Re-lock table + retry checkout once |
| `TABLE_NOT_AVAILABLE` | Localized message |
| `TABLE_LOCKED` | Localized message |

---

*End of ticket purchase integration guide*
