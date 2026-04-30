# PROJECT CONTEXT
# Buluşalım — Community & Meetup App

## Update Rule
When told to update this file, read the actual codebase and fill all sections based on what exists in the code.
Do not ask the user to fill anything manually.
Only fill sections that can be grounded in the actual codebase or explicit decisions.
Do not invent missing details.
At the end of each session, list what changed so this file can be kept current.

---

## Stack

Flutter · Riverpod · GoRouter · Firebase (Auth, Firestore, Storage, FCM) · shared_preferences · flutter_secure_storage · Google Mobile Ads

---

## Firebase Services

| Service | Status |
|---|---|
| Auth | Active — email/password + Google Sign-In |
| Apple Sign-In | Pending (required for App Store) |
| Firestore | Active — main database, real-time reads |
| Storage | Active — profile and event images |
| FCM | Active — event invites, community notifications |
| Analytics | Active |
| Crashlytics | Active |
| Cloud Functions | Not active (will be added if needed) |

---

## Firestore Collection Structure

```
users/{uid}
  displayName, photoUrl, bio, hobbies[], location (GeoPoint), createdAt

communities/{communityId}
  name, description, category, coverImageUrl, ownerId,
  memberCount, isPrivate, createdAt

communities/{communityId}/members/{uid}
  role: 'owner' | 'moderator' | 'member'
  joinedAt

communities/{communityId}/joinRequests/{uid}  ← only for private communities
  status: 'pending' | 'approved' | 'rejected'
  requestedAt

events/{eventId}
  title, description, communityId (nullable), organizerId,
  coverImageUrl, location (GeoPoint), address,
  startDate, endDate, capacity (nullable),
  attendeeCount, isOnline, tags[], createdAt

events/{eventId}/attendees/{uid}
  status: 'going' | 'interested' | 'not_going'
  joinedAt
```

---

## App Flow

```
splash
├── onboarding (first launch)
└── auth → login / register → profile setup (hobbies, location)
└── main shell
    ├── home         (nearby events, suggested communities)
    ├── explore      (category and filter based search)
    ├── create       (new event or community)
    ├── notifications
    └── profile

Standalone routes:
  community_detail · event_detail · event_attendees ·
  community_members · settings · paywall
```

---

## Product Rules

Only treat Product Rules and Technical Rules as fixed if they were explicitly decided for this project.
If the codebase or user instruction conflicts, follow the real implementation or latest decision.

### Community
- Public community: any user can join instantly — no approval needed
- Private community: join triggers a request → owner/moderator must approve
- Owner cannot leave — must transfer ownership or delete the community
- Community deletion cascades: all events under the community are soft-deleted
- memberCount must always reflect the actual member subcollection count — updated via transaction

### Event
- Any authenticated user can create a standalone event (not tied to a community)
- Community events can only be created by owner or moderator of that community
- RSVP statuses: `going` / `interested` / `not_going`
- A user can change RSVP status but cannot RSVP twice — duplicate check required before write
- If capacity is set, `going` count must not exceed it — enforce in transaction
- attendeeCount reflects `going` status only — updated via transaction
- Event deletion: soft delete only — do not remove attendee subcollection immediately

### Permissions
| Action | Who can do it |
|---|---|
| Edit community | owner, moderator |
| Delete community | owner only |
| Remove member | owner, moderator |
| Approve join request | owner, moderator |
| Create community event | owner, moderator |
| Edit event | organizer only |
| Delete event | organizer, community owner |

---

## Technical Rules

- **Counters**: memberCount and attendeeCount must be updated via Firestore transaction or batched write — never a plain document write
- **Duplicate-action safety**: always check existing state before writing (join, RSVP, follow) — use transaction
- **Soft delete**: communities and events are soft-deleted (`isDeleted: true`) — hard delete only via admin/Cloud Function
- **Pagination**: default page size is 20 for all list screens — use `startAfterDocument`
- **Firestore indexes**: when a query uses multiple fields or `orderBy`, state which composite index is required
- **Image upload**: compress images before upload (max 800px on longest side, quality 85) — validate max 5MB before compression
- **Geo queries**: use geohash-based queries (geoflutterfire or manual geohash) — do not use raw GeoPoint range queries

---

## Monetization

Google Mobile Ads integrated. Paywall screen exists.
Premium features: private community creation, unlimited events, featured profile (TBD)

---

## Implementation Snapshot

> This section is maintained by the agent. Run "update project context" at the end of a session to refresh.

