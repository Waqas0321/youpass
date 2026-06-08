import 'package:youpass/core/constants/app_constants.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = AppConstants.apiBaseUrl;
  static const String apiV1 = '$baseUrl/api/v1';

  static const String health = '$apiV1/health';
  static const String configCountries = '$apiV1/config/countries';
  static const String sendCode = '$apiV1/auth/send-code';
  static const String resendCode = '$apiV1/auth/resend-code';
  static const String verifyCode = '$apiV1/auth/verify-code';
  static const String login = '$apiV1/auth/login';
  static const String register = '$apiV1/auth/register';
  static const String logout = '$apiV1/auth/logout';
  static const String usersMe = '$apiV1/users/me';
  static const String userProfile = '$apiV1/users/me/profile';
  static const String userProfilePhoto = '$apiV1/users/me/profile-photo';
  static const String userWelcomeData = '$apiV1/users/me/welcome-data';
  static const String deleteAccountRequest = '$apiV1/auth/delete-account/request';
  static const String deleteAccountVerify = '$apiV1/auth/delete-account/verify';
  static const String checkWhatsApp = '$apiV1/auth/check-whatsapp';

  static const String homeInitialFeed = '$apiV1/home/initial-feed';
  static const String eventsFeatured = '$apiV1/events/featured';
  static const String events = '$apiV1/events';
  static const String eventTypes = '$apiV1/events/types';

  static const String favoriteEvents = '$apiV1/users/me/favorites/events';

  static String favoriteEvent(String eventId) =>
      '$apiV1/users/me/favorites/events/$eventId';

  static String eventById(String eventId) => '$apiV1/events/$eventId';

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

  static String invitationTicket(String invitationId) =>
      '$apiV1/invitations/$invitationId/ticket';

  static String ticketById(String ticketId) =>
      '$apiV1/users/me/tickets/$ticketId';

  static String ticketQr(String ticketId) =>
      '$apiV1/users/me/tickets/$ticketId/qr';

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

  static String eventTablesAvailabilityRealtime(String eventId) =>
      '$apiV1/events/$eventId/tables/availability/realtime';

  static String eventCheckout(String eventId) =>
      '$apiV1/events/$eventId/checkout';

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

  static String invitationClaim(String token) =>
      '$apiV1/invitations/claim/$token';
}
