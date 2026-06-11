# Flutter — Product Decisions API Guide

**Base URL:** `https://youpass-backend.vercel.app/api/v1`  
**Auth channel:** WhatsApp Business **only** (no SMS)

See backend doc for full API shapes. This file tracks **Flutter implementation**.

---

## Flutter implementation status

| Checklist item | Status | Location |
|----------------|--------|----------|
| `GET /config/auth` on startup | ✅ | `ConfigApiService`, `AppProductConfig` |
| WhatsApp-only (no SMS UI) | ✅ | `VerificationMessageWidget`, `OtpDeliveryMessage` |
| `check-whatsapp` before send-code | ✅ | `PhoneLoginFormWidget`, `RegisterFormWidget` |
| Show API message when no WhatsApp | ✅ | `WhatsAppAuthGate` |
| OTP length from config | ✅ | `OtpPolicy`, `OtpInputWidget` |
| Resend cooldown from API/config | ✅ | `VerificationScreen`, `OtpPolicy` |
| Code expiry timer (180s) | ✅ | `VerificationScreen` |
| Remaining attempts / block UI | ✅ | `AuthProvider`, `VerificationScreen` |
| Registration required fields | ✅ | `RegisterFormWidget` |
| Min age from config | ✅ | `RegistrationProductConfigModel` |
| Photo after register (optional) | ✅ | Profile upload API (not in register form) |
| Indefinite session | ✅ | `AppProductConfig.auth.sessionIndefinite` |
| Phone change verify + migration | ✅ | `ChangePhoneScreen`, `VerificationScreen` |
| `X-Device-Id` | ✅ | `DeviceIdService` |
| Currency/gateway from API | ✅ | LATAM integration (`CountryCodeRegistry`) |

---

## Key files

```
lib/core/config/
  auth_product_config_model.dart
  app_product_config.dart
  otp_policy.dart

lib/features/auth/presentation/utils/whatsapp_auth_gate.dart
lib/features/auth/presentation/widgets/phone_login_form_widget.dart
lib/features/auth/presentation/widgets/register_form_widget.dart
lib/features/auth/presentation/screens/verification_screen.dart
lib/features/profile/presentation/screens/change_phone_screen.dart
```

---

## Sandbox testing (Twilio)

1. Each test phone sends `join <code>` to **+1 415 523 8886** in WhatsApp
2. OTP arrives from Twilio sandbox — same Flutter APIs, no code changes

---

*Last updated: June 2026*