### Existing Feature Folders
- `core/errors/`: sealed `Failure` class + `firebaseExceptionMapper`
- `core/firebase/`: `FirestorePaths`, `StoragePaths`, `AppLogger`, `FcmService`, `AnalyticsService`, `CrashlyticsService`
- `core/router/`: GoRouter with auth-state-driven redirect + `_AuthChangeNotifier`
- `features/auth/domain/repositories/`: `AuthRepository` interface (email, Google, signOut)
- `features/auth/data/repositories/`: `AuthRepositoryImpl` (Firebase Auth + GoogleSignIn v7.2)
- `features/auth/presentation/providers/`: `authProvider` (AsyncNotifier), `authStateChangesProvider`, `isProfileCompleteProvider`
- `features/auth/presentation/pages/`: `AuthPage` (login/register toggle, Google Sign-In, form validation)
- `features/profile/data/models/`: `AppUser` (Freezed)
- `features/profile/data/repositories/`: `UserRepositoryImpl`
- `features/profile/domain/repositories/`: `UserRepository` interface
- `features/profile/presentation/providers/`: `profileSetupProvider` (AsyncNotifier)
- `features/profile/presentation/pages/`: `ProfileSetupPage` (name + bio + hobby chips), `ProfilePage` (sign-out)

### Implemented
- App foundation + Material 3 theme
- GoRouter + Riverpod routing with **auth-state-driven redirect** (refreshListenable)
- Firebase Core initialised in main.dart with correct startup chain
- Auth repository layer (email/password + Google Sign-In via google_sign_in v7.2)
- User repository layer (interface + Firebase impl with withConverter)
- AppUser Freezed model
- Sealed Failure hierarchy with FirebaseException mapper
- Firestore + Storage path constants (FirestorePaths, StoragePaths)
- AppLogger (logging package wrapper)
- CrashlyticsService (Flutter + Dart error hooks, disabled in debug)
- AnalyticsService (collection enabled, GoRouter observer ready)
- FcmService skeleton (background handler, Android channel, permission request, foreground listener)
- flutter_local_notifications v21 integrated (named params)
- **Android Build Fixes**: Fixed Kotlin Gradle plugin version mismatch (updated to 2.1.0 in settings.gradle.kts), added missing `INTERNET` and `ACCESS_NETWORK_STATE` permissions, and added required AdMob `APPLICATION_ID` metadata to `AndroidManifest.xml`.
- **Startup Robustness**: Wrapped `GoogleSignIn.instance.initialize()` and `FcmService.init()` in try-catch blocks in `main.dart` with improved logging to prevent startup crashes and aid debugging.
- **Auth UI**: Login/Register form with validation, Google Sign-In button, forgot password
- **Profile Setup UI**: Display name (required), bio (optional), hobby chip selector (12 Turkish hobbies)
- **Sign-out**: Profile page with sign-out button (clears Firebase + Google session)
- **Route protection**: Unauthenticated → /auth, post-login → /profile-setup or /home based on Firestore profile
- **Community Flow**: `Community` model, `CommunityRepository` (with transaction-based join/leave), `ExplorePage` feed, `CreateCommunityPage`, and `CommunityDetailPage` with safe join logic implemented.

### WIP
- Full FCM notification tap → GoRouter navigation wiring
- Profile edit page (post-setup changes)
- Event CRUD

### Blocked
- None

### Known Bugs
- None

### Pending Firebase Console Tasks
- Enable Email/Password auth provider in Firebase Console → Authentication → Sign-in method
- Enable Google Sign-In provider (add SHA-1 fingerprint for Android)
- Add Apple Sign-In provider (requires Apple Developer account)
- Create Firestore database in production mode (region: eur3 or nam5 — TBD)
- Deploy Firestore Security Rules (deny-all baseline first)
- Activate Cloud Storage bucket
- Enable Firebase Analytics (already in SDK)
- Enable Crashlytics in Firebase Console
- Add FCM APNs certificate / key for iOS in Firebase Console → Cloud Messaging (Requires Apple Developer Account - PENDING)
- Add Android native notification icon at `android/app/src/main/res/drawable/ic_notification.png`

---

## Open Decisions

> Decisions not yet made. Agent must not assume these — ask or flag when relevant.

- Soft delete retention policy (how long before hard delete runs)
- Geo query radius defaults (home feed nearby distance)
- Premium feature final list
- Community categories (fixed list or user-defined)
- Notification types and triggers (full list TBD)
