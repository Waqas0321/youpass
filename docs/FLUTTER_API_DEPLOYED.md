# YouPass — Flutter API Reference (Production)

**Base URL:** `https://youpass-backend.vercel.app/api/v1`

**Health:** `GET /health` · `GET /health/db`

**App constant:** `AppConstants.apiBaseUrl` → `ApiEndpoints.apiV1`

---

## Authentication headers

| Header | When | Flutter |
|--------|------|---------|
| `Authorization: Bearer <access_token>` | Logged-in routes | `ApiClient` attaches token when present |
| `X-Device-Id: <uuid>` | All requests | `ClientRequestHeaders` / `DeviceIdService` |
| `X-Platform` / `X-App-Version` | Optional analytics | `ClientRequestHeaders` |
| `recaptcha_token` in body | When `security.recaptcha_enabled: true` | Wired; token null until mobile SDK added |

Load product rules on startup: **`GET /config/auth`** → `ConfigApiService.fetchAuthProductConfig()`

---

## 1. Config & bootstrap

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/config` | — | ✅ `ConfigApiService.fetchAppConfig` |
| GET | `/config/auth` | — | ✅ `fetchAuthProductConfig` |
| GET | `/config/security` | — | ✅ `fetchSecurityConfig` |
| GET | `/config/countries` | — | ✅ `fetchSupportedCountries` |
| GET | `/config/categories` | — | ✅ `fetchCategories` |
| GET | `/config/event-categories` | — | ✅ `fetchEventCategories` |
| GET | `/config/home-banners/carousel` | — | 🟡 Not dedicated call; banner from `/home/initial-feed` |
| GET | `/config/currency/:country` | — | 🟡 Currency from country config / event payload |
| GET | `/config/language/:country` | — | 🟡 App locale + country config |
| GET | `/config/payment-gateway/:country` | — | 🟡 From country / checkout meta |

**Detailed docs:** [FLUTTER_MULTI_COUNTRY_LATAM_API.md](./FLUTTER_MULTI_COUNTRY_LATAM_API.md) · [FLUTTER_PRODUCT_DECISIONS_API.md](./FLUTTER_PRODUCT_DECISIONS_API.md)

---

## 2. Auth (WhatsApp OTP)

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| POST | `/auth/check-whatsapp` | — | ✅ |
| POST | `/auth/send-code` | — | ✅ |
| POST | `/auth/resend-code` | — | ✅ |
| POST | `/auth/verify-code` | — | ✅ |
| POST | `/auth/login` | — | ✅ |
| POST | `/auth/register` | — | ✅ |
| POST | `/auth/logout` | Bearer | ✅ |
| POST | `/auth/change-phone/request` | Bearer | ✅ |
| POST | `/auth/change-phone/verify` | Bearer | ✅ |
| POST | `/auth/delete-account/request` | Bearer | ✅ |
| POST | `/auth/delete-account/verify` | Bearer | ✅ |

**Detailed docs:** [FLUTTER_AUTH_REGISTRATION_API.md](./FLUTTER_AUTH_REGISTRATION_API.md) · [FLUTTER_POST_REGISTRATION_YOUHOME.md](./FLUTTER_POST_REGISTRATION_YOUHOME.md) · [FLUTTER_SECURITY_AUTH_API.md](./FLUTTER_SECURITY_AUTH_API.md)

---

## 3. YouHome (events screen)

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/home/initial-feed` | Optional | ✅ `EventsApiService.fetchInitialFeed` |
| GET | `/home/upcoming-events` | Optional | ✅ endpoint defined; list uses initial-feed + `/events` |

Query examples:

```
GET /home/initial-feed?country_code=CL&event_type=concerts&context=post_register
GET /home/upcoming-events?country_code=CL&page=1&limit=20
```

**Layout fields:** `data.layout.header` · `categories` · `main_banner` · `search` · `upcoming_events`

**Detailed doc:** [FLUTTER_EVENTS_FAVORITES_API.md](./FLUTTER_EVENTS_FAVORITES_API.md)

---

## 4. Events & favorites

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/events/types` | — | ✅ |
| GET | `/events/featured` | Optional | ✅ |
| GET | `/events` | Optional | ✅ (`q` search on See all) |
| GET | `/events/:id` | Optional | ✅ |
| GET | `/events/:id/availability` | Optional | ✅ endpoint defined |
| POST | `/events/:eventId/checkout` | Bearer | ✅ |
| POST | `/events/:eventId/checkout/confirm` | Bearer | ✅ |
| GET | `/users/me/favorites/events` | Bearer | ✅ |
| POST | `/users/me/favorites/events/:eventId` | Bearer | ✅ (no JSON body) |
| DELETE | `/users/me/favorites/events/:eventId` | Bearer | ✅ |
| GET | `/users/me/favorites/producers` | Bearer | ✅ |
| POST | `/users/me/favorites/producers/:producerId` | Bearer | ✅ |
| DELETE | `/users/me/favorites/producers/:producerId` | Bearer | ✅ |

**Producers**

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/producers/:id` | Optional | 🟡 Not wired |
| GET | `/producers/:id/upcoming-events` | Optional | ✅ endpoint defined |

