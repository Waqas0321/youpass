import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/data/models/home_feed_labels.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AppStrings {
  AppStrings._();

  static String defaultGuestName(AppLocalizations l10n) => l10n.defaultGuestName;

  static String brandBadgeOff(AppLocalizations l10n) => l10n.brandBadgeOff;

  static String brandBadgeOn(AppLocalizations l10n) => l10n.brandBadgeOn;

  static String brandModeProduction(AppLocalizations l10n) =>
      l10n.brandModeProduction;

  static String brandModeFiesta(AppLocalizations l10n) => l10n.brandModeFiesta;

  static String homeGreeting(AppLocalizations l10n, String name) =>
      l10n.homeGreeting(name);

  static String homeDiscoverSubtitle(AppLocalizations l10n) =>
      l10n.homeDiscoverSubtitle;

  static String eventsSectionTitle(AppLocalizations l10n) =>
      l10n.eventsSectionTitle;

  static String homeNoEventsFound(AppLocalizations l10n) =>
      l10n.homeNoEventsFound;

  static String allEventsTitle(AppLocalizations l10n) => l10n.allEventsTitle;

  static String allEventsSubtitle(AppLocalizations l10n) =>
      l10n.allEventsSubtitle;

  static String allEventsSearchHint(AppLocalizations l10n) =>
      l10n.allEventsSearchHint;

  static String allEventsAvailableCount(AppLocalizations l10n, int count) =>
      l10n.allEventsAvailableCount(count);

  static String favoritesEventsSubtitle(AppLocalizations l10n) =>
      l10n.favoritesEventsSubtitle;

  static String favoritesEventsSearchHint(AppLocalizations l10n) =>
      l10n.favoritesEventsSearchHint;

  static String favoritesEventsEmpty(AppLocalizations l10n) =>
      l10n.favoritesEventsEmpty;

  static String favoritesSavedEventsCount(AppLocalizations l10n, int count) =>
      l10n.favoritesSavedEventsCount(count);

  static String seeAll(AppLocalizations l10n) => l10n.seeAll;

  static String buyTickets(AppLocalizations l10n) => l10n.buyTickets;

  static String homeCategoryLabel(AppLocalizations l10n, String categoryId) {
    switch (categoryId) {
      case AppConstants.categoryIdAll:
        return l10n.categoryAll;
      case AppConstants.categoryIdChile:
        return l10n.categoryChile;
      case AppConstants.categoryIdParties:
        return l10n.categoryParties;
      case AppConstants.categoryIdConcerts:
        return l10n.categoryConcerts;
      case AppConstants.categoryIdSports:
        return l10n.categorySports;
      default:
        return categoryId;
    }
  }

  static String errorGeneric(AppLocalizations l10n) => l10n.errorGeneric;

  static String selectCountryTitle(AppLocalizations l10n) =>
      l10n.selectCountryTitle;

  static String searchCountryHint(AppLocalizations l10n) =>
      l10n.searchCountryHint;

  static String searchCountryEmpty(AppLocalizations l10n) =>
      l10n.searchCountryEmpty;

  static String drawerMyProfile(AppLocalizations l10n) => l10n.drawerMyProfile;

  static String drawerMyTickets(AppLocalizations l10n) => l10n.drawerMyTickets;

  static String drawerMyFavorites(AppLocalizations l10n) =>
      l10n.drawerMyFavorites;

  static String drawerInvitations(AppLocalizations l10n) =>
      l10n.drawerInvitations;

  static String drawerInvitationsNewBadge(AppLocalizations l10n, int count) =>
      l10n.drawerInvitationsNewBadge(count);

  static String drawerTierGold(AppLocalizations l10n) => l10n.drawerTierGold;

  static String profileTitle(AppLocalizations l10n) => l10n.profileTitle;

  static String profileViewBenefits(AppLocalizations l10n) =>
      l10n.profileViewBenefits;

  static String profilePersonalData(AppLocalizations l10n) =>
      l10n.profilePersonalData;

  static String profileFullName(AppLocalizations l10n) => l10n.profileFullName;

  static String profileEmail(AppLocalizations l10n) => l10n.profileEmail;

  static String profileBirthDate(AppLocalizations l10n) => l10n.profileBirthDate;

  static String profileGender(AppLocalizations l10n) => l10n.profileGender;

  static String profileGenderMaleValue(AppLocalizations l10n) =>
      l10n.profileGenderMaleValue;

  static String profileInstagram(AppLocalizations l10n) => l10n.profileInstagram;

  static String profileEditData(AppLocalizations l10n) => l10n.profileEditData;

  static String profileWalletSection(AppLocalizations l10n) =>
      l10n.profileWalletSection;

  static String profilePaymentMethods(AppLocalizations l10n) =>
      l10n.profilePaymentMethods;

  static String profileCardVisa(AppLocalizations l10n) => l10n.profileCardVisa;

  static String profileCardMastercard(AppLocalizations l10n) =>
      l10n.profileCardMastercard;

  static String profileDefaultCard(AppLocalizations l10n) =>
      l10n.profileDefaultCard;

  static String profileViewFullWallet(AppLocalizations l10n) =>
      l10n.profileViewFullWallet;

  static String profileNotifications(AppLocalizations l10n) =>
      l10n.profileNotifications;

  static String profileReceiveNotifications(AppLocalizations l10n) =>
      l10n.profileReceiveNotifications;

  static String profileNotificationChannels(AppLocalizations l10n) =>
      l10n.profileNotificationChannels;

  static String profileSupport(AppLocalizations l10n) => l10n.profileSupport;

  static String profileWhatsAppSupport(AppLocalizations l10n) =>
      l10n.profileWhatsAppSupport;

  static String profileWriteEmail(AppLocalizations l10n) =>
      l10n.profileWriteEmail;

  static String profileFaq(AppLocalizations l10n) => l10n.profileFaq;

  static String profileLogout(AppLocalizations l10n) => l10n.profileLogout;

  static String profileDeleteAccount(AppLocalizations l10n) =>
      l10n.profileDeleteAccount;

  static String profilePhotoUpdated(AppLocalizations l10n) =>
      l10n.profilePhotoUpdated;

  static String confirmDialogCancel(AppLocalizations l10n) =>
      l10n.confirmDialogCancel;

  static String confirmLogoutTitle(AppLocalizations l10n) =>
      l10n.confirmLogoutTitle;

  static String confirmLogoutMessage(AppLocalizations l10n) =>
      l10n.confirmLogoutMessage;

  static String confirmLogoutAction(AppLocalizations l10n) =>
      l10n.confirmLogoutAction;

  static String confirmDeleteAccountTitle(AppLocalizations l10n) =>
      l10n.confirmDeleteAccountTitle;

  static String confirmDeleteAccountMessage(AppLocalizations l10n) =>
      l10n.confirmDeleteAccountMessage;

  static String confirmDeleteAccountAction(AppLocalizations l10n) =>
      l10n.confirmDeleteAccountAction;

  static String ticketsTabUpcoming(AppLocalizations l10n) =>
      l10n.ticketsTabUpcoming;

  static String ticketsTabPast(AppLocalizations l10n) => l10n.ticketsTabPast;

  static String ticketsStatusActive(AppLocalizations l10n) =>
      l10n.ticketsStatusActive;

  static String ticketsViewQr(AppLocalizations l10n) => l10n.ticketsViewQr;

  static String ticketsAssignEntries(AppLocalizations l10n) =>
      l10n.ticketsAssignEntries;

  static String ticketsAssignVip(AppLocalizations l10n) => l10n.ticketsAssignVip;

  static String ticketsAttendedSectionTitle(AppLocalizations l10n) =>
      l10n.ticketsAttendedSectionTitle;

  static String ticketsAttendedSectionSubtitle(AppLocalizations l10n) =>
      l10n.ticketsAttendedSectionSubtitle;

  static String ticketsSearchHint(AppLocalizations l10n) =>
      l10n.ticketsSearchHint;

  static String ticketsFiltersLabel(AppLocalizations l10n) =>
      l10n.ticketsFiltersLabel;

  static String ticketsFilterAll(AppLocalizations l10n) => l10n.ticketsFilterAll;

  static String ticketsFilterParties(AppLocalizations l10n) =>
      l10n.ticketsFilterParties;

  static String ticketsFilterConcerts(AppLocalizations l10n) =>
      l10n.ticketsFilterConcerts;

  static String ticketsFilterBar(AppLocalizations l10n) => l10n.ticketsFilterBar;

  static String ticketsYearlySummaryAttended(
    AppLocalizations l10n, {
    required int count,
    required int year,
  }) =>
      l10n.ticketsYearlySummaryAttended(count, year);

  static String ticketsYearlySummaryProducer(
    AppLocalizations l10n, {
    required String name,
    required int count,
  }) =>
      l10n.ticketsYearlySummaryProducer(name, count);

  static String ticketsEmptyUpcoming(AppLocalizations l10n) =>
      l10n.ticketsEmptyUpcoming;

  static String ticketsEmptyPast(AppLocalizations l10n) => l10n.ticketsEmptyPast;

  static String ticketsRetry(AppLocalizations l10n) => l10n.ticketsRetry;

  static String ticketAssignmentTitle(AppLocalizations l10n) =>
      l10n.ticketAssignmentTitle;

  static String ticketAssignmentHeading(AppLocalizations l10n) =>
      l10n.ticketAssignmentHeading;

  static String ticketAssignmentSlotLabel(AppLocalizations l10n, int number) =>
      l10n.ticketAssignmentSlotLabel(number);

  static String ticketAssignmentSummarySubtitle(
    AppLocalizations l10n,
    int count,
  ) =>
      l10n.ticketAssignmentSummarySubtitle(count);

  static String ticketAssignmentAvailableCount(AppLocalizations l10n, int count) =>
      l10n.ticketAssignmentAvailableCount(count);

  static String ticketAssignmentPendingCount(AppLocalizations l10n, int count) =>
      l10n.ticketAssignmentPendingCount(count);

  static String ticketAssignmentOwnerTicket(AppLocalizations l10n) =>
      l10n.ticketAssignmentOwnerTicket;

  static String ticketAssignmentClaimedTicket(AppLocalizations l10n) =>
      l10n.ticketAssignmentClaimedTicket;

  static String ticketAssignmentPendingBadge(AppLocalizations l10n) =>
      l10n.ticketAssignmentPendingBadge;

  static String ticketAssignmentAvailableBadge(AppLocalizations l10n) =>
      l10n.ticketAssignmentAvailableBadge;

  static String ticketAssignmentGuestNameLabel(AppLocalizations l10n) =>
      l10n.ticketAssignmentGuestNameLabel;

  static String ticketAssignmentGuestNameHint(AppLocalizations l10n) =>
      l10n.ticketAssignmentGuestNameHint;

  static String ticketAssignmentGuestPhoneLabel(AppLocalizations l10n) =>
      l10n.ticketAssignmentGuestPhoneLabel;

  static String ticketAssignmentGuestPhoneHint(AppLocalizations l10n) =>
      l10n.ticketAssignmentGuestPhoneHint;

  static String ticketAssignmentPickContact(AppLocalizations l10n) =>
      l10n.ticketAssignmentPickContact;

  static String ticketAssignmentSendTicket(AppLocalizations l10n) =>
      l10n.ticketAssignmentSendTicket;

  static String ticketAssignmentCancelTicket(AppLocalizations l10n) =>
      l10n.ticketAssignmentCancelTicket;

  static String ticketAssignmentResendWhatsApp(AppLocalizations l10n) =>
      l10n.ticketAssignmentResendWhatsApp;

  static String ticketAssignmentSentSuccess(AppLocalizations l10n) =>
      l10n.ticketAssignmentSentSuccess;

  static String ticketAssignmentContactsPermissionDenied(AppLocalizations l10n) =>
      l10n.ticketAssignmentContactsPermissionDenied;

  static String ticketAssignmentMissingOrder(AppLocalizations l10n) =>
      l10n.ticketAssignmentMissingOrder;

  static String ticketAssignmentNoAssignableTickets(AppLocalizations l10n) =>
      l10n.ticketAssignmentNoAssignableTickets;

  static String ticketAssignmentRetry(AppLocalizations l10n) =>
      l10n.ticketAssignmentRetry;

  static String ticketAssignmentWhatsAppInfo(AppLocalizations l10n) =>
      l10n.ticketAssignmentWhatsAppInfo;

  static String ticketAssignmentPrivacyNote(AppLocalizations l10n) =>
      l10n.ticketAssignmentPrivacyNote;

  static String invitationClaimTitle(AppLocalizations l10n) =>
      l10n.invitationClaimTitle;

  static String invitationClaimGuestLabel(AppLocalizations l10n) =>
      l10n.invitationClaimGuestLabel;

  static String invitationClaimInvitedByLabel(AppLocalizations l10n) =>
      l10n.invitationClaimInvitedByLabel;

  static String invitationClaimStepsTitle(AppLocalizations l10n) =>
      l10n.invitationClaimStepsTitle;

  static String invitationClaimOpenInvitations(AppLocalizations l10n) =>
      l10n.invitationClaimOpenInvitations;

  static String invitationClaimLoginRegister(AppLocalizations l10n) =>
      l10n.invitationClaimLoginRegister;

  static String ticketsStatistics(AppLocalizations l10n) =>
      l10n.ticketsStatistics;

  static String ticketsStatEntry(AppLocalizations l10n) => l10n.ticketsStatEntry;

  static String ticketsStatConsumption(AppLocalizations l10n) =>
      l10n.ticketsStatConsumption;

  static String ticketsStatStay(AppLocalizations l10n) => l10n.ticketsStatStay;

  static String ticketsFavoritesTip(AppLocalizations l10n) =>
      l10n.ticketsFavoritesTip;

  static String favoritesSubtitle(AppLocalizations l10n) =>
      l10n.favoritesSubtitle;

  static String favoritesSearchHint(AppLocalizations l10n) =>
      l10n.favoritesSearchHint;

  static String favoritesFiltersLabel(AppLocalizations l10n) =>
      l10n.favoritesFiltersLabel;

  static String favoritesFilterAll(AppLocalizations l10n) =>
      l10n.favoritesFilterAll;

  static String favoritesFilterUpcoming(AppLocalizations l10n) =>
      l10n.favoritesFilterUpcoming;

  static String favoritesFilterParties(AppLocalizations l10n) =>
      l10n.favoritesFilterParties;

  static String favoritesFilterVip(AppLocalizations l10n) =>
      l10n.favoritesFilterVip;

  static String favoritesProducerType(AppLocalizations l10n) =>
      l10n.favoritesProducerType;

  static String favoritesProducerCoverage(AppLocalizations l10n) =>
      l10n.favoritesProducerCoverage;

  static String favoritesViewEvents(AppLocalizations l10n) =>
      l10n.favoritesViewEvents;

  static String favoritesSavedProducersCount(AppLocalizations l10n, int count) =>
      l10n.favoritesSavedProducersCount(count);

  static String producerEventsUpcomingTitle(AppLocalizations l10n) =>
      l10n.producerEventsUpcomingTitle;

  static String producerEventsUpcomingSubtitle(
    AppLocalizations l10n,
    String producerName,
  ) =>
      l10n.producerEventsUpcomingSubtitle(producerName);

  static String producerEventsSearchHint(AppLocalizations l10n) =>
      l10n.producerEventsSearchHint;

  static String producerEventCategoryParties(AppLocalizations l10n) =>
      l10n.producerEventCategoryParties;

  static String producerEventCategoryFestivals(AppLocalizations l10n) =>
      l10n.producerEventCategoryFestivals;

  static String producerEventCategoryConcerts(AppLocalizations l10n) =>
      l10n.producerEventCategoryConcerts;

  static String producerEventFromPrice(AppLocalizations l10n) =>
      l10n.producerEventFromPrice;

  static String producerEventBuyTicket(AppLocalizations l10n) =>
      l10n.producerEventBuyTicket;

  static String producerEventsAvailableCount(AppLocalizations l10n, int count) =>
      l10n.producerEventsAvailableCount(count);

  static String drawerMyInvitations(AppLocalizations l10n) =>
      l10n.drawerMyInvitations;

  static String invitationsScreenTitle(AppLocalizations l10n) =>
      l10n.invitationsScreenTitle;

  static String invitationsSubtitle(AppLocalizations l10n) =>
      l10n.invitationsSubtitle;

  static String invitationsSearchHint(AppLocalizations l10n) =>
      l10n.invitationsSearchHint;

  static String invitationsFilterAll(AppLocalizations l10n) =>
      l10n.invitationsFilterAll;

  static String invitationsFilterGeneral(AppLocalizations l10n) =>
      l10n.invitationsFilterGeneral;

  static String invitationsFilterVip(AppLocalizations l10n) =>
      l10n.invitationsFilterVip;

  static String invitationsTierVip(AppLocalizations l10n) =>
      l10n.invitationsTierVip;

  static String invitationsTierGeneral(AppLocalizations l10n) =>
      l10n.invitationsTierGeneral;

  static String invitationsTierVipMesa(AppLocalizations l10n) =>
      l10n.invitationsTierVipMesa;

  static String invitationsStatusLine(AppLocalizations l10n, String status) =>
      l10n.invitationsStatusLine(status);

  static String invitationsStatusPrefix(AppLocalizations l10n) =>
      l10n.invitationsStatusPrefix;

  static String invitationsStatusPending(AppLocalizations l10n) =>
      l10n.invitationsStatusPending;

  static String invitationsStatusConfirmed(AppLocalizations l10n) =>
      l10n.invitationsStatusConfirmed;

  static String invitationsStatusRejected(AppLocalizations l10n) =>
      l10n.invitationsStatusRejected;

  static String invitationsConfirmAttendance(AppLocalizations l10n) =>
      l10n.invitationsConfirmAttendance;

  static String invitationsReject(AppLocalizations l10n) =>
      l10n.invitationsReject;

  static String invitationsCancel(AppLocalizations l10n) =>
      l10n.invitationsCancel;

  static String invitationsAttendanceConfirmed(AppLocalizations l10n) =>
      l10n.invitationsAttendanceConfirmed;

  static String invitationsViewQr(AppLocalizations l10n) =>
      l10n.invitationsViewQr;

  static String invitationsQrPendingTitle(AppLocalizations l10n) =>
      l10n.invitationsQrPendingTitle;

  static String invitationsQrPendingMessage(AppLocalizations l10n) =>
      l10n.invitationsQrPendingMessage;

  static String invitationsQrLockedTitle(AppLocalizations l10n) =>
      l10n.invitationsQrLockedTitle;

  static String invitationsQrLockedMessage(AppLocalizations l10n) =>
      l10n.invitationsQrLockedMessage;

  static String invitationsQrExpiredTitle(AppLocalizations l10n) =>
      l10n.invitationsQrExpiredTitle;

  static String invitationsQrExpiredMessage(AppLocalizations l10n) =>
      l10n.invitationsQrExpiredMessage;

  static String invitationsQrUnlockAt(AppLocalizations l10n, String date) =>
      l10n.invitationsQrUnlockAt(date);

  static String invitationsQrGotIt(AppLocalizations l10n) =>
      l10n.invitationsQrGotIt;

  static String invitationsFooterNote(AppLocalizations l10n) =>
      l10n.invitationsFooterNote;

  static String invitationsImportantTitle(AppLocalizations l10n) =>
      l10n.invitationsImportantTitle;

  static String invitationsImportantMessage(AppLocalizations l10n) =>
      l10n.invitationsImportantMessage;

  static String invitationsAddPaymentMethod(AppLocalizations l10n) =>
      l10n.invitationsAddPaymentMethod;

  static String invitationsPaymentTitle(AppLocalizations l10n) =>
      l10n.invitationsPaymentTitle;

  static String invitationsPaymentSubtitle(AppLocalizations l10n) =>
      l10n.invitationsPaymentSubtitle;

  static String invitationsCardNumber(AppLocalizations l10n) =>
      l10n.invitationsCardNumber;

  static String invitationsCardNumberHint(AppLocalizations l10n) =>
      l10n.invitationsCardNumberHint;

  static String invitationsCardExpiry(AppLocalizations l10n) =>
      l10n.invitationsCardExpiry;

  static String invitationsCardExpiryHint(AppLocalizations l10n) =>
      l10n.invitationsCardExpiryHint;

  static String invitationsCardCvv(AppLocalizations l10n) =>
      l10n.invitationsCardCvv;

  static String invitationsCardCvvHint(AppLocalizations l10n) =>
      l10n.invitationsCardCvvHint;

  static String invitationsCardholderName(AppLocalizations l10n) =>
      l10n.invitationsCardholderName;

  static String invitationsCardholderNameHint(AppLocalizations l10n) =>
      l10n.invitationsCardholderNameHint;

  static String invitationsPaymentSecureNote(AppLocalizations l10n) =>
      l10n.invitationsPaymentSecureNote;

  static String invitationsSaveCard(AppLocalizations l10n) =>
      l10n.invitationsSaveCard;

  static String invitationsCardSavedTitle(AppLocalizations l10n) =>
      l10n.invitationsCardSavedTitle;

  static String invitationsCardSavedMessage(AppLocalizations l10n) =>
      l10n.invitationsCardSavedMessage;

  static String invitationsCardSavedReminderCharge(AppLocalizations l10n) =>
      l10n.invitationsCardSavedReminderCharge;

  static String invitationsCardSavedReminderCancel(AppLocalizations l10n) =>
      l10n.invitationsCardSavedReminderCancel;

  static String eventTicketScreenTitle(AppLocalizations l10n) =>
      l10n.eventTicketScreenTitle;

  static String eventTicketReadyTitle(AppLocalizations l10n) =>
      l10n.eventTicketReadyTitle;

  static String eventTicketReadySubtitle(AppLocalizations l10n) =>
      l10n.eventTicketReadySubtitle;

  static String eventTicketManualIdLabel(AppLocalizations l10n) =>
      l10n.eventTicketManualIdLabel;

  static String welcomeFallbackTitle(AppLocalizations l10n) =>
      l10n.welcomeFallbackTitle;

  static String welcomeFallbackSubtitle(AppLocalizations l10n) =>
      l10n.welcomeFallbackSubtitle;

  static String paymentBrandVisa(AppLocalizations l10n) => l10n.paymentBrandVisa;

  static String paymentBrandMastercard(AppLocalizations l10n) =>
      l10n.paymentBrandMastercard;

  static String errorMissingAccessToken(AppLocalizations l10n) =>
      l10n.errorMissingAccessToken;

  static String errorAuthenticationRequired(AppLocalizations l10n) =>
      l10n.errorAuthenticationRequired;

  static String emailRequired(AppLocalizations l10n) => l10n.emailRequired;

  static String emailInvalid(AppLocalizations l10n) => l10n.emailInvalid;

  static String passwordRequired(AppLocalizations l10n) => l10n.passwordRequired;

  static String passwordMinLength(AppLocalizations l10n) =>
      l10n.passwordMinLength;

  static String phoneHintChile(AppLocalizations l10n) => l10n.phoneHintChile;

  static String phoneHintGeneric(AppLocalizations l10n) => l10n.phoneHintGeneric;

  static String phoneHintPakistan(AppLocalizations l10n) =>
      l10n.phoneHintPakistan;

  static String mockEventFestivalVerano2026(AppLocalizations l10n) =>
      l10n.mockEventFestivalVerano2026;

  static String mockEventConciertoX(AppLocalizations l10n) =>
      l10n.mockEventConciertoX;

  static String mockEventYoufest2026(AppLocalizations l10n) =>
      l10n.mockEventYoufest2026;

  static String mockEventIguanaSummer(AppLocalizations l10n) =>
      l10n.mockEventIguanaSummer;

  static String mockEventYoufestWinter2026(AppLocalizations l10n) =>
      l10n.mockEventYoufestWinter2026;

  static String mockEventNeonRooftopSessions(AppLocalizations l10n) =>
      l10n.mockEventNeonRooftopSessions;

  static String mockEventSummerClosingParty(AppLocalizations l10n) =>
      l10n.mockEventSummerClosingParty;

  static String mockDateSaturdayMay15(AppLocalizations l10n) =>
      l10n.mockDateSaturdayMay15;

  static String mockDateSaturdayMay15Long(AppLocalizations l10n) =>
      l10n.mockDateSaturdayMay15Long;

  static String mockDateSaturdayJuly4(AppLocalizations l10n) =>
      l10n.mockDateSaturdayJuly4;

  static String mockLocationClubAmanda(AppLocalizations l10n) =>
      l10n.mockLocationClubAmanda;

  static String mockLocationClubAmandaShort(AppLocalizations l10n) =>
      l10n.mockLocationClubAmandaShort;

  static String mockLocationMovistarArena(AppLocalizations l10n) =>
      l10n.mockLocationMovistarArena;

  static String mockLocationCentroEventosHilaria(AppLocalizations l10n) =>
      l10n.mockLocationCentroEventosHilaria;

  static String mockTicketGeneralOne(AppLocalizations l10n) =>
      l10n.mockTicketGeneralOne;

  static String mockTicketVipTwo(AppLocalizations l10n) =>
      l10n.mockTicketVipTwo;

  static String mockStayDuration5h14m(AppLocalizations l10n) =>
      l10n.mockStayDuration5h14m;

  static String mockSeatVipTable(AppLocalizations l10n) => l10n.mockSeatVipTable;

  static String mockProducerYoufest(AppLocalizations l10n) =>
      l10n.mockProducerYoufest;

  static String mockProducerIguana(AppLocalizations l10n) =>
      l10n.mockProducerIguana;

  static String mockPriceFrom35000(AppLocalizations l10n) =>
      l10n.mockPriceFrom35000;

  static String mockPriceFrom28000(AppLocalizations l10n) =>
      l10n.mockPriceFrom28000;

  static String mockPriceFrom42000(AppLocalizations l10n) =>
      l10n.mockPriceFrom42000;

  static String mockPriceFrom55000(AppLocalizations l10n) =>
      l10n.mockPriceFrom55000;

  static String mockPriceFrom32000(AppLocalizations l10n) =>
      l10n.mockPriceFrom32000;

  static String mockPriceFrom50000(AppLocalizations l10n) =>
      l10n.mockPriceFrom50000;

  static String mockDateSaturdayJuly18(AppLocalizations l10n) =>
      l10n.mockDateSaturdayJuly18;

  static String mockDateFridayAugust7(AppLocalizations l10n) =>
      l10n.mockDateFridayAugust7;

  static String mockDateSaturdaySeptember12(AppLocalizations l10n) =>
      l10n.mockDateSaturdaySeptember12;

  static String mockDateSaturdayAugust22(AppLocalizations l10n) =>
      l10n.mockDateSaturdayAugust22;

  static String mockDateSaturdayJuly4Short(AppLocalizations l10n) =>
      l10n.mockDateSaturdayJuly4Short;

  static String mockDateFridayAugust7Short(AppLocalizations l10n) =>
      l10n.mockDateFridayAugust7Short;

  static String mockDateSaturdaySeptember12Short(AppLocalizations l10n) =>
      l10n.mockDateSaturdaySeptember12Short;

  static String mockLocationParqueBicentenario(AppLocalizations l10n) =>
      l10n.mockLocationParqueBicentenario;

  static String mockLocationTerrazaNeon(AppLocalizations l10n) =>
      l10n.mockLocationTerrazaNeon;

  static String mockLocationClubAmandaValparaiso(AppLocalizations l10n) =>
      l10n.mockLocationClubAmandaValparaiso;

  static String mockLocationMovistarArenaShort(AppLocalizations l10n) =>
      l10n.mockLocationMovistarArenaShort;

  static String mockLocationSkyCostanera(AppLocalizations l10n) =>
      l10n.mockLocationSkyCostanera;

  static String mockLocationClubOceano(AppLocalizations l10n) =>
      l10n.mockLocationClubOceano;

  static String mockTime2200Hrs(AppLocalizations l10n) => l10n.mockTime2200Hrs;

  static String mockTime2300Hrs(AppLocalizations l10n) => l10n.mockTime2300Hrs;

  static String mockTime2130Hrs(AppLocalizations l10n) => l10n.mockTime2130Hrs;

  static HomeFeedLabels homeFeedLabels(AppLocalizations l10n) {
    return HomeFeedLabels(
      allLabel: l10n.categoryAll,
      chileLabel: l10n.categoryChile,
      partiesLabel: l10n.categoryParties,
      concertsLabel: l10n.categoryConcerts,
      sportsLabel: l10n.categorySports,
      featuredTitle: l10n.featuredEventTitle,
      featuredDate: l10n.featuredEventDate,
      featuredLocation: l10n.featuredEventLocation,
      featuredSummerTitle: l10n.featuredEventSummerTitle,
      featuredUrbanTitle: l10n.featuredEventUrbanTitle,
      eventCaribeTitle: l10n.eventCaribeTitle,
      eventRockTitle: l10n.eventRockTitle,
      caribeDate: l10n.eventCaribeDate,
      caribeLocation: l10n.eventCaribeLocation,
      rockDate: l10n.eventRockDate,
      rockLocation: l10n.eventRockLocation,
    );
  }
}
