import 'package:trustlink/features/auth/data/models/user_model.dart';
import 'package:trustlink/features/auth/data/models/user_token_model.dart';
import 'package:trustlink/features/home/data/models/transaction/transaction_model.dart';
import 'package:trustlink/core/resources/enums.dart';

/// Toggle to switch between mock data and live API calls.
const bool useMockData = true;

// ---------------------------------------------------------------------------
// Mock Auth — credentials and logged-in user
// ---------------------------------------------------------------------------

/// Use these credentials on the login screen when useMockData is true.
/// Any non-empty email/password combination will succeed.
final UserTokenModel mockUserToken = UserTokenModel(
  token: 'mock_access_token_trustlink_2026',
  user: UserModel(
    firstName: 'Chidinma',
    lastName: 'Okafor',
    email: 'chidinma.art@gmail.com',
    phone: '+2349012345678',
    username: 'chidinma_art',
  ),
);

// ---------------------------------------------------------------------------
// Creator Profiles (no existing model — lightweight class for mock display)
// ---------------------------------------------------------------------------

class MockCreatorProfile {
  final String name;
  final String productType;
  final String avatarUrl;
  final String bio;
  final String location;

  const MockCreatorProfile({
    required this.name,
    required this.productType,
    required this.avatarUrl,
    required this.bio,
    required this.location,
  });
}

const List<MockCreatorProfile> mockCreators = [
  MockCreatorProfile(
    name: 'Chidinma Okafor',
    productType: 'Hand-painted portraits',
    avatarUrl: 'https://i.pravatar.cc/150?img=5',
    bio: 'I turn your favourite photographs into wall-worthy oil paintings.',
    location: 'Lagos',
  ),
  MockCreatorProfile(
    name: 'Emeka Nwosu',
    productType: 'Custom sneakers',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    bio: 'One-of-one kicks designed from scratch — no two pairs are the same.',
    location: 'Abuja',
  ),
  MockCreatorProfile(
    name: 'Aisha Bello',
    productType: 'Handmade candles',
    avatarUrl: 'https://i.pravatar.cc/150?img=23',
    bio: 'Small-batch soy candles inspired by Northern Nigerian landscapes.',
    location: 'Kano',
  ),
  MockCreatorProfile(
    name: 'Folake Adeyemi',
    productType: 'Digital illustrations',
    avatarUrl: 'https://i.pravatar.cc/150?img=32',
    bio: 'Afro-futurist digital art printed on archival-grade paper.',
    location: 'Ibadan',
  ),
  MockCreatorProfile(
    name: 'Ngozi Eze',
    productType: 'Handwoven fabric',
    avatarUrl: 'https://i.pravatar.cc/150?img=44',
    bio: 'Traditional Akwete weaving adapted for modern fashion.',
    location: 'Enugu',
  ),
  MockCreatorProfile(
    name: 'Tunde Bakare',
    productType: 'Leather journals',
    avatarUrl: 'https://i.pravatar.cc/150?img=51',
    bio: 'Hand-stitched journals from locally sourced leather — built to last.',
    location: 'Port Harcourt',
  ),
  MockCreatorProfile(
    name: 'Amara Obi',
    productType: 'Beaded jewelry',
    avatarUrl: 'https://i.pravatar.cc/150?img=19',
    bio: 'Coral and brass pieces rooted in Edo craftsmanship.',
    location: 'Benin City',
  ),
];

// ---------------------------------------------------------------------------
// Escrow Transactions (uses existing TransactionModel + UserModel)
// ---------------------------------------------------------------------------

