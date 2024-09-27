class ApiEndpoints {
  static const baseApiUrl = "https://trustlink-backend.vercel.app/";

  //-------------------- AUTH --------------------//
  static const login = 'auth/login';
  static const verifyEmail = '/auth/verify-email';
  static const register = 'auth/register';
  static const resetPassword = 'auth/reset-password';
  static const completeReset = 'auth/complete-reset';
  static const resendOTP = 'auth/resend-otp';
  static const changePassword = 'auth/change-password';

  static const userDetails = 'api/me';

  //-------------------- ACCOUNT --------------------//
  // static const allBanks = "api/account";
  // static const bidPrice = "api/account";
  // static const acceptBid = "rides/accept-decline-bid";

  //-------------------- WALLET --------------------//
  static const createWallet = "api/wallet";
  static const requestRide = "api/wallet";

  //-------------------- WALLET --------------------//
  static const getWalletBalance = "users/wallet/balance";
  static const fundWallet = "wallet/fund-wallet";
  static const verifyPayment = "wallet/verifyPayment";
  static const payTrip = "wallet/trip-pay";

  // ASK SAMUEL THE MEANING OF THIS API
  static const rateDriver = "rides/rides/review";

// ASK SAMUEL HOW TO DIFFERENTIATE BETWEEN RIDER AND DRIVER.

  //-------------------- ETRIKE --------------------//
  static const fetchLocationsWithinSchool = 'etrike/locations-by-school';
  static const etrikeRideRequest = 'etrike/fetch-price';
  static const etrikeFindDrivers = 'etrike/find-ride';

  //-------------------- LOCATION --------------------//
  static const googleMapsAutoCompleteBaseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const googleMapsPlaceDetailsBaseUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static const googleMapsDirectionBaseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
}
