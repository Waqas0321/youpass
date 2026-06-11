# YouPass Backend — Multi-Country LATAM Handoff

This document describes **backend and dashboard changes** required for Chile + LATAM support. The Flutter app is a **consumer** of this config: it displays country, currency, language, dates, and opens the correct checkout flow based on API responses.

**Base URL (current app):** `https://youpass-backend.vercel.app/api/v1`

---

## Architecture rule

| Layer | Responsibility |
|-------|----------------|
| **Dashboard / admin** | Configure countries, currencies, gateways, WhatsApp templates |
| **Backend** | Business rules, validation, payments, WhatsApp, timezone, data storage |
| **Flutter app** | UI, locale, formatting, gateway SDK / WebView when API instructs |

**Gateway selection must live on the server:**

```
CHILE (+56 / CL)  →  Klap  +  CLP
REST OF LATAM     →  Stripe +  local currency
```

The app must **not** decide Klap vs Stripe locally.

---

## Current state (what the app already uses)

| Feature | Endpoint / field | Gap |
|---------|------------------|-----|
| Countries | `GET /config/countries` | Only `code`, `name`, `dialCode`, `flagEmoji` |
| Auth country | `country_code` on auth requests | OK — needs server validation per country |
| User country | `countryCode` on profile | OK — used for locale after login |
| Event country | `country_code` on events | Optional; often missing |
| Currency | `currency` on ticket types, checkout | Often defaults to `CLP` |
| Checkout | `POST /events/:id/checkout` | No real Klap/Stripe session yet |
| WhatsApp | `POST /auth/check-whatsapp`, send-code `channel` | Backend-only; needs templates per language |
| Payment methods | `POST /users/me/payment-methods` | Raw card fields — should move to tokenization |

---

## 1. Country configuration (dashboard + API)

### Dashboard

- CRUD for supported countries: enable/disable, sort order, default country.
- Per country: language, currency, timezone, payment gateway, phone rules.

### API — extend existing endpoint

**`GET /api/v1/config/countries`**

Current shape (app parses today):

```json
{
  "success": true,
  "data": [
    {
      "code": "CL",
      "name": "Chile",
      "dialCode": "56",
      "flagEmoji": "🇨🇱"
    }
  ]
}
```

**Target shape (recommended):**

```json
{
  "success": true,
  "data": [
    {
      "code": "CL",
      "name": "Chile",
      "dialCode": "56",
      "flagEmoji": "🇨🇱",
      "phoneHint": "9 1234 5678",
      "defaultLanguage": "es",
      "defaultCurrency": "CLP",
      "timezone": "America/Santiago",
      "paymentGateway": "klap",
      "isActive": true,
      "sortOrder": 0
    },
    {
      "code": "MX",
      "name": "Mexico",
      "dialCode": "52",
      "flagEmoji": "🇲🇽",
      "phoneHint": "55 1234 5678",
      "defaultLanguage": "es",
      "defaultCurrency": "MXN",
      "timezone": "America/Mexico_City",
      "paymentGateway": "stripe",
      "isActive": true,
      "sortOrder": 1
    },
    {
      "code": "BR",
      "name": "Brazil",
      "dialCode": "55",
      "flagEmoji": "🇧🇷",
      "phoneHint": "11 91234 5678",
      "defaultLanguage": "pt",
      "defaultCurrency": "BRL",
      "timezone": "America/Sao_Paulo",
      "paymentGateway": "stripe",
      "isActive": true,
      "sortOrder": 2
    }
  ]
}
```

### Optional aggregate config

**`GET /api/v1/config`**

```json
{
  "success": true,
  "data": {
    "defaultCountryCode": "CL",
    "supportedLanguages": ["es", "pt", "en"],
    "countries": [ "...same as above..." ]
  }
}
```

---

## 2. Multi-currency

### Data model

- Every **event** has a `currency` (ISO 4217: `CLP`, `ARS`, `BRL`, `MXN`, …).
- Every **ticket offering** and **VIP table** price uses that event’s currency.
- Amounts are **integers in minor units** (document convention: e.g. CLP has no decimals; MXN/ARS use centavos).

### Endpoints that must return `currency`

| Endpoint | Fields |
|----------|--------|
| `GET /events/:id` | `purchase.currency`, `country_code` |
| `GET /events/:id/ticket-types` | `currency` on each offering + bundle-level default |
| `GET /events/:id/zones/:zoneId/tables` | `currency` on table prices (or inherit from event) |
| `POST /events/:id/checkout` (request/response) | `currency`, `subtotal_amount`, `service_fee_amount`, `total_amount` |

### Example — ticket type offering

```json
{
  "slug": "general",
  "label": "General admission",
  "price": 35000,
  "currency": "CLP",
  "section": "general"
}
```

### Dashboard

- Organizer selects country + currency when creating an event.
- Prices stored and returned in the event’s currency only (no silent CLP fallback).

