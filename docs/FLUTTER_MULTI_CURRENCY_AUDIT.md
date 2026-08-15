# Flutter — Multi-Currency Audit

**Date:** June 2026  
**Base URL:** `https://youpass-backend-two.vercel.app/api/v1`  
**Related:** `BACKEND_MULTI_COUNTRY_LATAM_HANDOFF.md` §2 Multi-currency

**Verdict:** **Partial** — config + VIP/checkout formatting are done; correct currency on every screen is **not guaranteed** without backend fields.

---

## Summary

| Layer | Status |
|-------|--------|
| Formatting infrastructure | ✅ Done |
| VIP purchase flow | ✅ Done **if** API sends `currency` + `country_code` |
| Every screen | 🟡 Not guaranteed — CLP/Chile fallbacks mask missing API data |
| List/browse prices | N/A today (no UI) — backend only if product wants them |

---

## ✅ Flutter done (works when API sends data)

| Area | Status | Location |
|------|--------|----------|
| `GET /config/countries` | Parsed: `default_currency`, `currency_symbol`, `currency_decimals`, `payment_gateway` | `ConfigCountryModel`, `CountryCodeRegistry` |
| Currency formatter | Symbol, decimals, locale from registry | `VipCurrencyFormatter`, `CountryFormatHelper` |
| VIP ticket selection | Per-offering `currency` on rows + bottom bar total | `ticket_offering_row_widget.dart`, `ticket_selection_bottom_bar_widget.dart` |
| VIP table selection | Table price via `session.currency` | `table_selection_screen.dart`, `vip_table_detail_card_widget.dart` |
| Purchase summary | Subtotal, fees, total, pay button | `purchase_summary_content_widget.dart`, `purchase_summary_screen.dart` |
| Checkout response | Model parses `currency` (fallback `CLP`) | `event_checkout_models.dart` |

### Screens with no monetary UI (no currency work needed)

- Home, browse, favorites — event cards have no price field
- Tickets / invitations — no amounts shown
- Profile — wallet section is static Visa/Mastercard tiles (no real currency)

---

## 🟡 Flutter gaps (fixable without backend)

These are **frontend-only** improvements:

| # | Gap | File(s) |
|---|-----|---------|
| 1 | `purchase.currency` parsed on event detail but **not copied** into `VipPurchaseSession` | `vip_purchase_screen_actions.dart` |
| 2 | Tables have no `currency` field — only `price`; table UI uses `session.currency` | `vip_venue_models.dart` (`VenueTableModel`) |
| 3 | CLP / `CL` defaults when API omits fields | See table below |
| 4 | Mock checkout datasource hardcodes `currency: 'CLP'` | `ticket_assignment_remote_datasource_impl.dart` |
| 5 | Unused l10n strings hardcode CLP (`mockPriceFrom35000`, etc.) — not wired to widgets | `app_en.arb`, `app_es.arb` |

### CLP / Chile fallback locations

| File | Fallback |
|------|----------|
| `vip_venue_models.dart` | `currency: 'CLP'` on ticket offering parse |
| `event_detail_model.dart` | `purchase.currency` → `'CLP'` |
| `event_checkout_models.dart` | `currency` → `'CLP'` |
| `ticket_offering_entity.dart` | Default `currency = 'CLP'` |
| `vip_purchase_widgets.dart` | `currencyCode: 'CLP'`, `countryIsoCode: 'CL'` |
| `vip_table_detail_card_widget.dart` | `currencyCode: 'CLP'` |
| `vip_shared_widgets.dart` | `currencyLabel: 'CLP'` |
| `vip_purchase_session.dart` | `countryIsoCode` → `event.countryCode ?? 'CL'`; currency from offerings or country default |

### Session currency resolution (today)

```
1. First non-empty offering.currency
2. Else CountryFormatHelper.countryFor(countryIsoCode).defaultCurrency
3. countryIsoCode = event.countryCode ?? 'CL'
```

`purchase.currency` from `GET /events/:id` is **not** used in this chain yet.

---

## ❓ Ask backend to confirm