---

## 5. VIP venue & ticket types

Nested under **`/events/:eventId/`**

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/events/:eventId/ticket-types` | — | ✅ `VipVenueApiService` |
| GET | `/events/:eventId/venue-layout` | Optional | ✅ |
| GET | `/events/:eventId/zones/:zoneId/tables` | Optional | ✅ |
| GET | `/events/:eventId/tables/:tableId` | Optional | ✅ |
| GET | `/events/:eventId/tables/:tableId/lock/status` | Optional | ✅ |
| GET | `/events/:eventId/tables/availability/realtime` | Optional | ✅ |
| POST | `/events/:eventId/tables/:tableId/lock` | Bearer | ✅ |
| DELETE | `/events/:eventId/tables/:tableId/lock` | Bearer | ✅ |

**Detailed doc:** *(FLUTTER_VIP_VENUE_API.md — TBD)* · endpoints in `ApiEndpoints` + `VipVenueApiService`

---

## 6. User profile

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/users/me` | Bearer | ✅ |
| GET | `/users/me/welcome-data` | Bearer | ✅ |
| GET | `/users/me/profile-completeness` | Bearer | ✅ |
| GET | `/users/me/profile-banner/status` | Bearer | ✅ |
| POST | `/users/me/profile-banner/dismiss` | Bearer | ✅ |
| PATCH | `/users/me/profile` | Bearer | ✅ |
| POST | `/users/me/profile-photo` | Bearer | ✅ |
| DELETE | `/users/me/photo` | Bearer | 🟡 Not wired |
| GET | `/users/me/category-benefits` | Bearer | ✅ |
| GET | `/users/me/notification-settings` | Bearer | ✅ |
| PATCH | `/users/me/notification-settings` | Bearer | ✅ |

---

## 7. Wallet & payments

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/users/me/wallet/cards` | Bearer | ✅ |
| POST | `/users/me/wallet/cards` | Bearer | ✅ |
| POST | `/users/me/wallet/cards/tokenize-session` | Bearer | ✅ |
| DELETE | `/users/me/wallet/cards/:id` | Bearer | ✅ |
| PATCH | `/users/me/wallet/cards/:id/default` | Bearer | ✅ |
| GET | `/users/me/wallet/balance` | Bearer | ✅ |
| GET | `/users/me/wallet/transactions` | Bearer | ✅ |
| GET | `/users/me/payment-methods` | Bearer | ✅ (legacy alias) |

**Rule:** Tokenized cards only — no raw PAN.

**Detailed docs:** [FLUTTER_SECURITY_AUTH_API.md](./FLUTTER_SECURITY_AUTH_API.md) · [FLUTTER_MULTI_COUNTRY_LATAM_API.md](./FLUTTER_MULTI_COUNTRY_LATAM_API.md) · [FLUTTER_MULTI_CURRENCY_AUDIT.md](./FLUTTER_MULTI_CURRENCY_AUDIT.md)

---

## 8. Invitations

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/invitations/claim/:token` | — | ✅ |
| GET | `/users/me/invitations` | Bearer | ✅ |
| GET | `/users/me/invitations/summary` | Bearer | ✅ |
| GET | `/users/me/invitations/:id` | Bearer | 🟡 Uses combined invitation routes |
| GET | `/users/me/invitations/:id/status` | Bearer | 🟡 Partial |
| POST | `/users/me/invitations/:id/accept` | Bearer | ✅ (accept/confirm flow) |
| POST | `/users/me/invitations/:id/reject` | Bearer | ✅ |
| POST | `/users/me/invitations/:id/cancel` | Bearer | ✅ |

**Detailed doc:** *(FLUTTER_INVITATIONS_API.md — TBD)* · `InvitationsApiService`

---

