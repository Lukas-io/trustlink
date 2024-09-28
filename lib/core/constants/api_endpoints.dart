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

  // -------------------- ACCOUNT --------------------//
  static const allBanks = "api/account";
  static const saveAccount = "api/account";
  static const updateAccount = "api/account";

  //-------------------- WALLET --------------------//
  static const createWallet = "api/wallet";
  static const getWallet = "api/wallet";
  static const updatePin = "api/wallet";
  static const withdraw = "api/withdraw";
  static const generateAccount = "api/deposit/transfer";
  static const cardDeposit = "api/deposit/card";
  static const getWalletHistory = "api/wallet/history";
  static const getHistoryById = "api/api/history/{id}";
  static const walletPay = "api/wallet/pay";
  static const generateLink = "api/generate";

  //-------------------- TRANSACTION --------------------//
  static const verifyTransaction = "api/verify-transaction/{id}";
  static const requestRefund = "api/dispute-transaction/{id}";
  static const completeRefund = "api/dispute-transaction/{id}";
  static const getRefundTransaction = "api/dispute-transaction/{id}";
  static const getTransactionById = "api/verify-transaction/{id}";
  static const getOutgoingTransaction = "api/outgoing/trans";
  static const getIngoingTransaction = "api/outgoing/trans";
  static const getTransactionHistory = "api/trans/history";
}
