# Invitations API — Flutter Integration Notes

**Date:** June 2026  
**Status:** Integrated with live backend  
**Mock data:** `AppConstants.useInvitationsMockData = false`

This document records what was wired in the Flutter app against the backend Invitations API, and any **backend adjustments** needed if responses differ from the contract.

---

## 1. What was integrated

| Feature | Endpoint | Flutter location |
|---------|----------|------------------|
| List invitations | `GET /invitations` | `InvitationsApiService.fetchInvitations()` |
| Drawer badge count | `GET /users/me/invitations/summary` | `InvitationsProvider.refreshDrawerBadge()` |
| Saved cards check | `GET /users/me/payment-methods` | `InvitationsApiService.hasSavedPaymentMethods()` |
| Confirm | `POST /invitations/:id/confirm` body `{}` | `confirmInvitation()` |
| Reject | `POST /invitations/:id/reject` body `{}` | `rejectInvitation()` |
| Ticket / QR | `GET /invitations/:id/ticket` | `fetchTicket()` |
| Save card | `POST /users/me/payment-methods` | `savePaymentMethod()` |
| Invitation detail | `GET /invitations/:id` | `fetchInvitationDetail()` — **service ready, no detail screen yet** |

---

## 2. Response fields the app parses

### List item (`InvitationModel`)

| Backend field | Required | Notes |
|---------------|----------|-------|
| `id` | Yes | UUID string |
| `event_title` | Yes | Also accepts `eventTitle`, `title` |
| `location` | Yes | Also accepts `location_label`, `venue` |
| `date_time_label` | Yes | Pre-formatted display string |
| `image_url` | No | HTTPS URL shown in card; empty → grey placeholder |
| `tier` | Yes | `general` or `vip` |
| `type` | No | e.g. `courtesy`, `general`, `vip` — stored, not shown yet |
| `status` | Yes | `pending`, `confirmed`, `rejected` (client hides rejected) |
| `requires_payment_method` | No | Default `false`; if `true`, courtesy confirm flow runs |
| `entry_code` | No | On confirmed items only |
| `qr_payload` | No | Optional on list; ticket endpoint is canonical for QR |

### List wrapper

Preferred:

```json
{
  "success": true,
  "data": {
    "invitations": [ ... ],
    "meta": { "pending_count": 2, "new_count": 2, "total_count": 3 }
  }
}
```

`meta` is optional; badge uses dedicated summary endpoint.

### Summary (`GET /users/me/invitations/summary`)

| Field | Used for |
|-------|----------|
| `new_count` | Drawer badge (preferred) |
| `pending_count` | Fallback if `new_count` is 0 |
| `total_count` | Not shown in UI yet |

Badge hidden when count is `0`.

### Ticket (`GET /invitations/:id/ticket`)

| Field | Required |
|-------|----------|
| `event_title` | Yes |
| `date_time_label` | Yes |
| `location` | Yes |
| `entry_code` | Yes |
| `qr_payload` | Yes |
| `qr_status` | No | App relies on HTTP 423 for locked state |
| `instruction` | No | Not rendered yet |

### Payment methods

**GET** — response `data` may be a **raw array** or an object:

```json
{ "success": true, "data": [] }
```

or

```json
{ "success": true, "data": { "payment_methods": [ ... ] } }
```

App uses `getRawData` and treats empty array as no saved cards.

**POST** — request body:

```json
{
  "card_number": "4111111111111111",
  "expiry": "12/28",
  "cvv": "123",
  "cardholder_name": "Name"
}
```

After success, app sets `hasPaymentMethod = true` locally.

---

## 3. UI behaviour (unchanged layout)

### My Invitations screen

- Search + filters (All / General / VIP) — **client-side** on list payload
- Rejected invitations hidden in list
- Pending: **Confirm attendance** + **Reject**
- Confirmed: **View QR**

### Courtesy confirm flow (`requires_payment_method: true`)