## 9. My tickets

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/users/me/tickets/upcoming` | Bearer | ✅ |
| GET | `/users/me/tickets/past` | Bearer | ✅ |
| GET | `/users/me/tickets/yearly-summary` | Bearer | ✅ |
| GET | `/users/me/tickets/:id` | Bearer | ✅ |
| GET | `/users/me/tickets/:id/qr` | Bearer | ✅ |
| POST | `/users/me/tickets/:id/cancel` | Bearer | ✅ |

**Detailed doc:** *(FLUTTER_TICKETS_API.md — TBD)* · `TicketsApiService`

---

## 10. Guest ticket assignment

Under **`/users/me/ticket-orders/:orderId/`**

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `.../assignments` | Bearer | ✅ |
| POST | `.../slots/:slotId/assign` | Bearer | ✅ |
| DELETE | `.../slots/:slotId/assign` | Bearer | ✅ |
| POST | `.../slots/:slotId/resend` | Bearer | ✅ |

**Detailed doc:** *(FLUTTER_GUEST_TICKETS_API.md — TBD)* · `TicketAssignmentApiService`

---

## 11. Waitlist

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/events/:id/waitlist/preview` | Bearer | ✅ |
| POST | `/events/:id/waitlist/join` | Bearer | ✅ |
| DELETE | `/events/:id/waitlist/leave` | Bearer | ✅ |
| GET | `/events/:id/waitlist/position` | Bearer | ✅ |
| POST | `/waitlist/offers/:id/claim` | Bearer | ✅ |

---

## 12. Support

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/support/contact-info` | — | ✅ |
| GET | `/support/faqs` | — | ✅ |
| POST | `/support/faqs/:id/feedback` | — | ✅ |
| GET | `/support/whatsapp-template` | Bearer | ✅ |
| GET | `/support/email-template` | Bearer | ✅ |

---

## 13. Analytics

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| POST | `/analytics/event/registration-completed` | Bearer | ✅ `AnalyticsApiService` |

---

## 14. Post-registration flow (critical)

```
POST /auth/register
  → Welcome screen 2s (welcome.* from response)
  → GET /home/initial-feed?context=post_register
  → YouHome (NOT Profile, NOT drawer)
  → POST /analytics/event/registration-completed
```

**Detailed doc:** [FLUTTER_POST_REGISTRATION_YOUHOME.md](./FLUTTER_POST_REGISTRATION_YOUHOME.md)

---

## Quick test commands

```bash
curl -s https://youpass-backend.vercel.app/api/v1/health
curl -s https://youpass-backend.vercel.app/api/v1/config/auth
curl -s "https://youpass-backend.vercel.app/api/v1/home/initial-feed?country_code=CL"
curl -s "https://youpass-backend.vercel.app/api/v1/events?country_code=CL&limit=5"
```

---

## All Flutter docs (index)

| Doc | Topic |
|-----|--------|
| [FLUTTER_API_DEPLOYED.md](./FLUTTER_API_DEPLOYED.md) | This file — production index + Flutter status |
| [FLUTTER_AUTH_REGISTRATION_API.md](./FLUTTER_AUTH_REGISTRATION_API.md) | Welcome Back, OTP, register |
| [FLUTTER_POST_REGISTRATION_YOUHOME.md](./FLUTTER_POST_REGISTRATION_YOUHOME.md) | Welcome → YouHome |
| [FLUTTER_EVENTS_FAVORITES_API.md](./FLUTTER_EVENTS_FAVORITES_API.md) | YouHome layout, search, favorites |
| [FLUTTER_MULTI_COUNTRY_LATAM_API.md](./FLUTTER_MULTI_COUNTRY_LATAM_API.md) | Multi-country, checkout |
| [FLUTTER_PRODUCT_DECISIONS_API.md](./FLUTTER_PRODUCT_DECISIONS_API.md) | Product rules |
| [FLUTTER_SECURITY_AUTH_API.md](./FLUTTER_SECURITY_AUTH_API.md) | Device ID, reCAPTCHA, cards |
| [FLUTTER_MULTI_CURRENCY_AUDIT.md](./FLUTTER_MULTI_CURRENCY_AUDIT.md) | Currency fields audit |
| [BACKEND_MULTI_COUNTRY_LATAM_HANDOFF.md](./BACKEND_MULTI_COUNTRY_LATAM_HANDOFF.md) | Backend handoff notes |

| [FLUTTER_VIP_VENUE_API.md](./FLUTTER_VIP_VENUE_API.md) | VIP venue map, tables, checkout |

---

## Known gaps (summary)

| Area | Status |
|------|--------|
| Production base URL | ✅ `AppConstants.apiBaseUrl` |
| Auth + post-registration | ✅ Aligned |
| YouHome layout + favorites | ✅ Aligned; home search bar UI TBD |
| Multi-currency display | 🟡 Partial — see currency audit |
| reCAPTCHA mobile SDK | 🟡 API wired; token not sent yet |
| Full checkout (Klap/Stripe confirm) | 🟡 Partial |
| Producer profile `GET /producers/:id` | ❌ Not wired |
| Delete profile photo endpoint | ❌ Not wired |

---

*Production deploy — base URL `youpass-backend.vercel.app`*
