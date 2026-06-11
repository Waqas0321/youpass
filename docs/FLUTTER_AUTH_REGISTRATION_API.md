# Flutter — Auth & Registration Screens API Guide

**Base URL:** `https://youpass-backend.vercel.app/api/v1`  
**Stack note:** Backend is **Express + Prisma + MongoDB** (not NestJS/PostgreSQL). All endpoints below are live on this API.

This doc maps the **Welcome Back**, **OTP verification**, and **Create Account** screens to backend calls. UI layout, colors, and step order are Flutter-only; rules and copy come from the API.

**Related:** `FLUTTER_PRODUCT_DECISIONS_API.md` (product rules), `FLUTTER_SECURITY_AUTH_API.md` (device ID, reCAPTCHA), `FLUTTER_MULTI_COUNTRY_LATAM_API.md` (countries).

---

## Flutter implementation status

| Checklist item | Status | Location |
|----------------|--------|----------|
| `GET /config/auth` on cold start | ✅ | `ConfigApiService`, `AppProductConfig` |
| Parse `ui_messages` | ✅ | `UiMessagesConfigModel` |
| Parse `registration.gender_options` | ✅ | `GenderOptionConfig`, `GenderPickerSheet` |
| Parse `terms_url` / `privacy_url` | ✅ | `RegistrationProductConfigModel`, `RegisterTermsWidget` |
| `auth.support_email` | ✅ | `AuthProductConfigModel.supportEmail` |
| `GET /config/countries` — country picker | ✅ | `CountryCodeRegistry`, `PhoneInputWidget` |
| Welcome Back: check-whatsapp → send-code | ✅ | `PhoneLoginFormWidget`, `WhatsAppAuthGate` |
| New user → OTP **before** registration wizard | ✅ | `PhoneLoginFormWidget` → `VerificationScreen` → `RegisterScreen` |
| OTP: 6 digits, 180s expiry, 60s resend | ✅ | `OtpPolicy`, `VerificationScreen` |
| Show `remaining_attempts` on `INVALID_CODE` | ✅ | `AuthProvider`, `AuthMessageLocalizer` |
| 15 min lock UI on `BLOCKED` | ✅ | `VerificationScreen.startBlockTimer` |
| Login OR register with phone/country/code | ✅ | `AuthProvider.loginWithPhone`, `registerAccount` |
| Registration wizard → single `POST /auth/register` | ✅ | `RegisterFormWidget` |
| `accept_terms: true` + terms/privacy links | ✅ | `RegisterTermsWidget` |
| Photo after register (optional) | ✅ | `AuthProvider.uploadProfilePhoto` |
| No SMS fallback | ✅ | `WhatsAppAuthGate`, `VerificationMessageWidget` |
| No social login | ✅ | Not exposed in UI |
| `X-Device-Id` on all requests | ✅ | `ApiClient`, `ClientRequestHeaders` |
| Secure storage + indefinite session | ✅ | `AuthSessionStorage`, `AppProductConfig.auth` |
| Change phone OTP flow | ✅ | `ChangePhoneScreen`, `VerificationScreen` |
| Change number confirm dialog | ✅ | `ChangeNumberFooterWidget` + `ui_messages.change_number_confirm` |
| OTP help footer | ✅ | `OtpHelpFooterWidget` + `ui_messages.whatsapp_help` |
| reCAPTCHA when enabled | 🟡 | API wired; SDK returns null until plugin added |

---

## 1. Bootstrap (app start)

```dart
final res = await dio.get('/config/auth');
final data = res.data['data'];
final auth = data['auth'];
final registration = data['registration'];
final ui = data['ui_messages']; // server-aligned error/help copy
```

### Key config fields

| Field | Use in Flutter |
|-------|----------------|
| `auth.otp_length` | OTP input boxes (6) |
| `auth.otp_ttl_minutes` / send-code `expires_in_seconds` | Code expiry countdown (180s) |
| `auth.otp_resend_cooldown_seconds` | Resend button timer (60s) |
| `auth.otp_max_resends_per_hour` | Max resends before `MAX_RESENDS` |
| `auth.otp_max_failed_attempts` | Show “X attempts left” |
| `auth.otp_block_minutes` | Lock duration (15 min) |
| `auth.session_indefinite` | No auto logout timer |
| `auth.support_email` | Help links (`soporte@youpass.app`) |
| `registration.gender_options` | Gender picker labels (es/pt/en) |
| `registration.terms_url` / `privacy_url` | Terms checkbox links |
| `registration.profile_photo_after_register` | Photo is **not** in register body |
| `ui_messages.*` | Fallback copy matching product spec |

### Gender values (API)

Send one of: `male`, `female`, `other`, `prefer_not_to_say`.  
Display labels from `registration.gender_options` (Man/Woman/Other/Prefer not to say).

---

## 2. Screen map — backend vs Flutter

