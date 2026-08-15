# Flutter — Multi-Country LATAM API Integration

**Base URL:** `https://youpass-backend-two.vercel.app/api/v1`  
**Deployed:** production (June 2026)

See `BACKEND_MULTI_COUNTRY_LATAM_HANDOFF.md` for backend requirements.

This doc lists **Flutter integration** after the LATAM backend update.

---

## Summary — change or not?

| Area | Change required? |
|------|------------------|
| Auth OTP (`send-code`, `login`, `register`) | **No** — same APIs |
| VIP venue (lock, tables, checkout mock) | **No** — same APIs |
| Guest ticket assign / resend | **No** |
| Country picker / config | **Yes** — parse new fields |
| Home browse chips | **Yes** — use `/config/categories` or initial-feed `categories` |
| Currency display | **Yes** — from API, not hardcoded CLP |
| Payment gateway (Klap vs Stripe) | **Yes** — read from API; UI when mock off |
| Event dates | **Recommended** — use API display fields |
| Profile language | **Optional** — `preferred_language` |
| Portuguese UI (Brazil) | **Yes** — when `defaultLanguage` / `pt` |

---

*Full integration checklist and API examples: see repository implementation in `lib/core/network/` and `lib/core/network/models/`.*
