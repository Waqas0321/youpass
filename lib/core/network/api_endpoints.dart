import 'package:youpass/core/constants/app_constants.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = AppConstants.apiBaseUrl;
  static const String apiV1 = '$baseUrl/api/v1';

  static const String health = '$apiV1/health';
  static const String config = '$apiV1/config';
  static const String configAuth = '$apiV1/config/auth';
  static const String configSecurity = '$apiV1/config/security';
  static const String configCountries = '$apiV1/config/countries';
  static const String configCategories = '$apiV1/config/categories';
  static const String configEventCategories = '$apiV1/config/event-categories';
  static const String sendCode = '$apiV1/auth/send-code';
  static const String resendCode = '$apiV1/auth/resend-code';
  static const String verifyCode = '$apiV1/auth/verify-code';
  static const String login = '$apiV1/auth/login';
  static const String register = '$apiV1/auth/register';
  static const String logout = '$apiV1/auth/logout';
  static const String usersMe = '$apiV1/users/me';
  static const String userProfile = '$apiV1/users/me/profile';
  static const String userProfilePhoto = '$apiV1/users/me/profile-photo';
  static const String userProfileCompleteness = '$apiV1/users/me/profile-completeness';
  static const String userProfileBannerStatus = '$apiV1/users/me/profile-banner/status';
  static const String userProfileBannerDismiss = '$apiV1/users/me/profile-banner/dismiss';
  static const String userCategoryBenefits = '$apiV1/users/me/category-benefits';
  static const String userNotificationSettings = '$apiV1/users/me/notification-settings';
  static const String userNotificationsToggle = '$apiV1/users/me/notifications/toggle';
  static const String userWalletCards = '$apiV1/users/me/wallet/cards';
  static const String userWalletCardsTokenizeSession =
      '$apiV1/users/me/wallet/cards/tokenize-session';
  static const String userWalletBalance = '$apiV1/users/me/wallet/balance';
  static const String userWalletTransactions = '$apiV1/users/me/wallet/transactions';
  static const String userAccountDeletionStatus = '$apiV1/users/me/account/deletion-status';
  static const String userAccountDeleteCancel = '$apiV1/users/me/account/delete-cancel';
  static const String supportContactInfo = '$apiV1/support/contact-info';
  static const String supportFaqs = '$apiV1/support/faqs';
  static const String supportWhatsAppTemplate = '$apiV1/support/whatsapp-template';
  static const String supportEmailTemplate = '$apiV1/support/email-template';
  static const String usersMeLogout = '$apiV1/users/me/logout';
  static const String userWelcomeData = '$apiV1/users/me/welcome-data';
  static const String deleteAccountRequest = '$apiV1/auth/delete-account/request';
  static const String deleteAccountVerify = '$apiV1/auth/delete-account/verify';
  static const String checkWhatsApp = '$apiV1/auth/check-whatsapp';
  static const String changePhoneRequest = '$apiV1/auth/change-phone/request';
  static const String changePhoneVerify = '$apiV1/auth/change-phone/verify';

  static const String homeInitialFeed = '$apiV1/home/initial-feed';
  static const String homeUpcomingEvents = '$apiV1/home/upcoming-events';
  static const String analyticsRegistrationCompleted =
      '$apiV1/analytics/event/registration-completed';
  static const String eventsFeatured = '$apiV1/events/featured';
  static const String events = '$apiV1/events';
  static const String eventTypes = '$apiV1/events/types';

  static const String favoriteEvents = '$apiV1/users/me/favorites/events';
  static const String favoritesCombined = '$apiV1/users/me/favorites';
  static const String favoriteProducers = '$apiV1/users/me/favorites/producers';

  static String favoriteEvent(String eventId) =>
      '$apiV1/users/me/favorites/events/$eventId';

  static String favoriteProducer(String producerId) =>
      '$apiV1/users/me/favorites/producers/$producerId';

  static String producerUpcomingEvents(String producerId) =>
      '$apiV1/producers/$producerId/upcoming-events';

  static String eventById(String eventId) => '$apiV1/events/$eventId';

  static String eventAvailability(String eventId) =>
      '$apiV1/events/$eventId/availability';

  static String eventWaitlistPreview(String eventId) =>
      '$apiV1/events/$eventId/waitlist/preview';

  static String eventWaitlistJoin(String eventId) =>
      '$apiV1/events/$eventId/waitlist/join';

  static String eventWaitlistLeave(String eventId) =>
      '$apiV1/events/$eventId/waitlist/leave';

  static String eventWaitlistPosition(String eventId) =>
      '$apiV1/events/$eventId/waitlist/position';

  static String waitlistOfferClaim(String offerId) =>
      '$apiV1/waitlist/offers/$offerId/claim';

  static const String invitations = '$apiV1/invitations';
  static const String usersMeInvitations = '$apiV1/users/me/invitations';
  static const String invitationsSummary = '$apiV1/users/me/invitations/summary';
  static const String paymentMethods = '$apiV1/users/me/payment-methods';

  static String invitationById(String invitationId) =>
      '$apiV1/invitations/$invitationId';

  static String invitationConfirm(String invitationId) =>
      '$apiV1/invitations/$invitationId/confirm';

  static String invitationReject(String invitationId) =>
      '$apiV1/invitations/$invitationId/reject';

  static String invitationCancel(String invitationId) =>
      '$apiV1/invitations/$invitationId/cancel';

  static String invitationTicket(String invitationId) =>
      '$apiV1/invitations/$invitationId/ticket';

  static String ticketById(String ticketId) =>
      '$apiV1/users/me/tickets/$ticketId';

  static String ticketQr(String ticketId) =>
      '$apiV1/users/me/tickets/$ticketId/qr';

  static String ticketCancel(String ticketId) =>
      '$apiV1/users/me/tickets/$ticketId/cancel';

  static const String ticketsUpcoming = '$apiV1/users/me/tickets/upcoming';
  static const String ticketsPast = '$apiV1/users/me/tickets/past';
  static const String ticketsYearlySummary =
      '$apiV1/users/me/tickets/yearly-summary';

  static String eventTicketTypes(String eventId) =>
      '$apiV1/events/$eventId/ticket-types';

  static String eventVenueLayout(String eventId) =>
      '$apiV1/events/$eventId/venue-layout';

  static String eventZoneTables(String eventId, String zoneId) =>
      '$apiV1/events/$eventId/zones/$zoneId/tables';

  static String eventTableById(String eventId, String tableId) =>
      '$apiV1/events/$eventId/tables/$tableId';

  static String eventTableLock(String eventId, String tableId) =>
      '$apiV1/events/$eventId/tables/$tableId/lock';

  static String eventTableLockStatus(String eventId, String tableId) =>
      '$apiV1/events/$eventId/tables/$tableId/lock/status';

  static String eventTablesAvailabilityRealtime(String eventId) =>
      '$apiV1/events/$eventId/tables/availability/realtime';

  static String eventCheckout(String eventId) =>
      '$apiV1/events/$eventId/checkout';

  static String eventCheckoutConfirm(String eventId) =>
      '$apiV1/events/$eventId/checkout/confirm';

  static String ticketOrderAssignments(String orderId) =>
      '$apiV1/users/me/ticket-orders/$orderId/assignments';

  static String ticketAssignments(String ticketId) =>
      '$apiV1/users/me/tickets/$ticketId/assignments';

  static String assignTicketSlot(String orderId, String slotId) =>
      '$apiV1/users/me/ticket-orders/$orderId/slots/$slotId/assign';

  static String cancelTicketAssignment(String orderId, String slotId) =>
      '$apiV1/users/me/ticket-orders/$orderId/slots/$slotId/assign';

  static String resendTicketAssignment(String orderId, String slotId) =>
      '$apiV1/users/me/ticket-orders/$orderId/slots/$slotId/resend';

  static String walletCard(String cardId) =>
      '$apiV1/users/me/wallet/cards/$cardId';

  static String walletCardDefault(String cardId) =>
      '$apiV1/users/me/wallet/cards/$cardId/default';

  static String supportFaqFeedback(String faqId) =>
      '$apiV1/support/faqs/$faqId/feedback';

  static String invitationClaim(String token) =>
      '$apiV1/invitations/claim/$token';
}
