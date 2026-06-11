# Flutter — Events & Favorites API

**Production base URL:** `https://youpass-backend.vercel.app/api/v1`

APIs for **YouHome** — featured carousel, event list, filters (country + event type), and favorites (heart icon).

**Related:** `FLUTTER_POST_REGISTRATION_YOUHOME.md`, `FLUTTER_MULTI_COUNTRY_LATAM_API.md`

---

## Flutter implementation status

| Checklist item | Status | Location |
|----------------|--------|----------|
| `GET /home/initial-feed` | ✅ | `EventsApiService.fetchInitialFeed` |
| Parse `data.layout` (new YouHome shape) | ✅ | `HomeLayoutMapper`, `HomeInitialFeedResponseModel` |
| Legacy `carousel` + `featured_events` fallback | ✅ | Same parser |
| `layout.header.greeting` | ✅ | `HomeFeedEntity.headerGreeting` |
| `layout.main_banner.slides` → carousel | ✅ | Mapped to `carouselEvents` |
| `layout.upcoming_events.items` → list | ✅ | Mapped to `featuredEvents` |
| `layout.categories` (country + event types) | ✅ | `HomeLayoutMapper`, `EventsRepositoryImpl` |
| `layout.upcoming_events.title` | ✅ | `upcomingSectionTitle` on home list header |
| `GET /events/types` | ✅ | `EventsApiService.fetchEventTypes` |
| `GET /events/featured` (category filter) | ✅ | `fetchFeaturedEvents` + `HomeProvider.selectCategory` |
| `GET /events` (See all + pagination) | ✅ | `AllEventsScreen`, `GetAllEventsUseCase` |
| `GET /events?q=` search param | ✅ | `HomeEventsQuery.searchQuery` |
| `GET /events/:id` | ✅ | `fetchEventById` |
| `GET /users/me/favorites/events` | ✅ | `fetchFavoriteEvents` |
| `POST /users/me/favorites/events/:id` (no body) | ✅ | `addFavorite` — no `Content-Type` when body empty |
| `DELETE /users/me/favorites/events/:id` | ✅ | `removeFavorite` |
| Heart toggle on home cards | ✅ | `HomeProvider.toggleFavorite` |
| `is_favorite` on event parse | ✅ | `EventModel.fromJson` |
| `date_display` on upcoming cards | ✅ | `EventModel` prefers `date_display` |
| Auth header when logged in | ✅ | `ApiClient` attaches Bearer when token present |
| Home search bar UI | 🟡 | Placeholder parsed; search on **See all** screen only |
| `POST/PATCH/DELETE /events` (admin) | — | Not in consumer app |

---

## Quick reference

| Method | Endpoint | Auth | Flutter |
|--------|----------|------|---------|
| GET | `/events/types` | — | Filter chips fallback |
| GET | `/events/featured` | Optional | Category filter refresh |
| GET | `/events` | Optional | See all / search (`q`) |
| GET | `/events/:id` | Optional | Event detail |
| GET | `/home/initial-feed` | Optional | Home bundle |
| GET | `/users/me/favorites/events` | Bearer | Favorites screen |
| POST | `/users/me/favorites/events/:eventId` | Bearer | Add favorite |
| DELETE | `/users/me/favorites/events/:eventId` | Bearer | Remove favorite |

Send **`Authorization: Bearer <access_token>`** when logged in so responses include **`is_favorite`**.

---

## Home initial feed — layout mapping

| UI section | API field | Flutter field |
|------------|-----------|---------------|
| Header greeting | `layout.header.greeting` | `headerGreeting` / `resolveGreetingMessage()` |
| 📍 Country + type chips | `layout.categories` | `HomeFeedEntity.categories` |
| Main banner carousel | `layout.main_banner.slides` | `carouselEvents` |
| Upcoming list title | `layout.upcoming_events.title` | `upcomingSectionTitle` |
| Upcoming event cards | `layout.upcoming_events.items` | `featuredEvents` |
| Search placeholder | `layout.search.placeholder` | `searchPlaceholder` (parsed, UI TBD) |
| Party mode | `party_mode.banner_visible` | `HomeProvider.showPartyModeBanner` |

Legacy top-level fields still work:

- `carousel` → carousel
- `featured_events` → list section
- `event_types` / `categories` → chips
- `greeting.message` → greeting

Query params supported on initial feed:

- `country_code`
- `event_type`
- `context=post_register`

---

## Category filter flow

1. Home loads via `GET /home/initial-feed`
2. User taps chip → `HomeProvider.selectCategory`
3. Refetch via `GET /events/featured?country_code=CL&event_type=concerts`
4. Updates carousel + list in place

Country chip from layout uses `country:CL` id with `country_code=CL` on featured requests.

---

## Favorites

```dart
// Add — POST with Authorization only (no JSON body)
await eventsApiService.addFavorite(eventId);

// Remove
await eventsApiService.removeFavorite(eventId);
```

Optimistic UI in `HomeProvider.toggleFavorite` with rollback on API error.

---

## See all events

**`GET /events?country_code=CL&page=1&limit=20`**

Opened from home **See all >** → `AllEventsScreen`.

Supports client-side search filter; API search via `HomeEventsQuery.searchQuery` → `q` param ready for server-side search wiring.

---

## Event fields parsed

| Field | Flutter |
|-------|---------|
| `date_display` | `EventEntity.dateLabel` (preferred for cards) |
| `date_time_display` | `EventEntity.dateTimeLabel` |
| `location_display` | `EventEntity.locationLabel` |
| `is_favorite` | `EventEntity.isFavorite` |
| `event_type.slug` | `EventEntity.eventTypeSlug` |
| `country_code` | `EventEntity.countryCode` |

Event detail `purchase` meta → see VIP venue integration.

---

## Key Flutter files

```
lib/features/events/data/
  services/events_api_service.dart
  models/home_initial_feed_response_model.dart
  models/event_model.dart
  mappers/home_layout_mapper.dart
  repositories/events_repository_impl.dart

lib/features/home/
  domain/entities/home_feed_entity.dart
  presentation/providers/home_provider.dart
  presentation/widgets/home_feed_widget.dart
  presentation/widgets/home_events_section_widget.dart
  presentation/widgets/event_list_card_widget.dart

lib/core/network/api_client.dart   # POST without body for favorites
```

---

## Error codes (handled via ApiException)

| Code | When |
|------|------|
| `EVENT_NOT_FOUND` | Invalid event id |
| `FAVORITE_NOT_FOUND` | Remove when not favorited |
| `INVALID_EVENT_TYPE` | Bad `event_type` slug |
| `INVALID_COUNTRY` | Bad `country_code` |
| `SESSION_INVALID` | Expired token on protected route |

---

## Not yet in Flutter UI

- Home **search bar** + filters sheet (`layout.search`) — placeholder parsed only
- Admin **POST/PATCH/DELETE /events**
- Banner dot indicators from `layout.main_banner.indicators`

---

*Last updated: June 2026*
