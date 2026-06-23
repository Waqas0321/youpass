import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/data/models/home_feed_labels.dart';
import 'package:youpass/features/profile/data/models/profile_notification_settings_model.dart';
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

  static String homeEventsEndOfList(AppLocalizations l10n) =>
      l10n.homeEventsEndOfList;

  static String homeNearMeButton(AppLocalizations l10n) =>
      l10n.homeNearMeButton;

  static String homeNearMeHeaderLink(AppLocalizations l10n) =>
      l10n.homeNearMeHeaderLink;

  static String homeEventDistanceKm(AppLocalizations l10n, String distance) =>
      l10n.homeEventDistanceKm(distance);

  static String homeEventTravelMinutes(AppLocalizations l10n, int minutes) =>
      l10n.homeEventTravelMinutes(minutes);

  static String homeNearMePermissionDenied(AppLocalizations l10n) =>
      l10n.homeNearMePermissionDenied;

  static String homeNearMeLocationDisabled(AppLocalizations l10n) =>
      l10n.homeNearMeLocationDisabled;

  static String homeSearchPlaceholder(AppLocalizations l10n) =>
      l10n.homeSearchPlaceholder;

  static String homeSearchEmpty(AppLocalizations l10n) => l10n.homeSearchEmpty;

  static String homeSearchRecentTitle(AppLocalizations l10n) =>
      l10n.homeSearchRecentTitle;

  static String homeSearchClearHistory(AppLocalizations l10n) =>
      l10n.homeSearchClearHistory;

  static String homeSearchSuggestionsTitle(AppLocalizations l10n) =>
      l10n.homeSearchSuggestionsTitle;

  static String homeFiltersTitle(AppLocalizations l10n) => l10n.homeFiltersTitle;

  static String homeFiltersDate(AppLocalizations l10n) => l10n.homeFiltersDate;

  static String homeFiltersPrice(AppLocalizations l10n) => l10n.homeFiltersPrice;

  static String homeFiltersCityZone(AppLocalizations l10n) =>
      l10n.homeFiltersCityZone;

  static String homeFiltersVenueType(AppLocalizations l10n) =>
      l10n.homeFiltersVenueType;

  static String homeFiltersFreeOnly(AppLocalizations l10n) =>
      l10n.homeFiltersFreeOnly;

  static String homeFiltersCityLabel(AppLocalizations l10n) =>
      l10n.homeFiltersCityLabel;

  static String homeFiltersZoneLabel(AppLocalizations l10n) =>
      l10n.homeFiltersZoneLabel;

  static String homeFiltersClear(AppLocalizations l10n) => l10n.homeFiltersClear;

  static String homeFiltersApply(AppLocalizations l10n) => l10n.homeFiltersApply;

  static String homeFiltersApplyCount(AppLocalizations l10n, int count) =>
      l10n.homeFiltersApplyCount(count);

  static String homeFiltersCustomRange(AppLocalizations l10n) =>
      l10n.homeFiltersCustomRange;

  static String homeFiltersAllCities(AppLocalizations l10n) =>
      l10n.homeFiltersAllCities;

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

  static String eventDetailTitle(AppLocalizations l10n) => l10n.eventDetailTitle;

  static String eventDetailAboutSection(AppLocalizations l10n) =>
      l10n.eventDetailAboutSection;

  static String eventDetailAboutHeading(AppLocalizations l10n) =>
      l10n.eventDetailAboutHeading;

  static String eventDetailReadMore(AppLocalizations l10n) =>
      l10n.eventDetailReadMore;

  static String eventDetailReadLess(AppLocalizations l10n) =>
      l10n.eventDetailReadLess;

  static String eventDetailBuyTicketsLabel(AppLocalizations l10n) =>
      l10n.eventDetailBuyTicketsLabel;

  static String eventDetailSoldOut(AppLocalizations l10n) =>
      l10n.eventDetailSoldOut;

  static String eventDetailPromoterLabel(AppLocalizations l10n) =>
      l10n.eventDetailPromoterLabel;

  static String eventDetailFollowPromoter(AppLocalizations l10n, String name) =>
      l10n.eventDetailFollowPromoter(name);

  static String eventDetailUnfollowPromoter(
    AppLocalizations l10n,
    String name,
  ) =>
      l10n.eventDetailUnfollowPromoter(name);

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

  static String drawerHome(AppLocalizations l10n) => l10n.drawerHome;

  static String drawerMyTickets(AppLocalizations l10n) => l10n.drawerMyTickets;

  static String drawerMyFavorites(AppLocalizations l10n) =>
      l10n.drawerMyFavorites;

  static String drawerInvitations(AppLocalizations l10n) =>
      l10n.drawerInvitations;

  static String drawerDrinkMenu(AppLocalizations l10n) => l10n.drawerDrinkMenu;

  static String drawerMyPurchases(AppLocalizations l10n) =>
      l10n.drawerMyPurchases;

  static String partyDrinkMenuEmpty(AppLocalizations l10n) =>
      l10n.partyDrinkMenuEmpty;

  static String partyDrinkMenuSubtitle(AppLocalizations l10n) =>
      l10n.partyDrinkMenuSubtitle;

  static String partyDrinkCategoryAll(AppLocalizations l10n) =>
      l10n.partyDrinkCategoryAll;

  static String partyDrinkCategoryPiscos(AppLocalizations l10n) =>
      l10n.partyDrinkCategoryPiscos;

  static String partyDrinkCategoryBeers(AppLocalizations l10n) =>
      l10n.partyDrinkCategoryBeers;

  static String partyDrinkCategorySparkling(AppLocalizations l10n) =>
      l10n.partyDrinkCategorySparkling;

  static String partyDrinkCategoryEnergy(AppLocalizations l10n) =>
      l10n.partyDrinkCategoryEnergy;

  static String partyDrinkQuickRecommendations(AppLocalizations l10n) =>
      l10n.partyDrinkQuickRecommendations;

  static String partyDrinkQuickRecommendationsSubtitle(AppLocalizations l10n) =>
      l10n.partyDrinkQuickRecommendationsSubtitle;

  static String partyDrinkMockPiscola(AppLocalizations l10n) =>
      l10n.partyDrinkMockPiscola;

  static String partyDrinkMockPiscolaDesc(AppLocalizations l10n) =>
      l10n.partyDrinkMockPiscolaDesc;

  static String partyDrinkMockJagerBomb(AppLocalizations l10n) =>
      l10n.partyDrinkMockJagerBomb;

  static String partyDrinkMockJagerBombDesc(AppLocalizations l10n) =>
      l10n.partyDrinkMockJagerBombDesc;

  static String partyDrinkMockTropicalGin(AppLocalizations l10n) =>
      l10n.partyDrinkMockTropicalGin;

  static String partyDrinkMockTropicalGinDesc(AppLocalizations l10n) =>
      l10n.partyDrinkMockTropicalGinDesc;

  static String partyDrinkMockCubaLibre(AppLocalizations l10n) =>
      l10n.partyDrinkMockCubaLibre;

  static String partyDrinkMockCubaLibreDesc(AppLocalizations l10n) =>
      l10n.partyDrinkMockCubaLibreDesc;

  static String partyDrinkMockCorona(AppLocalizations l10n) =>
      l10n.partyDrinkMockCorona;

  static String partyDrinkMockCoronaDesc(AppLocalizations l10n) =>
      l10n.partyDrinkMockCoronaDesc;

  static String partyDrinkMockChandon(AppLocalizations l10n) =>
      l10n.partyDrinkMockChandon;

  static String partyDrinkMockChandonDesc(AppLocalizations l10n) =>
      l10n.partyDrinkMockChandonDesc;

  static String partyDrinkVolumeMl(AppLocalizations l10n, int volume) =>
      l10n.partyDrinkVolumeMl(volume);

  static String partyDrinkCheckoutPaymentMethod(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutPaymentMethod;

  static String partyDrinkCheckoutCreditCard(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutCreditCard;

  static String partyDrinkCheckoutCardMask(
    AppLocalizations l10n,
    String last4,
  ) =>
      l10n.partyDrinkCheckoutCardMask(last4);

  static String partyDrinkCheckoutProducts(AppLocalizations l10n, int count) =>
      l10n.partyDrinkCheckoutProducts(count);

  static String partyDrinkCheckoutBuy(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutBuy;

  static String partyDrinkCheckoutSummaryTitle(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutSummaryTitle;

  static String partyDrinkCheckoutSummarySubtitle(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutSummarySubtitle;

  static String partyDrinkCheckoutSubtotal(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutSubtotal;

  static String partyDrinkCheckoutServiceCharge(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutServiceCharge;

  static String partyDrinkCheckoutTotal(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutTotal;

  static String partyDrinkCheckoutChangePayment(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutChangePayment;

  static String partyDrinkCheckoutCompletePurchase(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutCompletePurchase;

  static String partyDrinkCheckoutSecurePayment(AppLocalizations l10n) =>
      l10n.partyDrinkCheckoutSecurePayment;

  static String partyDrinkPurchaseSuccessTitle(AppLocalizations l10n) =>
      l10n.partyDrinkPurchaseSuccessTitle;

  static String partyDrinkPurchaseSuccessSubtitle(AppLocalizations l10n) =>
      l10n.partyDrinkPurchaseSuccessSubtitle;

  static String partyDrinkPurchaseValidity(
    AppLocalizations l10n,
    String target,
  ) =>
      l10n.partyDrinkPurchaseValidity(target);

  static String partyDrinkPurchaseShowBartender(AppLocalizations l10n) =>
      l10n.partyDrinkPurchaseShowBartender;

  static String partyDrinkPurchasesTitle(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesTitle;

  static String partyDrinkPurchasesSubtitle(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesSubtitle;

  static String partyDrinkPurchasesTabPending(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesTabPending;

  static String partyDrinkPurchasesTabUsed(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesTabUsed;

  static String partyDrinkPurchasesOrderLabel(AppLocalizations l10n, String id) =>
      l10n.partyDrinkPurchasesOrderLabel(id);

  static String partyDrinkPurchasesQuantityLabel(
    AppLocalizations l10n,
    int count,
    String name,
  ) =>
      l10n.partyDrinkPurchasesQuantityLabel(count, name);

  static String partyDrinkPurchasesBoughtAgo(AppLocalizations l10n, String timeAgo) =>
      l10n.partyDrinkPurchasesBoughtAgo(timeAgo);

  static String partyDrinkPurchasesRedeemedAgo(AppLocalizations l10n, String timeAgo) =>
      l10n.partyDrinkPurchasesRedeemedAgo(timeAgo);

  static String partyDrinkPurchasesViewQr(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesViewQr;

  static String partyDrinkPurchasesRedeemedBadge(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesRedeemedBadge;

  static String partyDrinkPurchasesEmptyPending(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesEmptyPending;

  static String partyDrinkPurchasesEmptyUsed(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesEmptyUsed;

  static String partyDrinkPurchasesQrUnavailable(AppLocalizations l10n) =>
      l10n.partyDrinkPurchasesQrUnavailable;

  static String partyDrinkCourtesiesTitle(AppLocalizations l10n) =>
      l10n.partyDrinkCourtesiesTitle;

  static String partyDrinkCourtesiesSubtitle(AppLocalizations l10n) =>
      l10n.partyDrinkCourtesiesSubtitle;

  static String partyDrinkCourtesiesReceivedAgo(
    AppLocalizations l10n,
    String timeAgo,
  ) =>
      l10n.partyDrinkCourtesiesReceivedAgo(timeAgo);

  static String partyDrinkCourtesiesEmptyPending(AppLocalizations l10n) =>
      l10n.partyDrinkCourtesiesEmptyPending;

  static String partyDrinkCourtesiesEmptyUsed(AppLocalizations l10n) =>
      l10n.partyDrinkCourtesiesEmptyUsed;

  static String drawerInvitationsNewBadge(AppLocalizations l10n, int count) =>
      l10n.drawerInvitationsNewBadge(count);

  static String drawerTierGold(AppLocalizations l10n) => l10n.drawerTierGold;

  static String drawerTierSilver(AppLocalizations l10n) => l10n.drawerTierSilver;

  static String drawerTierBronze(AppLocalizations l10n) => l10n.drawerTierBronze;

  static String drawerTierPlatinum(AppLocalizations l10n) =>
      l10n.drawerTierPlatinum;

  static String profileTitle(AppLocalizations l10n) => l10n.profileTitle;

  static String profileViewBenefits(AppLocalizations l10n) =>
      l10n.profileViewBenefits;

  static String profilePersonalData(AppLocalizations l10n) =>
      l10n.profilePersonalData;

  static String profileFullName(AppLocalizations l10n) => l10n.profileFullName;

  static String profilePhone(AppLocalizations l10n) => l10n.profilePhone;

  static String profileChangePhone(AppLocalizations l10n) => l10n.profileChangePhone;

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

  static String profileSetDefaultCard(AppLocalizations l10n) =>
      l10n.profileSetDefaultCard;

  static String profileDeleteCard(AppLocalizations l10n) =>
      l10n.profileDeleteCard;

  static String profileDefaultCardUpdated(AppLocalizations l10n) =>
      l10n.profileDefaultCardUpdated;

  static String profileViewFullWallet(AppLocalizations l10n) =>
      l10n.profileViewFullWallet;

  static String profileWalletAvailableBalance(AppLocalizations l10n) =>
      l10n.profileWalletAvailableBalance;

  static String profileWalletCredits(AppLocalizations l10n, String amount) =>
      l10n.profileWalletCredits(amount);

  static String profileWalletTransactionHistory(AppLocalizations l10n) =>
      l10n.profileWalletTransactionHistory;

  static String profileWalletNoTransactions(AppLocalizations l10n) =>
      l10n.profileWalletNoTransactions;

  static String profileWalletDefaultDeleteRequired(AppLocalizations l10n) =>
      l10n.profileWalletDefaultDeleteRequired;

  static String profileWalletSelectNewDefault(AppLocalizations l10n) =>
      l10n.profileWalletSelectNewDefault;

  static String profileWalletAddCard(AppLocalizations l10n) =>
      l10n.profileWalletAddCard;

  static String profileNotifications(AppLocalizations l10n) =>
      l10n.profileNotifications;

  static String profileReceiveNotifications(AppLocalizations l10n) =>
      l10n.profileReceiveNotifications;

  static String profileNotificationChannels(AppLocalizations l10n) =>
      l10n.profileNotificationChannels;

  static String profileNotificationChannelEmail(AppLocalizations l10n) =>
      l10n.profileNotificationChannelEmail;

  static String profileNotificationChannelEmailDesc(AppLocalizations l10n) =>
      l10n.profileNotificationChannelEmailDesc;

  static String profileNotificationChannelPush(AppLocalizations l10n) =>
      l10n.profileNotificationChannelPush;

  static String profileNotificationChannelPushDesc(AppLocalizations l10n) =>
      l10n.profileNotificationChannelPushDesc;

  static String profileNotificationChannelWhatsApp(AppLocalizations l10n) =>
      l10n.profileNotificationChannelWhatsApp;

  static String profileNotificationChannelWhatsAppDesc(AppLocalizations l10n) =>
      l10n.profileNotificationChannelWhatsAppDesc;

  static String profileNotificationAdvancedSettings(AppLocalizations l10n) =>
      l10n.profileNotificationAdvancedSettings;

  static String profileNotificationCriticalDisclaimer(AppLocalizations l10n) =>
      l10n.profileNotificationCriticalDisclaimer;

  static String profileNotificationAdvancedTitle(AppLocalizations l10n) =>
      l10n.profileNotificationAdvancedTitle;

  static String profileNotificationByType(AppLocalizations l10n) =>
      l10n.profileNotificationByType;

  static String profileNotificationTypePurchases(AppLocalizations l10n) =>
      l10n.profileNotificationTypePurchases;

  static String profileNotificationTypeReminders(AppLocalizations l10n) =>
      l10n.profileNotificationTypeReminders;

  static String profileNotificationTypePromotions(AppLocalizations l10n) =>
      l10n.profileNotificationTypePromotions;

  static String profileNotificationTypeSocial(AppLocalizations l10n) =>
      l10n.profileNotificationTypeSocial;

  static String profileNotificationByChannel(AppLocalizations l10n) =>
      l10n.profileNotificationByChannel;

  static String profileNotificationNightSilence(AppLocalizations l10n) =>
      l10n.profileNotificationNightSilence;

  static String profileNotificationNightSilenceDesc(AppLocalizations l10n) =>
      l10n.profileNotificationNightSilenceDesc;

  static String profileNotificationNightSilenceFrom(AppLocalizations l10n) =>
      l10n.profileNotificationNightSilenceFrom;

  static String profileNotificationCriticalTitle(AppLocalizations l10n) =>
      l10n.profileNotificationCriticalTitle;

  static String profileNotificationCriticalLabel(
    AppLocalizations l10n,
    String key,
  ) {
    switch (key) {
      case 'event_cancellation':
        return l10n.profileNotificationCriticalEventCancellation;
      case 'event_datetime_change':
        return l10n.profileNotificationCriticalEventDatetime;
      case 'event_venue_change':
        return l10n.profileNotificationCriticalEventVenue;
      case 'security_alerts':
        return l10n.profileNotificationCriticalSecurity;
      case 'payment_receipts':
        return l10n.profileNotificationCriticalPaymentReceipts;
      case 'processed_refunds':
        return l10n.profileNotificationCriticalRefunds;
      default:
        return key;
    }
  }

  static String profileNotificationUpdateFailed(AppLocalizations l10n) =>
      l10n.profileNotificationUpdateFailed;

  static String profileNotificationTypeLabel(
    AppLocalizations l10n,
    NotificationTypeKey type,
  ) {
    switch (type) {
      case NotificationTypeKey.purchases:
        return profileNotificationTypePurchases(l10n);
      case NotificationTypeKey.reminders:
        return profileNotificationTypeReminders(l10n);
      case NotificationTypeKey.promotions:
        return profileNotificationTypePromotions(l10n);
      case NotificationTypeKey.social:
        return profileNotificationTypeSocial(l10n);
    }
  }

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

  static String profileCompleteBannerTitle(AppLocalizations l10n) =>
      l10n.profileCompleteBannerTitle;

  static String profileCompleteBannerSubtitleBoth(AppLocalizations l10n) =>
      l10n.profileCompleteBannerSubtitleBoth;

  static String profileCompleteBannerSubtitlePhoto(AppLocalizations l10n) =>
      l10n.profileCompleteBannerSubtitlePhoto;

  static String profileCompleteBannerSubtitleInstagram(AppLocalizations l10n) =>
      l10n.profileCompleteBannerSubtitleInstagram;

  static String profileCompleteBannerButton(AppLocalizations l10n) =>
      l10n.profileCompleteBannerButton;

  static String profilePhotoChooseSource(AppLocalizations l10n) =>
      l10n.profilePhotoChooseSource;

  static String profilePhotoTake(AppLocalizations l10n) => l10n.profilePhotoTake;

  static String profilePhotoGallery(AppLocalizations l10n) =>
      l10n.profilePhotoGallery;

  static String profileNotAdded(AppLocalizations l10n) => l10n.profileNotAdded;

  static String profileEditTitle(AppLocalizations l10n) => l10n.profileEditTitle;

  static String profileSave(AppLocalizations l10n) => l10n.profileSave;

  static String profileSaved(AppLocalizations l10n) => l10n.profileSaved;

  static String profileGenderFemaleValue(AppLocalizations l10n) =>
      l10n.profileGenderFemaleValue;

  static String profileGenderOtherValue(AppLocalizations l10n) =>
      l10n.profileGenderOtherValue;

  static String profileGenderPreferNotSayValue(AppLocalizations l10n) =>
      l10n.profileGenderPreferNotSayValue;

  static String profileCategoryBenefits(AppLocalizations l10n) =>
      l10n.profileCategoryBenefits;

  static String profileFaqTitle(AppLocalizations l10n) => l10n.profileFaqTitle;

  static String profileFaqSearch(AppLocalizations l10n) => l10n.profileFaqSearch;

  static String profileFaqHelpful(AppLocalizations l10n) =>
      l10n.profileFaqHelpful;

  static String profileFaqYes(AppLocalizations l10n) => l10n.profileFaqYes;

  static String profileFaqNo(AppLocalizations l10n) => l10n.profileFaqNo;

  static String profileFaqNoResults(AppLocalizations l10n) =>
      l10n.profileFaqNoResults;

  static String profileFaqContactWhatsApp(AppLocalizations l10n) =>
      l10n.profileFaqContactWhatsApp;

  static String profileFaqContactEmail(AppLocalizations l10n) =>
      l10n.profileFaqContactEmail;

  static String profileWhatsAppNotInstalled(AppLocalizations l10n) =>
      l10n.profileWhatsAppNotInstalled;

  static String profileDeleteInfoTitle(AppLocalizations l10n) =>
      l10n.profileDeleteInfoTitle;

  static String profileDeleteInfoMessage(AppLocalizations l10n) =>
      l10n.profileDeleteInfoMessage;

  static String profileDeleteContinue(AppLocalizations l10n) =>
      l10n.profileDeleteContinue;

  static String profileDeleteInfoIntro(AppLocalizations l10n) =>
      l10n.profileDeleteInfoIntro;

  static String profileDeleteItemPersonalData(AppLocalizations l10n) =>
      l10n.profileDeleteItemPersonalData;

  static String profileDeleteItemTickets(AppLocalizations l10n) =>
      l10n.profileDeleteItemTickets;

  static String profileDeleteItemPaymentMethods(AppLocalizations l10n) =>
      l10n.profileDeleteItemPaymentMethods;

  static String profileDeleteItemPoints(AppLocalizations l10n) =>
      l10n.profileDeleteItemPoints;

  static String profileDeleteItemHistory(AppLocalizations l10n) =>
      l10n.profileDeleteItemHistory;

  static String profileDeleteIrreversibleWarning(AppLocalizations l10n) =>
      l10n.profileDeleteIrreversibleWarning;

  static String profileDeletePendingMessage(AppLocalizations l10n, int days) =>
      l10n.profileDeletePendingMessage(days);

  static String accountDeletionBiometricReason(AppLocalizations l10n) =>
      l10n.accountDeletionBiometricReason;

  static String accountDeletionBiometricFailed(AppLocalizations l10n) =>
      l10n.accountDeletionBiometricFailed;

  static String accountDeletionPendingBannerTitle(AppLocalizations l10n) =>
      l10n.accountDeletionPendingBannerTitle;

  static String accountDeletionPendingBannerSubtitle(
    AppLocalizations l10n,
    String date,
    int days,
  ) =>
      l10n.accountDeletionPendingBannerSubtitle(date, days);

  static String accountDeletionCancelAction(AppLocalizations l10n) =>
      l10n.accountDeletionCancelAction;

  static String accountDeletionCancelled(AppLocalizations l10n) =>
      l10n.accountDeletionCancelled;

  static String profileEmailSubject(AppLocalizations l10n) =>
      l10n.profileEmailSubject;

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

  static String ticketsStatusValidated(AppLocalizations l10n) =>
      l10n.ticketsStatusValidated;

  static String ticketsStatusExpired(AppLocalizations l10n) =>
      l10n.ticketsStatusExpired;

  static String ticketsStatusCancelled(AppLocalizations l10n) =>
      l10n.ticketsStatusCancelled;

  static String ticketsStatusRefunded(AppLocalizations l10n) =>
      l10n.ticketsStatusRefunded;

  static String ticketsInvitationPending(AppLocalizations l10n) =>
      l10n.ticketsInvitationPending;

  static String ticketsInvitationExpires(
    AppLocalizations l10n,
    String deadline,
  ) =>
      l10n.ticketsInvitationExpires(deadline);

  static String ticketsQrCountdown(
    AppLocalizations l10n,
    String eventDate,
  ) =>
      l10n.ticketsQrCountdown(eventDate);

  static String ticketsQrUnavailable(AppLocalizations l10n) =>
      l10n.ticketsQrUnavailable;

  static String ticketsCancelTicket(AppLocalizations l10n) =>
      l10n.ticketsCancelTicket;

  static String ticketsCancelTicketTitle(AppLocalizations l10n) =>
      l10n.ticketsCancelTicketTitle;

  static String ticketsCancelTicketMessage(AppLocalizations l10n) =>
      l10n.ticketsCancelTicketMessage;

  static String ticketsCancelTicketConfirm(AppLocalizations l10n) =>
      l10n.ticketsCancelTicketConfirm;

  static String ticketsCancelTicketSuccess(AppLocalizations l10n) =>
      l10n.ticketsCancelTicketSuccess;

  static String bottomNavHome(AppLocalizations l10n) => l10n.bottomNavHome;

  static String bottomNavInvitations(AppLocalizations l10n) =>
      l10n.bottomNavInvitations;

  static String bottomNavTickets(AppLocalizations l10n) => l10n.bottomNavTickets;

  static String ticketsViewQr(AppLocalizations l10n) => l10n.ticketsViewQr;

  static String ticketsAssignEntries(AppLocalizations l10n) =>
      l10n.ticketsAssignEntries;

  static String ticketsAssignVip(AppLocalizations l10n) => l10n.ticketsAssignVip;

  static String ticketsViewAssigned(AppLocalizations l10n) =>
      l10n.ticketsViewAssigned;

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

  static String ticketAssignmentClaimedCount(AppLocalizations l10n, int count) =>
      l10n.ticketAssignmentClaimedCount(count);

  static String ticketAssignmentSentSectionTitle(AppLocalizations l10n) =>
      l10n.ticketAssignmentSentSectionTitle;

  static String ticketAssignmentSendNewSectionTitle(AppLocalizations l10n) =>
      l10n.ticketAssignmentSendNewSectionTitle;

  static String ticketAssignmentSendNewSectionSubtitle(
    AppLocalizations l10n,
    int count,
  ) =>
      l10n.ticketAssignmentSendNewSectionSubtitle(count);

  static String ticketAssignmentAcceptedBadge(AppLocalizations l10n) =>
      l10n.ticketAssignmentAcceptedBadge;

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

  static String ticketAssignmentSearchGuestTitle(AppLocalizations l10n) =>
      l10n.ticketAssignmentSearchGuestTitle;

  static String ticketAssignmentSearchGuestSubtitle(AppLocalizations l10n) =>
      l10n.ticketAssignmentSearchGuestSubtitle;

  static String ticketAssignmentSearchGuestHint(AppLocalizations l10n) =>
      l10n.ticketAssignmentSearchGuestHint;

  static String ticketAssignmentSearchGuestEmpty(AppLocalizations l10n) =>
      l10n.ticketAssignmentSearchGuestEmpty;

  static String ticketAssignmentSearchGuestManualHint(AppLocalizations l10n) =>
      l10n.ticketAssignmentSearchGuestManualHint;

  static String ticketAssignmentRegisteredBadge(AppLocalizations l10n) =>
      l10n.ticketAssignmentRegisteredBadge;

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

  static String vipTicketSelectionTitle(AppLocalizations l10n) =>
      l10n.vipTicketSelectionTitle;

  static String vipTicketSelectionHeading(AppLocalizations l10n) =>
      l10n.vipTicketSelectionHeading;

  static String vipSectionGeneralTickets(AppLocalizations l10n) =>
      l10n.vipSectionGeneralTickets;

  static String vipSectionVipTables(AppLocalizations l10n) =>
      l10n.vipSectionVipTables;

  static String vipSectionVipTickets(AppLocalizations l10n) =>
      l10n.vipSectionVipTickets;

  static String vipOfferingPreventa1(AppLocalizations l10n) =>
      l10n.vipOfferingPreventa1;

  static String vipOfferingPreventa2(AppLocalizations l10n) =>
      l10n.vipOfferingPreventa2;

  static String vipOfferingGeneral(AppLocalizations l10n) =>
      l10n.vipOfferingGeneral;

  static String vipOfferingGeneralCover(AppLocalizations l10n) =>
      l10n.vipOfferingGeneralCover;

  static String vipOfferingVipGeneral(AppLocalizations l10n) =>
      l10n.vipOfferingVipGeneral;

  static String vipOfferingWithoutTable(AppLocalizations l10n) =>
      l10n.vipOfferingWithoutTable;

  static String vipOfferingGeneralAccessDescription(AppLocalizations l10n) =>
      l10n.vipOfferingGeneralAccessDescription;

  static String vipTicketCount(AppLocalizations l10n, int count) =>
      l10n.vipTicketCount(count);

  static String vipTicketSelectionSummaryLine(
    AppLocalizations l10n,
    String ticketCount,
    String amount,
  ) =>
      l10n.vipTicketSelectionSummaryLine(ticketCount, amount);

  static String vipContinueWithTickets(
    AppLocalizations l10n,
    String ticketCount,
  ) =>
      l10n.vipContinueWithTickets(ticketCount);

  static String vipBackButton(AppLocalizations l10n) => l10n.vipBackButton;

  static String vipContinueButton(AppLocalizations l10n) =>
      l10n.vipContinueButton;

  static String vipContinueWithAmount(AppLocalizations l10n, String amount) =>
      l10n.vipContinueWithAmount(amount);

  static String vipTicketSoldOutBadge(AppLocalizations l10n) =>
      l10n.vipTicketSoldOutBadge;

  static String vipTicketsNoneAvailable(AppLocalizations l10n) =>
      l10n.vipTicketsNoneAvailable;

  static String vipTicketsAllSoldOut(AppLocalizations l10n) =>
      l10n.vipTicketsAllSoldOut;

  static String vipSecurePayment(AppLocalizations l10n) => l10n.vipSecurePayment;

  static String vipMesasVipTitle(AppLocalizations l10n) =>
      l10n.vipMesasVipTitle;

  static String vipMesasVipSubtitle(AppLocalizations l10n) =>
      l10n.vipMesasVipSubtitle;

  static String vipFloorPlanTitle(AppLocalizations l10n) =>
      l10n.vipFloorPlanTitle;

  static String vipFloorPlanHeading(AppLocalizations l10n) =>
      l10n.vipFloorPlanHeading;

  static String vipFloorPlanVenueName(AppLocalizations l10n) =>
      l10n.vipFloorPlanVenueName;

  static String vipFloorPlanDimensions(AppLocalizations l10n) =>
      l10n.vipFloorPlanDimensions;

  static String vipFloorPlanSize(AppLocalizations l10n) => l10n.vipFloorPlanSize;

  static String vipFloorPlanSubtitle(
    AppLocalizations l10n,
    String venue,
    String size,
  ) =>
      l10n.vipFloorPlanSubtitle(venue, size);

  static String vipTapVipZoneTitle(AppLocalizations l10n) =>
      l10n.vipTapVipZoneTitle;

  static String vipTapVipZoneSubtitle(AppLocalizations l10n) =>
      l10n.vipTapVipZoneSubtitle;

  static String vipYouFestBrand(AppLocalizations l10n) => l10n.vipYouFestBrand;

  static String vipLegendAvailable(AppLocalizations l10n) =>
      l10n.vipLegendAvailable;

  static String vipLegendPremium(AppLocalizations l10n) =>
      l10n.vipLegendPremium;

  static String vipLegendSold(AppLocalizations l10n) => l10n.vipLegendSold;

  static String vipLegendUnselected(AppLocalizations l10n) =>
      l10n.vipLegendUnselected;

  static String vipTablesZoneTitle(AppLocalizations l10n) =>
      l10n.vipTablesZoneTitle;

  static String vipZoneTablesScreenTitle(AppLocalizations l10n, String zone) =>
      l10n.vipZoneTablesScreenTitle(zone);

  static String vipTablesZoneSoldOut(AppLocalizations l10n) =>
      l10n.vipTablesZoneSoldOut;

  static String vipTablePremiumBadge(AppLocalizations l10n) =>
      l10n.vipTablePremiumBadge;

  static String vipTablesCapacitySubtitle(AppLocalizations l10n, int count) =>
      l10n.vipTablesCapacitySubtitle(count);

  static String vipPurchaseOfferingLine(
    AppLocalizations l10n,
    String label,
    int quantity,
  ) =>
      l10n.vipPurchaseOfferingLine(label, quantity);

  static String vipTableReserve(AppLocalizations l10n, String table) =>
      l10n.vipTableReserve(table);

  static String vipTableDetailTitle(
    AppLocalizations l10n,
    String table,
    String zone,
  ) =>
      l10n.vipTableDetailTitle(table, zone);

  static String vipTableCapacity(AppLocalizations l10n, int count) =>
      l10n.vipTableCapacity(count);

  static String vipTableIncludes(
    AppLocalizations l10n,
    int bottles,
    int vouchers,
  ) =>
      l10n.vipTableIncludes(bottles, vouchers);

  static String vipTableBottles(AppLocalizations l10n, int count) =>
      l10n.vipTableBottles(count);

  static String vipTableVouchers(AppLocalizations l10n, int count) =>
      l10n.vipTableVouchers(count);

  static String vipPurchaseSummaryTitle(AppLocalizations l10n) =>
      l10n.vipPurchaseSummaryTitle;

  static String vipServiceFee(AppLocalizations l10n) => l10n.vipServiceFee;

  static String vipPurchaseSubtotal(AppLocalizations l10n) =>
      l10n.vipPurchaseSubtotal;

  static String vipPurchaseServiceCharge(AppLocalizations l10n) =>
      l10n.vipPurchaseServiceCharge;

  static String vipGeneralAccessLabel(AppLocalizations l10n) =>
      l10n.vipGeneralAccessLabel;

  static String vipVoucherCount(AppLocalizations l10n, int count) =>
      l10n.vipVoucherCount(count);

  static String vipPurchaseTicketDetailsLine(
    AppLocalizations l10n,
    String entries,
    String access,
    String vouchers,
  ) =>
      l10n.vipPurchaseTicketDetailsLine(entries, access, vouchers);

  static String vipTotal(AppLocalizations l10n) => l10n.vipPurchaseTotal;

  static String vipPaymentMethod(AppLocalizations l10n) =>
      l10n.vipPaymentMethod;

  static String vipSavedCard(AppLocalizations l10n) => l10n.vipSavedCard;

  static String vipAddPaymentMethod(AppLocalizations l10n) =>
      l10n.vipAddPaymentMethod;

  static String vipPayButton(AppLocalizations l10n, String amount) =>
      l10n.vipPayButton(amount);

  static String vipPurchaseSuccessTitle(AppLocalizations l10n) =>
      l10n.vipPurchaseSuccessTitle;

  static String vipPurchaseSuccessMessage(AppLocalizations l10n) =>
      l10n.vipPurchaseSuccessMessage;

  static String vipTableLockCountdown(AppLocalizations l10n, String time) =>
      l10n.vipTableLockCountdown(time);

  static String vipTableLockReservedCountdown(AppLocalizations l10n, String time) =>
      l10n.vipTableLockReservedCountdown(time);

  static String vipTableLockExpired(AppLocalizations l10n) =>
      l10n.vipTableLockExpired;

  static String vipTableLockExpiredTitle(AppLocalizations l10n) =>
      l10n.vipTableLockExpiredTitle;

  static String vipTableLockExpiredMessage(AppLocalizations l10n) =>
      l10n.vipTableLockExpiredMessage;

  static String vipTableLockExpiredReturnFloorPlan(AppLocalizations l10n) =>
      l10n.vipTableLockExpiredReturnFloorPlan;

  static String vipTableBlockedMessage(AppLocalizations l10n) =>
      l10n.vipTableBlockedMessage;

  static String vipTableBlockedReserve(AppLocalizations l10n) =>
      l10n.vipTableBlockedReserve;

  static String eventDetailTicketsUnavailable(AppLocalizations l10n) =>
      l10n.eventDetailTicketsUnavailable;

  static String vipViewQr(AppLocalizations l10n) => l10n.vipViewQr;

  static String vipZoneLabel(AppLocalizations l10n) => l10n.vipZoneLabel;

  static String vipZone1Name(AppLocalizations l10n) => l10n.vipZone1Name;

  static String vipZone2Name(AppLocalizations l10n) => l10n.vipZone2Name;

  static String vipZoneDj(AppLocalizations l10n) => l10n.vipZoneDj;

  static String vipZoneStage(AppLocalizations l10n) => l10n.vipZoneStage;

  static String vipZoneDanceFloor(AppLocalizations l10n) =>
      l10n.vipZoneDanceFloor;

  static String vipZoneCapacity(AppLocalizations l10n, int count) =>
      l10n.vipZoneCapacity(count);

  static String vipEmergencyExit(AppLocalizations l10n) =>
      l10n.vipEmergencyExit;

  static String vipLegendAvailableShort(AppLocalizations l10n) =>
      l10n.vipLegendAvailableShort;

  static String vipDanceFloorGeneral(AppLocalizations l10n) =>
      l10n.vipDanceFloorGeneral;

  static String vipTableDistributionTitle(
    AppLocalizations l10n,
    String zone,
  ) =>
      l10n.vipTableDistributionTitle(zone);

  static String vipTableDistributionStage(AppLocalizations l10n) =>
      l10n.vipTableDistributionStage;

  static String vipLegendTableAvailable(AppLocalizations l10n) =>
      l10n.vipLegendTableAvailable;

  static String vipLegendTablePremium(AppLocalizations l10n) =>
      l10n.vipLegendTablePremium;

  static String vipLegendTableSelection(AppLocalizations l10n) =>
      l10n.vipLegendTableSelection;

  static String vipLegendTableSold(AppLocalizations l10n) =>
      l10n.vipLegendTableSold;

  static String vipLegendTableBlocked(AppLocalizations l10n) =>
      l10n.vipLegendTableBlocked;

  static String vipTableIncludesShort(
    AppLocalizations l10n,
    String people,
    String bottles,
    String vouchers,
  ) =>
      l10n.vipTableIncludesShort(people, bottles, vouchers);

  static String vipPurchaseSummaryItemTitle(
    AppLocalizations l10n,
    String table,
    String zone,
    String event,
  ) =>
      l10n.vipPurchaseSummaryItemTitle(table, zone, event);

  static String vipPurchaseTotal(AppLocalizations l10n) => l10n.vipPurchaseTotal;

  static String vipPurchaseAssignTicketsInfo(
    AppLocalizations l10n,
    String myTickets,
  ) =>
      l10n.vipPurchaseAssignTicketsInfo(myTickets);

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

  static String favoritesYoufestDescription(AppLocalizations l10n) =>
      l10n.favoritesYoufestDescription;

  static String favoritesIguanaDescription(AppLocalizations l10n) =>
      l10n.favoritesIguanaDescription;

  static String favoritesFollowerCount(AppLocalizations l10n, String count) =>
      l10n.favoritesFollowerCount(count);

  static String favoritesNoSearchResults(AppLocalizations l10n) =>
      l10n.favoritesNoSearchResults;

  static String favoritesExploreCta(AppLocalizations l10n) =>
      l10n.favoritesExploreCta;

  static String favoritesSectionFollowedPromoters(AppLocalizations l10n) =>
      l10n.favoritesSectionFollowedPromoters;

  static String favoritesSectionSavedEvents(AppLocalizations l10n) =>
      l10n.favoritesSectionSavedEvents;

  static String producerEventsUpcomingTitle(AppLocalizations l10n) =>
      l10n.producerEventsUpcomingTitle;

  static String producerEventsUpcomingSubtitle(
    AppLocalizations l10n,
    String producerName,
  ) =>
      l10n.producerEventsUpcomingSubtitle(producerName);

  static String producerEventsSearchHint(AppLocalizations l10n) =>
      l10n.producerEventsSearchHint;

  static String producerEventsEmpty(AppLocalizations l10n) =>
      l10n.producerEventsEmpty;

  static String producerEventBuyTicket(AppLocalizations l10n) =>
      l10n.producerEventBuyTicket;

  static String producerEventPresale(AppLocalizations l10n) =>
      l10n.producerEventPresale;

  static String producerEventPrepay(AppLocalizations l10n) =>
      l10n.producerEventPrepay;

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

  static String invitationsFiltersLabel(AppLocalizations l10n) =>
      l10n.invitationsFiltersLabel;

  static String invitationsFilterCourtesy(AppLocalizations l10n) =>
      l10n.invitationsFilterCourtesy;

  static String invitationsFilterAll(AppLocalizations l10n) =>
      l10n.invitationsFilterAll;

  static String invitationsFilterFree(AppLocalizations l10n) =>
      l10n.invitationsFilterFree;

  static String invitationsFilterGuaranteedPass(AppLocalizations l10n) =>
      l10n.invitationsFilterGuaranteedPass;

  static String invitationsFilterDiscounted(AppLocalizations l10n) =>
      l10n.invitationsFilterDiscounted;

  static String invitationsTypeFree(AppLocalizations l10n) =>
      l10n.invitationsTypeFree;

  static String invitationsTypeAssigned(AppLocalizations l10n) =>
      l10n.invitationsTypeAssigned;

  static String invitationsTypeVip(AppLocalizations l10n) =>
      l10n.invitationsTypeVip;

  static String invitationsTypeGuaranteedPass(AppLocalizations l10n) =>
      l10n.invitationsTypeGuaranteedPass;

  static String invitationsTypeDiscounted(AppLocalizations l10n) =>
      l10n.invitationsTypeDiscounted;

  static String invitationsGuaranteedPassTitle(AppLocalizations l10n) =>
      l10n.invitationsGuaranteedPassTitle;

  static String invitationsGuaranteedPassMessage(
    AppLocalizations l10n,
    String deadline,
    String amount,
  ) =>
      l10n.invitationsGuaranteedPassMessage(deadline, amount);

  static String invitationsGuaranteedPassTerms(AppLocalizations l10n) =>
      l10n.invitationsGuaranteedPassTerms;

  static String invitationsGpTermsRequired(AppLocalizations l10n) =>
      l10n.invitationsGpTermsRequired;

  static String invitationsPreauthNotice(AppLocalizations l10n, String amount) =>
      l10n.invitationsPreauthNotice(amount);

  static String invitationsDiscountedPayTitle(AppLocalizations l10n) =>
      l10n.invitationsDiscountedPayTitle;

  static String invitationsDiscountedPayMessage(
    AppLocalizations l10n,
    String amount,
  ) =>
      l10n.invitationsDiscountedPayMessage(amount);

  static String invitationsDiscountPercent(AppLocalizations l10n, int percent) =>
      l10n.invitationsDiscountPercent(percent);

  static String invitationsCancelBy(AppLocalizations l10n, String deadline) =>
      l10n.invitationsCancelBy(deadline);

  static String invitationsAcceptGuaranteed(AppLocalizations l10n) =>
      l10n.invitationsAcceptGuaranteed;

  static String invitationsAcceptAndReserve(AppLocalizations l10n) =>
      l10n.invitationsAcceptAndReserve;

  static String invitationsGuaranteedPassDetailTitle(AppLocalizations l10n) =>
      l10n.invitationsGuaranteedPassDetailTitle;

  static String invitationsDetailTitle(AppLocalizations l10n) =>
      l10n.invitationsDetailTitle;

  static String invitationsGuaranteedBadge(AppLocalizations l10n) =>
      l10n.invitationsGuaranteedBadge;

  static String invitationsAssignedSlot(AppLocalizations l10n, String slot) =>
      l10n.invitationsAssignedSlot(slot);

  static String invitationsPassStatus(AppLocalizations l10n, String status) =>
      l10n.invitationsPassStatus(status);

  static String invitationsGpWarningTitle(AppLocalizations l10n) =>
      l10n.invitationsGpWarningTitle;

  static String invitationsGpWarningBody(
    AppLocalizations l10n,
    String amount,
    String deadline,
  ) =>
      l10n.invitationsGpWarningBody(amount, deadline);

  static String invitationsBiometricReason(AppLocalizations l10n) =>
      l10n.invitationsBiometricReason;

  static String invitationsGpPaymentRequired(AppLocalizations l10n) =>
      l10n.invitationsGpPaymentRequired;

  static String invitationsGpActiveTitle(AppLocalizations l10n) =>
      l10n.invitationsGpActiveTitle;

  static String invitationsGpActiveMessage(
    AppLocalizations l10n,
    String event,
    String deadline,
  ) =>
      l10n.invitationsGpActiveMessage(event, deadline);

  static String invitationsGpActiveCta(AppLocalizations l10n) =>
      l10n.invitationsGpActiveCta;

  static String invitationsCancelInvitation(AppLocalizations l10n) =>
      l10n.invitationsCancelInvitation;

  static String invitationsGpCancelTitle(AppLocalizations l10n) =>
      l10n.invitationsGpCancelTitle;

  static String invitationsGpCancelMessage(AppLocalizations l10n) =>
      l10n.invitationsGpCancelMessage;

  static String invitationsGpCancelConfirm(AppLocalizations l10n) =>
      l10n.invitationsGpCancelConfirm;

  static String invitationsGpCancelSuccess(AppLocalizations l10n) =>
      l10n.invitationsGpCancelSuccess;

  static String invitationsAcceptDiscounted(AppLocalizations l10n) =>
      l10n.invitationsAcceptDiscounted;

  static String invitationsFilterGeneral(AppLocalizations l10n) =>
      l10n.invitationsFilterGeneral;

  static String invitationsFilterVip(AppLocalizations l10n) =>
      l10n.invitationsFilterVip;

  static String invitationsTierVipDj(AppLocalizations l10n) =>
      l10n.invitationsTierVipDj;

  static String invitationsTierVip(AppLocalizations l10n) =>
      l10n.invitationsTierVip;

  static String invitationsTierGeneral(AppLocalizations l10n) =>
      l10n.invitationsTierGeneral;

  static String invitationsTierFree(AppLocalizations l10n) =>
      l10n.invitationsTierFree;

  static String invitationsInvitedBy(AppLocalizations l10n, String name) =>
      l10n.invitationsInvitedBy(name);

  static String invitationsAcceptBy(AppLocalizations l10n, String deadline) =>
      l10n.invitationsAcceptBy(deadline);

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

  static String invitationsFilterTables(AppLocalizations l10n) =>
      l10n.invitationsFilterTables;

  static String invitationsTabPending(AppLocalizations l10n) =>
      l10n.invitationsTabPending;

  static String invitationsTabConfirmed(AppLocalizations l10n) =>
      l10n.invitationsTabConfirmed;

  static String invitationsEmptyNone(AppLocalizations l10n) =>
      l10n.invitationsEmptyNone;

  static String invitationsEmptySearch(AppLocalizations l10n) =>
      l10n.invitationsEmptySearch;

  static String invitationsEmptyPending(AppLocalizations l10n) =>
      l10n.invitationsEmptyPending;

  static String invitationsEmptyConfirmed(AppLocalizations l10n) =>
      l10n.invitationsEmptyConfirmed;

  static String invitationsRejectConfirmTitle(AppLocalizations l10n) =>
      l10n.invitationsRejectConfirmTitle;

  static String invitationsRejectConfirmMessage(AppLocalizations l10n) =>
      l10n.invitationsRejectConfirmMessage;

  static String invitationsRejectConfirmAction(AppLocalizations l10n) =>
      l10n.invitationsRejectConfirmAction;

  static String invitationsCancellationDeadlinePassed(AppLocalizations l10n) =>
      l10n.invitationsCancellationDeadlinePassed;

  static String invitationsWaitingConfirmation(AppLocalizations l10n) =>
      l10n.invitationsWaitingConfirmation;

  static String invitationsQrAvailableOn(AppLocalizations l10n, String date) =>
      l10n.invitationsQrAvailableOn(date);

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

  static String invitationsDialogCancel(AppLocalizations l10n) =>
      l10n.invitationsDialogCancel;

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

  static String waitlistJoinButton(AppLocalizations l10n) => l10n.waitlistJoinButton;

  static String waitlistLeave(AppLocalizations l10n) => l10n.waitlistLeaveButton;

  static String waitlistJoinTitle(AppLocalizations l10n) => l10n.waitlistJoinTitle;

  static String waitlistJoinConfirm(AppLocalizations l10n) => l10n.waitlistJoinConfirm;

  static String waitlistJoinSuccess(AppLocalizations l10n, String eventName) =>
      l10n.waitlistJoinSuccess(eventName);

  static String waitlistEstimatedPosition(AppLocalizations l10n, String position) =>
      l10n.waitlistEstimatedPosition(position);

  static String waitlistLeaveTitle(AppLocalizations l10n) => l10n.waitlistLeaveTitle;

  static String waitlistLeaveMessage(AppLocalizations l10n) => l10n.waitlistLeaveMessage;

  static String waitlistLeaveConfirm(AppLocalizations l10n) => l10n.waitlistLeaveConfirm;

  static String waitlistClaimSlot(AppLocalizations l10n) => l10n.waitlistClaimSlot;

  static String waitlistOfferBanner(AppLocalizations l10n, String time) =>
      l10n.waitlistOfferBanner(time);

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