---

## 3. Languages

### Backend

- Store `default_language` per country (`es`, `pt`, `en`).
- Return on country config and optionally on `GET /users/me/profile`:

```json
{
  "countryCode": "BR",
  "preferredLanguage": "pt"
}
```

- Support **`Accept-Language`** header on content endpoints OR return localized fields:

```json
{
  "title": "Summer Beats",
  "title_localized": {
    "es": "Summer Beats",
    "pt": "Summer Beats",
    "en": "Summer Beats"
  }
}
```

- Auth / API error messages should respect language when possible (app already sends locale context via user country).

### Dashboard

- Configure default language per country.
- Optional: per-event copy in ES / PT / EN.

---

## 4. Payment gateways — Klap + Stripe

### Gateway routing (server)

```typescript
function resolveGateway(countryCode: string): 'klap' | 'stripe' {
  if (countryCode === 'CL') return 'klap';
  return 'stripe';
}
```

Use **user country** or **event country** (prefer event country for purchases).

### Recommended checkout flow

Today the app calls **`POST /api/v1/events/:id/checkout`** with a body like:

```json
{
  "offering_id": "general",
  "quantity": 2,
  "payment_method_id": "pm_xxx"
}
```

**Phase A — prepare payment (new or extended response)**

`POST /api/v1/events/:id/checkout/prepare`  
or extend checkout to return a **pending** payment when `payment_method_id` is omitted:

```json
{
  "success": true,
  "data": {
    "order_id": "ord_abc123",
    "status": "payment_pending",
    "gateway": "klap",
    "currency": "CLP",
    "subtotal_amount": 70000,
    "service_fee_amount": 3500,
    "total_amount": 73500,
    "klap": {
      "payment_url": "https://...",
      "session_id": "klap_sess_xxx"
    }
  }
}
```

Stripe (LATAM) example:

```json
{
  "gateway": "stripe",
  "currency": "MXN",
  "total_amount": 150000,
  "stripe": {
    "payment_intent_id": "pi_xxx",
    "client_secret": "pi_xxx_secret_xxx",
    "customer_id": "cus_xxx"
  }
}
```

**Phase B — confirm payment**

- **Webhooks** (required):
  - `POST /webhooks/klap` — payment succeeded / failed
  - `POST /webhooks/stripe` — `payment_intent.succeeded`, etc.
- On success: mark order `paid`, issue tickets, set `qr_unlock_at`, return assignment slots.
- On failure: order `failed`, release table locks.

**Phase C — complete checkout (app callback)**

`POST /api/v1/events/:id/checkout/confirm` (optional if webhooks are source of truth)

```json
{
  "order_id": "ord_abc123",
  "gateway": "stripe",
  "payment_intent_id": "pi_xxx"
}
```

### Payment methods — migrate off raw cards

Current app posts to **`POST /users/me/payment-methods`**:

```json
{
  "card_number": "4111...",
  "expiry": "12/28",
  "cvv": "123",
  "cardholder_name": "Jane Doe"
}
```

**Target:**

- Tokenize on client via Klap/Stripe SDK.
- Backend stores only `gateway`, `customer_id`, `payment_method_id`, last4, brand.
- Never store CVV; avoid storing full PAN (PCI).

### Dashboard

- Enable/disable Klap and Stripe per country.
- API keys and webhook secrets per environment.

---

## 5. WhatsApp

App sends phone + country on auth; backend owns delivery.

### Endpoints (existing)

| Method | Path | Body |
|--------|------|------|
| POST | `/auth/check-whatsapp` | `{ "phone", "country_code", "purpose" }` |
| POST | `/auth/send-code` | phone, country, purpose |
| POST | `/auth/resend-code` | … |

### Backend must implement

- WhatsApp Business API (verified account).
- **Templates per language** (`es`, `pt`, `en`) for:
  - OTP / login code
  - Registration code
  - Ticket invitation link
  - Resend invitation
- Template selection from user/event `country_code` or phone prefix.
- Structured errors, e.g. `WHATSAPP_SEND_FAILED` (app already handles this code).

### Dashboard

- Manage template IDs per language and purpose.
- Preview / test send per country.

---

## 6. Timezone

### Storage

- Store `starts_at` as **UTC** in the database.
- Store `timezone` on event (IANA, e.g. `America/Santiago`).

### API response (events)

```json
{
  "id": "evt_123",
  "country_code": "CL",
  "timezone": "America/Santiago",
  "starts_at": "2026-06-05T02:00:00.000Z",
  "starts_at_display": "4 jun 2026",
  "starts_at_time": "22:00",
  "date_time_display": "4 jun 2026 · 22:00"
}
```

Compute display strings using **event timezone**, not server locale.

---

## 7. Phone numbers

### Validation (server-side, required)

Validate and normalize to **E.164** on:

