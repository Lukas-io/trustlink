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

<details>
  <summary><h2>📱 ▼ App Screenshots</h2></summary>
  <br>

  <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px;">
    <img src="https://github.com/user-attachments/assets/ca1ac337-4597-49a6-8dec-00c6520ffbd9" alt="Screen 1" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/e23fcb53-aa42-4272-b447-8f5358b8b7e5" alt="Screen 2" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/a2a812aa-9608-46b8-a745-17d2d6a74450" alt="Screen 3" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/5f79f09c-d1de-43c2-8745-36a8099791e2" alt="Screen 4" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/1ab3c16c-6f3c-4441-aeef-2bc8d656e8a9" alt="Screen 5" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/f91a7ad0-b10b-4bee-adb2-0ad31fa8aba1" alt="Screen 6" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/120a99c8-3616-4006-8df7-e94c14df8357" alt="Screen 7" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/bffcbbde-42a5-41b2-b7b0-7b79f4dff351" alt="Screen 8" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/d94d8fae-1992-4919-9bb6-5c0ccd1f71a2" alt="Screen 9" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/7f95f871-5605-4678-a04c-630c8bf49f48" alt="Screen 10" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/94642599-51c2-4a6b-9e62-a8a2123afe95" alt="Screen 11" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/324d0a18-3fc5-4103-bb6e-52fbee37a5f0" alt="Screen 12" loading="lazy" style="width: 100%; border-radius: 8px;" />
    <img src="https://github.com/user-attachments/assets/81f214d5-36ff-4bd7-a355-bac191399804" alt="Screen 13" loading="lazy" style="width: 100%; border-radius: 8px;" />
  </div>

</details>



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

## 📌 Note

This is a personal fork of the team repository from the KoraHACK 2.0
build. The original repo is private — this fork exists for portfolio
purposes.

---

Built for [KoraHACK 2.0](https://www.korahq.com/hackathon2024) —
*Redesigning Payments* — sponsored by Kora, a pan-African payment gateway.