final List<TransactionModel> mockTransactions = [
  TransactionModel(
    id: 1001,
    mode: TransactionMode.kora,
    sender: UserModel(
      firstName: 'Babajide',
      lastName: 'Ogunleye',
      email: 'babajide.o@gmail.com',
      phone: '+2348031234567',
      username: 'babajide_o',
    ),
    receiver: UserModel(
      firstName: 'Chidinma',
      lastName: 'Okafor',
      email: 'chidinma.art@gmail.com',
      phone: '+2349012345678',
      username: 'chidinma_art',
    ),
    amount: 85000,
    description: 'Family portrait — oil on canvas, 24x36 inches',
    date: DateTime(2025, 11, 3, 14, 22),
    status: TransactionStatus.completed,
    type: TransactionType.credit,
  ),
  TransactionModel(
    id: 1002,
    mode: TransactionMode.kora,
    sender: UserModel(
      firstName: 'Kemi',
      lastName: 'Adegoke',
      email: 'kemi.adegoke@yahoo.com',
      phone: '+2348051234567',
      username: 'kemi_a',
    ),
    receiver: UserModel(
      firstName: 'Emeka',
      lastName: 'Nwosu',
      email: 'emeka.kicks@gmail.com',
      phone: '+2348061234567',
      username: 'emeka_kicks',
    ),
    amount: 120000,
    description: 'Custom Air Force 1 — hand-painted Lagos skyline theme',
    date: DateTime(2025, 12, 15, 9, 15),
    status: TransactionStatus.pending,
    type: TransactionType.credit,
  ),
  TransactionModel(
    id: 1003,
    mode: TransactionMode.wallet,
    sender: UserModel(
      firstName: 'Uche',
      lastName: 'Mbah',
      email: 'uche.mbah@outlook.com',
      phone: '+2348071234567',
      username: 'uche_m',
    ),
    receiver: UserModel(
      firstName: 'Aisha',
      lastName: 'Bello',
      email: 'aisha.candles@gmail.com',
      phone: '+2348081234567',
      username: 'aisha_candles',
    ),
    amount: 22500,
    description: 'Set of 6 shea butter candles — harmattan collection',
    date: DateTime(2026, 1, 8, 16, 45),
    status: TransactionStatus.completed,
    type: TransactionType.credit,
  ),
  TransactionModel(
    id: 1004,
    mode: TransactionMode.kora,
    sender: UserModel(
      firstName: 'Olumide',
      lastName: 'Fashola',
      email: 'olumide.f@gmail.com',
      phone: '+2348091234567',
      username: 'olumide_f',
    ),
    receiver: UserModel(
      firstName: 'Folake',
      lastName: 'Adeyemi',
      email: 'folake.art@gmail.com',
      phone: '+2349021234567',
      username: 'folake_art',
    ),
    amount: 45000,
    description: 'Afro-futurist digital print — framed A2',
    date: DateTime(2026, 1, 22, 11, 30),
    status: TransactionStatus.canceled,
    type: TransactionType.debit,
  ),
  TransactionModel(
    id: 1005,
    mode: TransactionMode.wallet,
    sender: UserModel(
      firstName: 'Blessing',
      lastName: 'Iroha',
      email: 'blessing.iroha@gmail.com',
      phone: '+2349031234567',
      username: 'blessing_i',
    ),
    receiver: UserModel(
      firstName: 'Ngozi',
      lastName: 'Eze',
      email: 'ngozi.weaves@gmail.com',
      phone: '+2349041234567',
      username: 'ngozi_weaves',
    ),
    amount: 175000,
    description: 'Handwoven aso-oke set — 3 pieces, custom dye',
    date: DateTime(2026, 2, 5, 8, 10),
    status: TransactionStatus.completed,
    type: TransactionType.credit,
  ),
  TransactionModel(
    id: 1006,
    mode: TransactionMode.kora,
    sender: UserModel(
      firstName: 'Chinedu',
      lastName: 'Okeke',
      email: 'chinedu.okeke@gmail.com',
      phone: '+2349051234567',
      username: 'chinedu_o',
    ),
    receiver: UserModel(
      firstName: 'Tunde',
      lastName: 'Bakare',
      email: 'tunde.leather@gmail.com',
      phone: '+2349061234567',
      username: 'tunde_leather',
    ),
    amount: 35000,
    description: 'Personalized leather journal — embossed initials, A5',
    date: DateTime(2026, 2, 18, 13, 5),
    status: TransactionStatus.pending,
    type: TransactionType.credit,
  ),
  TransactionModel(
    id: 1007,
    mode: TransactionMode.wallet,
    sender: UserModel(
      firstName: 'Damilola',
      lastName: 'Adekunle',
      email: 'damilola.a@gmail.com',
      phone: '+2349071234567',
      username: 'damilola_a',
    ),
    receiver: UserModel(
      firstName: 'Amara',
      lastName: 'Obi',
      email: 'amara.beads@gmail.com',
      phone: '+2349081234567',
      username: 'amara_beads',
    ),
    amount: 68000,
    description: 'Coral bead necklace and bracelet set — bridal edition',
    date: DateTime(2026, 3, 1, 18, 42),
    status: TransactionStatus.refunded,
    type: TransactionType.debit,
  ),
  TransactionModel(
    id: 1008,
    mode: TransactionMode.kora,
    sender: UserModel(
      firstName: 'Ifeoma',
      lastName: 'Nwankwo',
      email: 'ifeoma.n@gmail.com',
      phone: '+2349091234567',
      username: 'ifeoma_n',
    ),
    receiver: UserModel(
      firstName: 'Chidinma',
      lastName: 'Okafor',
      email: 'chidinma.art@gmail.com',
      phone: '+2349012345678',
      username: 'chidinma_art',
    ),
    amount: 250000,
    description: 'Large-format oil painting — 48x60 inches, commissioned piece',
    date: DateTime(2026, 3, 10, 10, 0),
    status: TransactionStatus.pending,
    type: TransactionType.credit,
  ),
];

