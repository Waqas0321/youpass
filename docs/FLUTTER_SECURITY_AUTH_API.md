# Flutter — Security & Auth API Integration

**Base URL:** `https://youpass-backend.vercel.app/api/v1`

This doc covers **attack protection**, **encryption**, and **Flutter changes** required to work with the secured backend.

---

## Backend security — already implemented

| Requirement | Status | How |
|-------------|--------|-----|
| OTP brute force (3 fails → 15 min lock) | ✅ | `OTP_MAX_FAILED_ATTEMPTS=3`, `OTP_BLOCK_MINUTES=15` |
| Code spam (max 5 resends/hour) | ✅ | `OTP_MAX_RESENDS_PER_HOUR=5` + 60s cooldown |
| OTP stored as hash | ✅ | bcrypt hash in `auth_codes.code_hash` |
| JWT signed + configurable expiry | ✅ | `JWT_SECRET`, `JWT_EXPIRES_IN` (default `365d`) |
| Session validation on every request | ✅ | Bearer token + DB session + token hash |
| One session per device | ✅ | Send `X-Device-Id` header |
| SIM swap protection | ✅ | Phone change OTP sent to **new** number only |
| HTTPS only | ✅ | Vercel TLS 1.2+ + HSTS in production |
| Payment cards tokenized | ✅ | Raw PAN rejected unless `ALLOW_LEGACY_CARD_INPUT=true` |
| reCAPTCHA on critical screens | ✅ | When `RECAPTCHA_ENABLED=true` on server |
| Data encrypted at rest | ✅ | MongoDB Atlas encryption at rest |

---

## Flutter implementation status

| Checklist item | Status | Location |
|----------------|--------|----------|
| Load `/config` security policy on bootstrap | ✅ | `CountryCodeRegistry`, `AppSecurityConfig` |
| Persist + send `X-Device-Id` on all requests | ✅ | `DeviceIdService`, `ClientRequestHeaders`, `ApiClient` |
| Send `X-Platform`, `X-App-Version` | ✅ | `ClientRequestHeaders` |
| reCAPTCHA token on auth/checkout | ✅ wired | `RecaptchaService`, `AuthApiService`, `TicketAssignmentApiService` |
| reCAPTCHA mobile SDK | ⏳ | `RecaptchaServiceImpl` — add Enterprise/WebView when enabling prod |
| OTP remaining attempts UI | ✅ | `AuthProvider.remainingAttempts`, `VerificationScreen` |
| OTP block / resend countdown | ✅ | `VerificationScreen` block timer |
| Secure JWT storage | ✅ | `SecureAccessTokenStorage` |
| `SESSION_INVALID` → force re-login | ✅ | `AuthProvider.runAuthAction`, `session_auth_handler` |
| Tokenized payment model | ✅ | `PaymentMethodRequestEntity` |
| Phone change API | ✅ | `AuthApiService.requestChangePhone` / `verifyChangePhone` |
| Phone change OTP copy | ✅ | `VerificationHeaderWidget` |
| Sanitize tokens in logs | ✅ | `AppLogger` |

---

## Key files

```
lib/core/security/
  security_config_model.dart
  app_security_config.dart
  device_id_service.dart
  client_request_headers.dart
  recaptcha_service.dart

lib/core/network/api_client.dart          # device headers on every request
lib/features/auth/data/services/auth_api_service.dart
lib/features/ticket_assignment/data/services/ticket_assignment_api_service.dart
```

---

## Device ID header

Every request includes:

```
X-Device-Id: <uuid persisted per install>
X-Platform: ios | android
X-App-Version: <from package_info_plus>
```

Logging in on the same device revokes the previous session on that device.

---

## reCAPTCHA

When `security.recaptcha_enabled == true`, the app attaches `recaptcha_token` to:

- `POST /auth/send-code` → action `send_code`
- `POST /auth/resend-code` → action `resend_code`
- `POST /auth/login` → action `login`
- `POST /auth/register` → action `register`
- `POST /events/:id/checkout` → action `checkout`

Wire a mobile token provider in `RecaptchaServiceImpl` before enabling `RECAPTCHA_ENABLED=true` in production.

---

## OTP error handling

| Code | Flutter behavior |
|------|------------------|
| `INVALID_CODE` | Shows remaining attempts from `details.remaining_attempts` |
| `BLOCKED` | Disables verify button; countdown from `retry_after_seconds` |
| `RESEND_COOLDOWN` | Resend timer from `retry_after_seconds` |
| `MAX_RESENDS` | Shows wait time when `retry_after_seconds` present |
| `SESSION_INVALID` | Clears session, returns to login |

---

## Phone change (SIM swap)

| Step | Endpoint |
|------|----------|
| 1 | `POST /auth/change-phone/request` |
| 2 | OTP on **new** number |
| 3 | `POST /auth/change-phone/verify` |

UI copy: *"We sent a code to your NEW number …"*

---

## Payment tokenization

Prefer tokenized payload:

```json
{
  "payment_method_id": "pm_xxx_or_klap_token",
  "gateway": "stripe",
  "brand": "visa",
  "last_four": "4242",
  "cardholder_name": "Jane Doe"
}
```

Raw card fields are legacy-only when `ALLOW_LEGACY_CARD_INPUT=true` on the server.

---

## Related docs

- `FLUTTER_MULTI_COUNTRY_LATAM_API.md` — multi-country config
- `BACKEND_MULTI_COUNTRY_LATAM_HANDOFF.md` — backend requirements

---

*Last updated: June 2026*