Wrong or missing API data will show wrong currency even with correct Flutter formatting.

### Must confirm (handoff §2)

| # | Endpoint | Backend must return |
|---|----------|---------------------|
| **1** | `GET /config/countries` | For **AR, BR, MX, CO, PE, …**: `default_currency`, `currency_symbol`, `currency_decimals` (not Chile-only) |
| **2** | `GET /events/:id` | `purchase.currency` + `country_code` on **every** event (especially non-Chile) |
| **3** | `GET /events/:id/ticket-types` | `currency` on **each** offering (no silent `CLP` for LATAM events) |
| **4** | `GET /events/:id/zones/:zoneId/tables` | `currency` on bundle or each table (or documented inherit from event) |
| **5** | `POST /events/:id/checkout` | Response: `currency`, `subtotal_amount`, `service_fee_amount`, `total_amount` in event currency |

### Also worth confirming

| # | Topic | Why |
|---|--------|-----|
| **6** | `country_code` on **list** events (`/events`, home, featured) | Flutter uses `event.countryCode ?? 'CL'` when offerings have no currency |
| **7** | Amount units | Handoff: integers in minor units — confirm CLP (0 decimals) vs MXN/ARS/BRL (2 decimals) match stored values |

### Only if product wants prices on event cards

| # | Endpoint | Fields |
|---|----------|--------|
| **8** | Home / events list APIs | `from_price` or `min_price` + `currency` — **Flutter does not show list prices today** |

---

## Copy-paste questions for backend

1. For a **Mexico event**, does `GET /events/:id` return `purchase.currency: "MXN"` and `country_code: "MX"`?
2. Do **ticket-types** and **zone tables** return per-item `currency` for non-Chile events?
3. Does **checkout** response always return the event’s `currency` and amounts in that currency?
4. Does **`GET /config/countries`** include full currency metadata for all active LATAM countries?
5. Do **event list** endpoints include `country_code` (and optionally `from_price` + `currency`)?

---

## Example API shapes (target)

### Ticket offering

```json
{
  "slug": "general",
  "label": "General admission",
  "price": 35000,
  "currency": "CLP",
  "section": "general"
}
```

### Event detail purchase meta

```json
{
  "purchase": {
    "currency": "MXN",
    "country_code": "MX",
    "service_fee_rate": 0.05,
    "payment_gateway": "stripe",
    "has_ticket_offerings": true,
    "has_venue_layout": false
  }
}
```

### Checkout response

```json
{
  "currency": "MXN",
  "subtotal_amount": 35000,
  "service_fee_amount": 1750,
  "total_amount": 36750,
  "payment_gateway": "stripe"
}
```

---

## Key Flutter files

```
lib/core/locale/country_format_helper.dart
lib/core/constants/country_code_registry.dart
lib/core/network/models/config_country_model.dart

lib/features/vip_venue/presentation/utils/vip_currency_formatter.dart
lib/features/vip_venue/domain/entities/vip_purchase_session.dart
lib/features/vip_venue/data/models/vip_venue_models.dart
lib/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart

lib/features/events/data/models/event_detail_model.dart
lib/features/ticket_assignment/data/models/event_checkout_models.dart
```

---

## Recommended next steps

### After backend confirms 1–5

1. Wire `purchase.currency` into `VipPurchaseSession` when opening ticket selection.
2. Use `purchase.currency` in session currency chain before country default.
3. Optionally add `currency` to table bundle model if API returns it at zone level.
4. Reduce silent `CLP` fallbacks or log when currency is inferred (dev builds).

### If product wants list-card prices

1. Backend adds `from_price` + `currency` to list/home APIs.
2. Flutter adds price row to event cards using `VipCurrencyFormatter`.

---

## Status vs confirmed product decisions

| Decision | Currency status |
|----------|-----------------|
| Chile + LATAM countries | ✅ Registry + formatting |
| Multi-currency | 🟡 Partial — VIP/checkout OK when API sends data |
| Klap + Stripe payments | 🟡 Partial — gateway from API; Stripe SDK not fully wired |