// ---------------------------------------------------------------------------
// Payment Links
// ---------------------------------------------------------------------------

class MockPaymentLink {
  final String linkId;
  final String creatorName;
  final num amount;
  final String productDescription;
  final bool isActive;
  final DateTime expiryDate;

  const MockPaymentLink({
    required this.linkId,
    required this.creatorName,
    required this.amount,
    required this.productDescription,
    required this.isActive,
    required this.expiryDate,
  });
}

final List<MockPaymentLink> mockPaymentLinks = [
  MockPaymentLink(
    linkId: 'KPL-001-CDNM',
    creatorName: 'Chidinma Okafor',
    amount: 85000,
    productDescription: 'Custom portrait — oil on canvas',
    isActive: true,
    expiryDate: DateTime(2026, 6, 30),
  ),
  MockPaymentLink(
    linkId: 'KPL-002-EMKA',
    creatorName: 'Emeka Nwosu',
    amount: 95000,
    productDescription: 'Hand-painted sneakers — your design',
    isActive: true,
    expiryDate: DateTime(2026, 5, 15),
  ),
  MockPaymentLink(
    linkId: 'KPL-003-AISH',
    creatorName: 'Aisha Bello',
    amount: 15000,
    productDescription: 'Scented candle trio — gift box',
    isActive: true,
    expiryDate: DateTime(2026, 4, 20),
  ),
  MockPaymentLink(
    linkId: 'KPL-004-NGZI',
    creatorName: 'Ngozi Eze',
    amount: 140000,
    productDescription: 'Handwoven aso-oke — 2-piece set',
    isActive: false,
    expiryDate: DateTime(2025, 12, 31),
  ),
  MockPaymentLink(
    linkId: 'KPL-005-AMRA',
    creatorName: 'Amara Obi',
    amount: 52000,
    productDescription: 'Coral bead choker — custom length',
    isActive: true,
    expiryDate: DateTime(2026, 7, 10),
  ),
];

// ---------------------------------------------------------------------------
// Notifications
// ---------------------------------------------------------------------------

enum MockNotificationType {
  paymentReceived,
  deliveryConfirmed,
  disputeRaised,
  linkOpened,
}

class MockNotification {
  final MockNotificationType type;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  const MockNotification({
    required this.type,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });
}

final List<MockNotification> mockNotifications = [
  MockNotification(
    type: MockNotificationType.paymentReceived,
    message: 'Babajide Ogunleye funded the escrow for "Family portrait" — \u20A685,000',
    timestamp: DateTime(2025, 11, 3, 14, 22),
    isRead: true,
  ),
  MockNotification(
    type: MockNotificationType.deliveryConfirmed,
    message: 'Blessing Iroha confirmed delivery of "Handwoven aso-oke set"',
    timestamp: DateTime(2026, 2, 12, 9, 45),
    isRead: true,
  ),
  MockNotification(
    type: MockNotificationType.disputeRaised,
    message: 'Damilola Adekunle raised a dispute on "Coral bead necklace set" — reason: item not as described',
    timestamp: DateTime(2026, 3, 3, 17, 10),
    isRead: false,
  ),
  MockNotification(
    type: MockNotificationType.linkOpened,
    message: 'Someone opened your payment link for "Custom portrait — oil on canvas"',
    timestamp: DateTime(2026, 3, 8, 11, 30),
    isRead: false,
  ),
];