- `POST /auth/send-code`
- `POST /auth/verify-code`
- `POST /auth/login`
- `POST /auth/register`
- Ticket assignment guest assign (`country_code` + phone)

### Per-country rules (minimum LATAM)

| Country | ISO | Rule (example) |
|---------|-----|----------------|
| Chile | CL | 9 digits, mobile starts with 9 |
| Argentina | AR | 10–11 digits |
| Brazil | BR | 10–11 digits |
| Mexico | MX | 10 digits |
| Colombia | CO | 10 digits |
| Peru | PE | 9 digits |

Return clear error codes: `PHONE_INVALID`, `PHONE_UNSUPPORTED_COUNTRY`.

---

## 8. Dates

- **Accept** birthdate as ISO date: `yyyy-MM-dd` (app sends this on register).
- **Return** event dates as UTC + timezone + display fields (see §6).
- Do not assume Chile-only date parsing globally.

---

## 9. Events, home feed, categories

### Country filtering

- `GET /home/initial-feed?country=MX` — filter featured and lists by country.
- `GET /events?country=CL` — browse by country.
- Every event includes `country_code`.

### Categories

App currently hardcodes a “Chile” browse chip. Replace with API-driven country categories:

```json
{
  "categories": [
    { "id": "all", "label": "All" },
    { "id": "country:CL", "label": "Chile", "countryCode": "CL" },
    { "id": "parties", "label": "Parties", "eventTypeSlug": "parties" }
  ]
}
```

---

## 10. Auth & user profile

### Register / profile fields

Ensure profile returns:

```json
{
  "id": "usr_xxx",
  "phone": "56912345678",
  "phoneDisplay": "+56 9 1234 5678",
  "countryCode": "CL",
  "preferredLanguage": "es",
  "fullName": "...",
  "email": "...",
  "birthdate": "1990-01-15"
}
```

- `countryCode` is **required** on register and immutable or changeable only via verified flow.
- Optional: `preferredLanguage` to override country default.

---

## 11. Checkout response (app expectations today)

`POST /events/:id/checkout` success body (app parses):

```json
{
  "success": true,
  "data": {
    "order_id": "ord_xxx",
    "event_title": "Summer Beats",
    "quantity": 2,
    "total_amount": 73500,
    "currency": "CLP",
    "subtotal_amount": 70000,
    "service_fee_amount": 3500,
    "available_to_assign": 2,
    "ticket_id": "tkt_xxx",
    "seat_label": "Table 5 - VIP",
    "qr_unlock_at": "2026-06-04T18:00:00.000Z"
  }
}
```

Add when payment is async:

```json
{
  "status": "payment_pending",
  "gateway": "klap",
  "payment_url": "https://..."
}
```

---

## 12. Implementation priority

| Priority | Item |
|----------|------|
| **P0** | Rich `/config/countries` + dashboard CRUD |
| **P0** | Currency on all pricing + checkout (no silent CLP default) |
| **P0** | Klap (CL) + Stripe (LATAM) + webhooks |
| **P1** | UTC + timezone on events |
| **P1** | E.164 phone validation per country |
| **P1** | WhatsApp templates per language |
| **P2** | `Accept-Language` / localized event copy |
| **P2** | Country-filtered home + dynamic categories |
| **P2** | Tokenized payment methods (deprecate raw card API) |

---

## 13. Flutter app — ready vs waiting

| App capability | Status |
|----------------|--------|
| Load countries from API | ✅ |
| Send `country_code` on auth | ✅ |
| Format currency from API `currency` field | ✅ (fallback if missing) |
| Locale from country (client map) | ✅ (will use API `defaultLanguage` when exposed) |
| Klap / Stripe checkout UI | ⏳ Waiting on prepare/confirm + webhook flow |
| Portuguese UI | ⏳ Waiting on `pt` l10n + API language config |

---

## 14. Environment & secrets

Backend needs per environment:

| Secret | Used for |
|--------|----------|
| Klap API key / merchant ID | Chile payments |
| Klap webhook secret | Payment confirmation |
| Stripe secret key | LATAM payments |
| Stripe webhook secret | Payment confirmation |
| WhatsApp Business token | OTP + invitations |
| WhatsApp template IDs | Per language / purpose |

---

## 15. Related app files (for backend devs)

| Area | Flutter path |
|------|----------------|
| API endpoints | `lib/core/network/api_endpoints.dart` |
| Country config parser | `lib/core/network/models/config_country_model.dart` |
| Checkout models | `lib/features/ticket_assignment/data/models/event_checkout_models.dart` |
| Ticket / VIP currency | `lib/features/vip_venue/data/models/vip_venue_models.dart` |
| Event detail purchase meta | `lib/features/events/data/models/event_detail_model.dart` |

---

*Last updated: June 2026 — aligned with YouPass Flutter client `1.0.0+1`.*
