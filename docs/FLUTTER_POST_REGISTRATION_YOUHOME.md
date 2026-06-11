# Flutter — Post-Registration & YouHome Flow

**Base URL:** `https://youpass-backend.vercel.app/api/v1`

This doc defines the **inviolable rule** after registration: **CREATE ACCOUNT → Welcome (2s) → YouHome directly**. No hamburger menu, no My Profile, no onboarding, no permission prompts.

**Related:** `FLUTTER_AUTH_REGISTRATION_API.md`, `FLUTTER_PRODUCT_DECISIONS_API.md`, `FLUTTER_MULTI_COUNTRY_LATAM_API.md`

---

## Flutter implementation status

| Checklist item | Status | Location |
|----------------|--------|----------|
| `GET /config/auth` → `post_registration` policy | ✅ | `PostRegistrationConfigModel`, `AppProductConfig.postRegistration` |
| `POST /auth/register` → parse `navigation` + `welcome` | ✅ | `AuthSessionModel` |
| Welcome screen 2s using API copy | ✅ | `WelcomeScreen`, `PostRegistrationFlowHelper` |
| Preload `GET /home/initial-feed?context=post_register` during Welcome | ✅ | `WelcomeScreen`, `HomeProvider.preloadPostRegistrationFeed` |
| YouHome: `greeting.message`, `featured_events` | ✅ | `HomeGreetingWidget`, `HomeFeedWidget` |
| Party Mode banner OFF after registration | ✅ | `HomeTopBarWidget.showPartyModeBanner`, feed `party_mode.banner_visible` |
| Do NOT open drawer / Profile / onboarding / permissions | ✅ | `AuthNavigation`, `PostRegistrationNavigationEntity` asserts |
| `linked_invitations > 0` → highlight on Home | ✅ | `PendingInvitationHighlightWidget` |
| `POST /analytics/event/registration-completed` | ✅ | `AnalyticsApiService`, `HomeProvider.trackRegistrationCompletedIfNeeded` |
| Returning users with valid token → Home directly | ✅ | `SplashScreen` (no Welcome) |
| Optional photo/Instagram only from Profile later | ✅ | Not collected post-register |

---

## 1. The rule (non-negotiable)

```
User taps CREATE ACCOUNT
  → POST /auth/register
  → Store token + show Welcome screen (2 seconds)
  → GET /home/initial-feed?context=post_register
  → YouHome (events, greeting, Party Mode banner OFF)
```

### What NEVER happens after register

| Forbidden | Flutter must NOT |
|-----------|-------------------|
| Open hamburger menu | Auto-open drawer |
| Navigate to My Profile | Route to `/profile` |
| Onboarding carousel | Show tutorial screens |
| Permission prompts | Request camera/notifications yet |
| Profile photo / Instagram | Collect optional fields now |

Optional profile data is handled **later** via the “Complete your Profile” banner in My Profile (when the user opens it themselves).

Load rules on startup from **`GET /config/auth`** → `post_registration` block.

---

## 2. Bootstrap — post-registration policy

```dart
final config = await dio.get('/config/auth');
final postReg = config.data['data']['post_registration'];
```

```json
{
  "navigate_to": "you_home",
  "show_welcome_screen": true,
  "welcome_duration_seconds": 2,
  "open_hamburger_menu": false,
  "open_profile": false,
  "show_onboarding": false,
  "request_permissions": false,
  "show_party_mode_banner": false,
  "profile_completion_later": true,
  "preload_endpoint": "/home/initial-feed",
  "analytics_endpoint": "/analytics/event/registration-completed"
}
```

Use these flags — do not hardcode navigation behavior.

---

## 3. Step 1 — Register

```http
POST /auth/register
X-Device-Id: <stable-uuid>
```

### Success response (navigation-critical fields)

```json
{
  "access_token": "eyJ...",
  "is_new_user": true,
  "linked_invitations": 0,
  "welcome": {
    "title": "Welcome to YouPass, Jane!",
    "subtitle": "Your access to the best events starts here",
    "duration_seconds": 2
  },
  "navigation": {
    "flow": "welcome_then_home",
    "navigate_to": "you_home",
    "show_welcome_screen": true,
    "open_hamburger_menu": false,
    "open_profile": false,
    "show_party_mode_banner": false,
    "preload_endpoint": "/home/initial-feed"
  }
}
```

### Flutter immediately after success

1. Save `access_token` to secure storage
2. Set `Authorization: Bearer` on Dio
3. **Preload** home feed in parallel during Welcome
4. Show **Welcome** screen for `welcome.duration_seconds`
5. Navigate to **YouHome** — not Profile, not drawer

---

## 4. Step 2 — Welcome screen (2 seconds)

While showing Welcome, **preload** home data so YouHome appears in <3s total.

**UI:** Fade in/out overlay. Copy from `welcome.title` / `welcome.subtitle`.

---

## 5. Step 3 — YouHome initial feed

```http
GET /home/initial-feed?context=post_register
Authorization: Bearer <token>
```

### YouHome UI rules

| Element | Source | Rule |
|---------|--------|------|
| Personalized greeting | `greeting.message` | Show on Home header |
| Featured events | `featured_events` | Primary content |
| Browse chips | `categories` | From API |
| Party Mode banner | `party_mode.banner_visible` | **OFF** after registration |
| Hamburger | — | Closed by default |
| Profile tab | — | Do not auto-navigate |

---

## 6. Special cases

### From invitation (`linked_invitations > 0`)

After Welcome → YouHome with **highlighted pending invitation card** (not redirect to Profile).

### Returning session (indefinite)

If valid token exists on app open → **straight to YouHome**, no re-login, no Welcome screen.

---

## 7. Analytics — registration completed

Fire **after** user lands on YouHome (when Welcome ends and Home is shown).

```http
POST /analytics/event/registration-completed
Authorization: Bearer <token>

{
  "source": "organic",
  "time_to_home_ms": 2400,
  "client_timestamp": "2026-06-03T12:00:00.000Z"
}
```

---

## 8. Key Flutter files

```
lib/core/config/auth_product_config_model.dart   # post_registration config
lib/features/auth/data/models/auth_session_model.dart
lib/features/auth/presentation/utils/post_registration_flow_helper.dart
lib/features/auth/presentation/utils/auth_navigation.dart
lib/features/auth/presentation/screens/welcome_screen.dart
lib/features/home/presentation/providers/home_provider.dart
lib/features/home/presentation/screens/home_screen.dart
lib/features/home/presentation/widgets/pending_invitation_highlight_widget.dart
lib/core/network/analytics_api_service.dart
```

---

## 9. Navigation flow (implemented)

```
Register success (is_new_user)
  → AuthNavigation.completeOneTimeLogin(purpose: register)
  → WelcomeScreen (preload feed in parallel)
  → HomeScreen (feed already loaded, analytics fired)

Login success
  → HomeScreen directly (no Welcome)

App cold start + valid token
  → SplashScreen → HomeScreen (no Welcome)
```

---

*Last updated: June 2026*
