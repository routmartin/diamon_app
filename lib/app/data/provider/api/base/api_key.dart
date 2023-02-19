class AppApiKey {
  static const String baseUrl = "http://159.138.110.155:3002/client/";
  static const String login = "auth/login";
  static const String logout = "auth/logout";
  static const String regenerateToken = "auth/regenerate-token";
  static const String profile = "account/profile";
  static const String saleOrder = "dashboard/sale-order";
  static const String buyBack = "dashboard/buy-back";
  static const String request = "request-approval/request";
  static const String approveRequest = "request-approval/approve/";
  static const String rejectRequest = "request-approval/reject/";
  static const String history = "request-approval/history";
  static const String notifications = "notification/list";
  static const String totalAr = "account-receivable/total";
  static const String arList = "account-receivable/list";
  static const String arPreview = "account-receivable/detail/";
  static const String cancelToken = "cancelToken";
}
