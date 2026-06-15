import 'package:youpass/core/constants/app_constants.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static String get baseUrl => AppConstants.apiBaseUrl;
  static String get apiV1 => '$baseUrl/api/v1';

  static String get health => '$apiV1/health';
  static String get config => '$apiV1/config';
  static String get configAuth => '$apiV1/config/auth';
  static String get configSecurity => '$apiV1/config/security';
  static String get configCountries => '$apiV1/config/countries';
  static String get configCategories => '$apiV1/config/categories';
  static String get configEventCategories => '$apiV1/config/event-categories';
  static String get sendCode => '$apiV1/auth/send-code';
  static String get resendCode => '$apiV1/auth/resend-code';
  static String get verifyCode => '$apiV1/auth/verify-code';
  static String get login => '$apiV1/auth/login';
  static String get register => '$apiV1/auth/register';
  static String get logout => '$apiV1/auth/logout';
  static String get usersMe => '$apiV1/users/me';
  static String get userProfile => '$apiV1/users/me/profile';
  static String get userProfilePhoto => '$apiV1/users/me/profile-photo';
  static String get userProfileCompleteness => '$apiV1/users/me/profile-completeness';
  static String get userProfileBannerStatus => '$apiV1/users/me/profile-banner/status';
  static String get userProfileBannerDismiss => '$apiV1/users/me/profile-banner/dismiss';
  static String get userCategoryBenefits => '$apiV1/users/me/category-benefits';
  static String get userNotificationSettings => '$apiV1/users/me/notification-settings';
  static String get userNotificationsToggle => '$apiV1/users/me/notifications/toggle';
  static String get userWalletCards => '$apiV1/users/me/wallet/cards';
  static String get userWalletCardsTokenizeSession =>
      '$apiV1/users/me/wallet/cards/tokenize-session';
  static String get userWalletBalance => '$apiV1/users/me/wallet/balance';
  static String get userWalletTransactions => '$apiV1/users/me/wallet/transactions';
  static String get userAccountDeletionStatus => '$apiV1/users/me/account/deletion-status';
  static String get userAccountDeleteCancel => '$apiV1/users/me/account/delete-cancel';
  static String get supportContactInfo => '$apiV1/support/contact-info';
  static String get supportFaqs => '$apiV1/support/faqs';
  static String get supportWhatsAppTemplate => '$apiV1/support/whatsapp-template';
  static String get supportEmailTemplate => '$apiV1/support/email-template';
  static String get usersMeLogout => '$apiV1/users/me/logout';
  static String get userWelcomeData => '$apiV1/users/me/welcome-data';
  static String get deleteAccountRequest => '$apiV1/auth/delete-account/request';
  static String get deleteAccountVerify => '$apiV1/auth/delete-account/verify';
  static String get checkWhatsApp => '$apiV1/auth/check-whatsapp';
  static String get changePhoneRequest => '$apiV1/auth/change-phone/request';
  static String get changePhoneVerify => '$apiV1/auth/change-phone/verify';

  static String get homeInitialFeed => '$apiV1/home/initial-feed';
  static String get homeUpcomingEvents => '$apiV1/home/upcoming-events';
  static String get analyticsRegistrationCompleted =>
      '$apiV1/analytics/event/registration-completed';
  static String get eventsFeatured => '$apiV1/events/featured';
  static String get events => '$apiV1/events';
  static String get eventTypes => '$apiV1/events/types';

  static String get venues => '$apiV1/venues';

  static String venueById(String venueId) => '$apiV1/venues/$venueId';

  static String get favoriteEvents => '$apiV1/users/me/favorites/events';
  static String get favoritesCombined => '$apiV1/users/me/favorites';
  static String get favoriteProducers => '$apiV1/users/me/favorites/producers';

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

  static String get invitations => '$apiV1/invitations';
  static String get usersMeInvitations => '$apiV1/users/me/invitations';
  static String get invitationsSummary => '$apiV1/users/me/invitations/summary';
  static String get paymentMethods => '$apiV1/users/me/payment-methods';

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

  static String get ticketsUpcoming => '$apiV1/users/me/tickets/upcoming';
  static String get ticketsPast => '$apiV1/users/me/tickets/past';
  static String get ticketsYearlySummary =>
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