| Screen / behavior | Backend | Flutter |
|-------------------|---------|---------|
| Logo, title “WELCOME BACK”, gold button | — | UI only |
| Country selector (flag + dial code) | `GET /config/countries` | UI + local phone input |
| Phone validation messages | `parseAndValidatePhone` on every auth call | Show API `message` |
| WhatsApp check before send | `POST /auth/check-whatsapp` | Optional pre-check; send-code also blocks |
| Send OTP | `POST /auth/send-code` | Navigate to OTP screen |
| 6-box OTP UI, auto-advance | — | UI only |
| Resend countdown 60s | `POST /auth/resend-code` | Timer from `resend_available_in_seconds` |
| “Didn’t get the code?” help | `ui_messages.whatsapp_help` | `OtpHelpFooterWidget` |
| “Change number” confirm | — | UI dialog; `ui_messages.change_number_confirm` |
| Login existing user | `POST /auth/login` | After OTP if `account_exists: true` |
| New user → registration | send-code returns `purpose: "register"` | OTP first → Create Account wizard |
| 6-step registration order | Single `POST /auth/register` | Steps 1–6 are UI-only (single form today) |
| Profile photo | `POST /users/me/profile-photo` | After register (optional) |
| Social login | Not implemented | Hide / disable |
| Session persistence | JWT until logout | Secure storage |
| `X-Device-Id` header | One session per device | Stable UUID on all requests |

---

## 3. Auth flow (implemented)

### Existing user (Welcome Back)

```
Welcome Back → check-whatsapp → send-code (login)
  → OTP screen → POST /auth/login → home
```

### New user (Welcome Back)

```
Welcome Back → check-whatsapp → send-code (purpose: register)
  → OTP screen (enter 6 digits)
  → Create Account form (code stored in route args)
  → POST /auth/register → home / welcome
```

### Direct registration link

```
Create Account form → check-whatsapp → send-code (register)
  → OTP screen (with register draft)
  → POST /auth/register
```

---

## 4. Welcome Back screen

### 3.1 Load countries

```http
GET /config/countries
```

Use each item’s `code`, `dial_code`, `flag_emoji`, `phone_hint`, `default_language` for the selector.

### 3.2 Validate phone (client-side optional)

Backend always validates. Recommended: disable “Continue” until minimum digits entered; final validation on API.

### 3.3 Check WhatsApp (recommended before send)

```http
POST /auth/check-whatsapp
Content-Type: application/json

{
  "phone": "912345678",
  "country_code": "CL"
}
```

| `whatsapp_available` | Flutter action |
|----------------------|----------------|
| `true` | Enable Continue / proceed to send-code |
| `false` | Show `message`; **do not** offer SMS |

### 3.4 Send verification code

```http
POST /auth/send-code
Content-Type: application/json
X-Device-Id: <stable-uuid>

{
  "phone": "912345678",
  "country_code": "CL",
  "purpose": "login"
}
```

**Success response (fields to persist for OTP screen):**

```json
{
  "phone": "+56912345678",
  "phone_display": "+56 9 1234 5678",
  "purpose": "login",
  "account_exists": true,
  "channel": "whatsapp",
  "otp_length": 6,
  "expires_in_seconds": 180,
  "resend_available_in_seconds": 60,
  "max_resends_per_hour": 5,
  "max_failed_attempts": 3,
  "block_minutes": 15,
  "whatsapp_available": true
}
```

**New user (no account yet):**

```json
{
  "purpose": "register",
  "account_exists": false
}
```

Flutter: store `phone`, `country_code`, `purpose`, and navigate to OTP screen. Do **not** call login until you know `account_exists: true`.

### 3.5 Error mapping — Welcome Back

| Error code | HTTP | Message (EN) | Flutter |
|------------|------|--------------|---------|
| `PHONE_INVALID` | 400 | `Please enter a valid number` or `Check your number format` | Inline under input |
| `PHONE_UNSUPPORTED_COUNTRY` | 400 | `YouPass does not operate in this country yet` | Inline / dialog |
| `WHATSAPP_NOT_AVAILABLE` | 422 | Localized WhatsApp message + support email | Block flow |
| `BLOCKED` | 429 | `Too many attempts. Wait X minutes.` | Disable input; show timer from `retry_after_seconds` |
| `USER_EXISTS` | 409 | Only if `purpose: "register"` on send | Rare on login flow |

---

## 5. OTP verification screen

### UI behavior (Flutter)

- 6 digit boxes; move focus on input
- Countdown: **3:00** from `expires_in_seconds` (180)
- Resend button disabled for **60s** (`resend_available_in_seconds`)
- Show masked phone: use `phone_display` from send-code
- Subtitle copy: *“Enter the 6-digit code we sent to your WhatsApp”* (UI string)
- Help footer: `ui_messages.whatsapp_help`

### Resend code

```http
POST /auth/resend-code
```

Same body as send-code. On success, reset OTP expiry timer from new `expires_in_seconds`.

| Error code | Message | Flutter |
|------------|---------|---------|
| `RESEND_COOLDOWN` | `Resend code in N second(s)` | Use `retry_after_seconds` for button |
| `MAX_RESENDS` | `You have reached the maximum resends. Wait X minutes.` | Disable resend; show wait |
| `CODE_EXPIRED` | (on verify/login/register) `The code expired. Request a new one.` | Prompt resend |