1. Important warning dialog  
2. If no saved card → Add payment method dialog → `POST /users/me/payment-methods`  
3. `POST /invitations/:id/confirm` with `{}`  
4. `GET /invitations/:id/ticket` → Event ticket screen  

General / VIP pending invitations skip steps 1–2 when `requires_payment_method` is false.

### QR locked (HTTP 423)

If ticket returns `QR_LOCKED`, app shows backend `error.message` in a snackbar (no ticket screen).

### Home drawer

- Badge loaded from summary API on home init and when opening drawer  
- Shows `"N new"` only when count > 0  

### Event images

- URLs in `image_url` render via `EventNetworkImage`  
- Missing/invalid URL → grey placeholder (no local dummy asset for API items)

---

## 4. Backend checklist (please verify)

Use this when tuning API responses:

- [ ] `GET /invitations` returns authenticated user's invitations only  
- [ ] `requires_payment_method: true` only on courtesy-type pending items  
- [ ] `POST .../confirm` and `POST .../reject` accept `{}` body (Content-Type: application/json)  
- [ ] Confirm returns updated invitation with `status: confirmed`  
- [ ] Reject returns `status: rejected`  
- [ ] `GET .../ticket` returns 423 + `QR_LOCKED` before event day 00:00  
- [ ] `GET .../ticket` returns `qr_payload` + `entry_code` when unlocked  
- [ ] `GET /users/me/payment-methods` returns array (any supported key above)  
- [ ] `GET /users/me/invitations/summary` returns `new_count` / `pending_count`  
- [ ] All success responses use `{ "success": true, "data": ... }`  
- [ ] Errors use `{ "success": false, "error": { "code", "message" } }`  
- [ ] `401` uses `SESSION_INVALID` or `UNAUTHORIZED` → app logs user out  

---

## 5. Test account (seeded backend)

Expected invitations for first active user (e.g. Waqas Akhtar):

| Event | Status | Tier | Type | Payment required |
|-------|--------|------|------|------------------|
| YouFest 2026 | pending | vip | courtesy | yes |
| Concierto X | pending | general | general | no |
| Festival Verano 2026 | confirmed | vip | vip | no (QR available) |

**Manual QA flow**

1. Login → open drawer → verify badge count matches summary  
2. Invitations → see 2 pending + 1 confirmed  
3. Confirm Concierto X (no card dialog)  
4. Confirm YouFest → card dialog → save card → confirm → ticket or QR_LOCKED  
5. Festival Verano → View QR → ticket screen  
6. Reject a pending item → disappears from list  

---

## 6. Not implemented in app (future)

- Invitation detail screen (`GET /invitations/:id`)  
- Cancel confirmed invitation  
- Guaranteed Pass pre-auth / charges  
- Server-side search/filter query params (client filters locally today)  
- Display `type` badge (Courtesy / VIP Table) on cards  

---

## 7. Files changed in this integration

| Area | Path |
|------|------|
| Mock off | `lib/core/constants/app_constants.dart` |
| Endpoints | `lib/core/network/api_endpoints.dart` |
| Models | `lib/features/invitations/data/models/*` |
| Entity | `lib/features/invitations/domain/entities/invitation_entity.dart` |
| API service | `lib/features/invitations/data/services/invitations_api_service.dart` |
| Provider | `lib/features/invitations/presentation/providers/invitations_provider.dart` |
| Drawer badge | `lib/features/home/presentation/screens/home_screen.dart` |
| Network images | `lib/features/invitations/presentation/widgets/invitation_card_widget.dart` |
| Confirm flow | `lib/features/invitations/presentation/utils/invitations_screen_actions.dart` |
| DI | `lib/dependency_injection/injection_container.dart` |

---

## 8. Related docs

- [INVITATIONS_API.md](./INVITATIONS_API.md) — Full API specification (v1.0)  
- Backend handoff: Flutter Invitations API (user-provided summary)

If backend response shapes change, update **`InvitationModel.fromJson`** and this document together.
