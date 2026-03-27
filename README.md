# Trustlink — Escrow payments for Nigerian creators 🔐

Built in 14 days for KoraHACK 2.0, a pan-African hackathon by Kora.
We won. 🏆

## Overview

Trustlink solves a real problem: Nigerian creators selling physical goods
have no protection when a buyer pays and disappears — or when a seller
ships and never gets paid. Trustlink holds funds in escrow, releases them
on delivery confirmation, and handles disputes when things go sideways.

The idea made it past the first round. Then we built it. Then we stood in
front of judges and walked away with first place.

## 🎥 Demo

> [coming soon / link here]

## Features

- **Escrow flow** — buyer funds upfront, money releases when receiver
  confirms delivery with PIN
- **Kora Pay integration** — generates shareable payment links via Kora's
  API, shareable natively through the device sheet
- **Wallet** — fund via card, withdraw to bank, wallet-to-wallet transfers
- **Transaction history** — filterable list with animated insert/remove on
  filter toggle (no full rebuilds)
- **Refund requests** — sender raises dispute, receiver authorizes with PIN
- **Mock mode** — entire app runs offline, one flag to switch to live API

## Technical Stack

- **Framework**: Flutter (SDK 3.4.4+)
- **State Management**: flutter_bloc with BLoC pattern
- **Networking**: Dio + Retrofit (type-safe, code-generated API client)
- **DI**: GetIt as service locator
- **Local Storage**: shared_preferences (auth token + email)
- **Serialization**: json_serializable + code generation
- **Typography**: Instrument Sans (Regular → Bold)

## Architecture

Clean Architecture + BLoC, feature-first folder structure.

```
lib/
├── config/          # Theme, fonts, colors
├── core/            # Shared components, constants, API utilities
│   └── resources/   # DataSuccess/DataException, interceptor, performRequest
├── data/            # Mock data + toggle flag
├── features/
│   ├── auth/        # Login, register, OTP, PIN setup
│   └── home/        # Wallet, transactions, transfer, payment links
├── injection_container.dart   # GetIt wiring: Dio → Services → Repos → BLoCs
└── main.dart
```

Data flows one way: Screen → BLoC event → Repository → API/mock →
DataState → BLoC state → UI rebuild.

A few decisions worth calling out:

- **Generic BLoC states** — `AccountSuccess<T, V>` uses the event type as
  a discriminator so `buildWhen` can surgically filter which widgets
  rebuild. Unrelated state changes don't trigger unrelated rebuilds.
- **`performRequest<T>`** — one function wraps every API call. All HTTP
  status codes, DioException types, and error toasts handled in one place.
  Nothing repeated across the codebase.
- **Mock at the repository layer** — BLoCs and screens never know if data
  is real or mocked. Clean boundary, no leaking.

## Installation

```bash
git clone https://github.com/Trustlink-ng/trustlink-mobile.git
cd trustlink-mobile

flutter pub get

# Required — Retrofit + json_serializable generate .g.dart files
dart run build_runner build --delete-conflicting-outputs

flutter run
```

Requirements: Flutter 3.4.4+, Dart 3.x+

To switch to the live API: set `const bool useMockData = false` in
`lib/data/mock_data.dart` and rebuild.

## Gotchas

- **Run build_runner first** — the `.g.dart` files aren't committed. Skip
  this and you get import errors on every API service.
- **Mock is on by default** — any credentials work in mock mode. If
  network requests aren't hitting, check `useMockData`.
- **Backend cold starts** — the API lives on Vercel
  (`trustlink-backend.vercel.app`). First request after inactivity may
  time out. Just retry.

## Known Limitations

Hackathon code is honest code. Here's what didn't make the cut:

- `ChangePinScreen` exists in navigation but has no UI — empty column
- `UpdatePin` has old/new PIN swapped in the request body
- File proof in refund disputes is captured but never sent
- No token refresh — expired tokens require manual re-login
- No input validation beyond empty-string checks
- Hardcoded test credentials still pre-filled on the login screen
- `HydratedBloc` is imported and unused

## Possible Improvements

- Fix the PIN swap — one line, high impact
- Token refresh with Dio's `QueuedInterceptor` for seamless re-auth
- `GoRouter` or named routes — current push/replace doesn't scale
- Pull-to-refresh on wallet and transactions
- Offline caching for instant balance display
- Delivery tracking via Nigerian courier APIs (GIG, Kwik, Sendbox)
- Push notifications for payment events and dispute updates

## Team

4-person team — 2 backend engineers, 1 frontend web developer, 1 mobile
developer (me). I built the entire Flutter app solo across the 14-day
sprint.

---

Built for [KoraHACK 2.0](https://www.korahq.com/hackathon2024) —
*Redesigning Payments* — sponsored by Kora, a pan-African payment gateway.