abstract final class StaffApiEndpoints {
  static const lookup = '/staff-auth/lookup';
  static const sendCode = '/staff-auth/send-code';
  static const resendCode = '/staff-auth/resend-code';
  static const login = '/staff-auth/login';
  static const logout = '/staff-auth/logout';
  static const me = '/staff-auth/me';
  static const scanEntry = '/staff/scan/entry';
  static const scanProduct = '/staff/scan/product';
  static const scanRecent = '/staff/scan/recent';
  static const supervisorValidatePin = '/staff/supervisor/validate-pin';
  static const supervisorSearchEntries = '/staff/supervisor/entries/search';
  static const supervisorSearchDrinks = '/staff/supervisor/drinks/search';
  static const supervisorDrinkActionHistory = '/staff/supervisor/drinks/action-history';
  static String supervisorDrinkDetail(String redemptionId) =>
      '/staff/supervisor/drinks/$redemptionId';
  static String supervisorDrinkCancellation(String redemptionId) =>
      '/staff/supervisor/drinks/$redemptionId/cancellations';
  static String supervisorDrinkManualValidation(String redemptionId) =>
      '/staff/supervisor/drinks/$redemptionId/manual-validation';
  static String supervisorDrinkOverride(String redemptionId) =>
      '/staff/supervisor/drinks/$redemptionId/override';
  static String supervisorEntryDetail(String ticketId) =>
      '/staff/supervisor/entries/$ticketId';
  static String supervisorEntryHistory(String ticketId) =>
      '/staff/supervisor/entries/$ticketId/history';
  static String supervisorEntryDuplicate(String ticketId) =>
      '/staff/supervisor/entries/$ticketId/duplicate';
  static String supervisorEntryDuplicateByEntryCode(String entryCode) =>
      '/staff/supervisor/entries/by-entry/${Uri.encodeComponent(entryCode)}/duplicate';
  static String supervisorResolveDuplicate(String ticketId) =>
      '/staff/supervisor/entries/$ticketId/resolve-duplicate';
  static String supervisorResolveDuplicateByEntryCode(String entryCode) =>
      '/staff/supervisor/entries/by-entry/${Uri.encodeComponent(entryCode)}/resolve-duplicate';
  static String supervisorEntryOverride(String ticketId) =>
      '/staff/supervisor/entries/$ticketId/override';
  static String supervisorEntryOverrideByEntryCode(String entryCode) =>
      '/staff/supervisor/entries/by-entry/${Uri.encodeComponent(entryCode)}/override';
  static String supervisorEntryManualValidation(String ticketId) =>
      '/staff/supervisor/entries/$ticketId/manual-validation';
  static String supervisorEntryManualValidationByEntryCode(String entryCode) =>
      '/staff/supervisor/entries/by-entry/${Uri.encodeComponent(entryCode)}/manual-validation';
  static const supervisorVipTablesSearch = '/staff/supervisor/vip-tables/search';
  static String supervisorVipTable(String orderId) =>
      '/staff/supervisor/vip-tables/$orderId';
  static String supervisorVipTableActions(String orderId) =>
      '/staff/supervisor/vip-tables/$orderId/actions';
  static const supervisorSystemStatus = '/staff/supervisor/system-status';
  static const supervisorSystemStatusActions = '/staff/supervisor/system-status/actions';
  static const supervisorActionHistory = '/staff/supervisor/action-history';
}