### After OTP entry — branch by `purpose`

**Existing user (`purpose: "login"`, `account_exists: true`):**

```http
POST /auth/login
X-Device-Id: <stable-uuid>

{
  "phone": "912345678",
  "country_code": "CL",
  "code": "123456"
}
```

**New user (`purpose: "register"`):**

Do **not** call `/auth/login`. Navigate to **Create Account** with the OTP code in route state. Submit `POST /auth/register` when the wizard completes.

### Wrong code / lockout

Show remaining attempts from `details.remaining_attempts`. On `BLOCKED`, disable OTP input until `retry_after_seconds` elapses.

---

## 6. Create Account screen

Backend accepts **one** register request. The 6 steps are a Flutter UX split; collect all fields then submit.

| Step | Field | API key | Required |
|------|-------|---------|----------|
| 1 | Full name | `full_name` | Yes |
| 2 | RUT / passport | `rut_or_passport` | Yes |
| 3 | Date of birth | `birthdate` (`YYYY-MM-DD`) | Yes, 18+ |
| 4 | Gender | `gender` | Yes |
| 5 | Phone + country | Already from Welcome Back | Yes |
| 6 | Email + terms | `email`, `accept_terms: true` | Yes |
| — | Instagram | `instagram_username` | Optional (strip `@`) |
| — | Language | `preferred_language` | Optional; default = country `default_language` |
| — | OTP code | `code` | Yes (from OTP screen) |
| After | Profile photo | `POST /users/me/profile-photo` | Optional |

### Submit registration

```http
POST /auth/register
X-Device-Id: <stable-uuid>

{
  "phone": "912345678",
  "country_code": "CL",
  "code": "123456",
  "full_name": "Jane Doe",
  "rut_or_passport": "12345678-9",
  "email": "jane@example.com",
  "birthdate": "1990-05-15",
  "gender": "female",
  "instagram_username": "jane",
  "preferred_language": "es",
  "accept_terms": true
}
```

### Registration errors

| Code | Flutter |
|------|---------|
| `UNDERAGE` | Block submit; show API message |
| `USER_EXISTS` | Redirect to Welcome Back / login |
| `INVALID_CODE` / `CODE_EXPIRED` | Send back to OTP or resend |
| `INVALID_BIRTHDATE` | Fix date picker format |

---

## 7. Session & logout

- **Indefinite session:** `expires_at: null`, `session_indefinite: true`
- Do not force re-auth on a timer
- Clear token on `POST /auth/logout` or HTTP `401` with `SESSION_INVALID`
- Always send **`X-Device-Id`** (same UUID for the device lifetime)

---

## 8. Phone change (settings)

```http
POST /auth/change-phone/request   (Bearer)
{ "new_phone": "...", "new_country_code": "MX" }

POST /auth/change-phone/verify    (Bearer)
{ "new_phone": "...", "new_country_code": "MX", "code": "123456" }
```

OTP goes to the **new** number only.

---

## 9. reCAPTCHA (when enabled)

If `security.recaptcha_enabled: true`, include on send-code, resend-code, login, register:

```json
{ "recaptcha_token": "<token from Flutter plugin>" }
```

---

## 10. Key Flutter files

```
lib/core/config/
  auth_product_config_model.dart   # auth, registration, ui_messages
  app_product_config.dart
  otp_policy.dart

lib/features/auth/presentation/
  screens/login_screen.dart
  screens/verification_screen.dart
  screens/register_screen.dart
  widgets/phone_login_form_widget.dart
  widgets/register_form_widget.dart
  widgets/gender_picker_sheet.dart
  widgets/register_terms_widget.dart
  widgets/otp_help_footer_widget.dart
  widgets/change_number_footer_widget.dart
  providers/auth_provider.dart
  utils/whatsapp_auth_gate.dart

lib/features/auth/data/services/auth_api_service.dart
```

---

## 11. Full error code reference

| Code | Screen | Typical message |
|------|--------|-----------------|
| `PHONE_INVALID` | Welcome Back | Please enter a valid number |
| `PHONE_UNSUPPORTED_COUNTRY` | Welcome Back | YouPass does not operate in this country yet |
| `WHATSAPP_NOT_AVAILABLE` | Welcome Back | Cannot receive WhatsApp |
| `RESEND_COOLDOWN` | OTP | Resend code in N seconds |
| `MAX_RESENDS` | OTP | Maximum resends reached |
| `INVALID_CODE` | OTP | Incorrect code (+ remaining_attempts) |
| `CODE_EXPIRED` | OTP / Register | The code expired |
| `BLOCKED` | Any | Too many attempts |
| `USER_NOT_FOUND` | Login | No account found |
| `USER_EXISTS` | Register | Account already exists |
| `UNDERAGE` | Register | Over 18 required |
| `SESSION_INVALID` | App | Force re-login |
| `OTP_DELIVERY_FAILED` | Send | WhatsApp delivery failed |

---

*Last updated: June 2026 — aligned with Welcome Back / OTP / Create Account product spec*
