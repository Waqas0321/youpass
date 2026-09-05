// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeBackTitle => 'WELCOME BACK';

  @override
  String get phoneLoginSubtitle =>
      'Sign in with your number and receive your code via WhatsApp';

  @override
  String get codeSentWhatsApp => 'Code sent to your WhatsApp';

  @override
  String get codeSentSms => 'Code sent via SMS';

  @override
  String get phoneNumberLabel => 'PHONE NUMBER';

  @override
  String get sendCodeButton => 'SEND CODE';

  @override
  String get createAccountLink => 'Create account';

  @override
  String get verificationCodeTitle => 'VERIFICATION CODE';

  @override
  String get verificationCodeSentPrefix => 'We sent a code to ';

  @override
  String get verificationCodeSentViaSms => ' via SMS ';

  @override
  String get verificationCodeSentViaWhatsApp => ' via WhatsApp ';

  @override
  String get validateCodeButton => 'VALIDATE CODE';

  @override
  String get resendCodePrefix => 'Resend code in ';

  @override
  String get resendCodeAction => 'Resend code';

  @override
  String get incorrectNumberQuestion => 'INCORRECT NUMBER?';

  @override
  String get changeNumberLink => 'CHANGE NUMBER';

  @override
  String get otpWhatsAppHelp =>
      'Didn\'t get the code? Make sure WhatsApp is installed on your phone. YouPass uses WhatsApp to send security codes. If you have problems, contact support: soporte@youpass.app';

  @override
  String get selectCountryTitle => 'Select your country';

  @override
  String get searchCountryHint => 'Search country or code';

  @override
  String get searchCountryEmpty => 'No countries found';

  @override
  String get homeTitle => 'Home';

  @override
  String homeGreeting(String name) {
    return 'Hi, $name!';
  }

  @override
  String get homeDiscoverSubtitle => 'Discover the best events for you';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryChile => 'Chile';

  @override
  String get categoryParties => 'Parties';

  @override
  String get categoryConcerts => 'Concerts';

  @override
  String get categorySports => 'Sports';

  @override
  String get featuredEventTitle => 'FESTIVAL PRIMAVERA — 2026 —';

  @override
  String get featuredEventDate => 'NOVEMBER 21, 2026 • 5:00 PM';

  @override
  String get featuredEventLocation => 'BICENTENNIAL PARK, SANTIAGO';

  @override
  String get eventsSectionTitle => 'Featured events';

  @override
  String get homeNoEventsFound => 'No events found for this filter';

  @override
  String get homeEventsEndOfList => 'You\'ve seen all available events.';

  @override
  String get homeNearMeButton => 'See events near my location';

  @override
  String get homeNearMeHeaderLink => 'Nearby';

  @override
  String homeEventDistanceKm(String distance) {
    return '$distance km';
  }

  @override
  String homeEventTravelMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get homeNearMePermissionDenied =>
      'Location permission is required to show nearby events.';

  @override
  String get homeNearMeLocationDisabled =>
      'Turn on location services to find events near you.';

  @override
  String get homeLocationSheetTitle => 'Choose location';

  @override
  String get homeLocationSheetSubtitle =>
      'Use your current location or type a city to update events.';

  @override
  String get homeLocationUseCurrent => 'Use my current location';

  @override
  String get homeLocationTypeHint => 'Type a city or venue area';

  @override
  String get homeLocationApply => 'Apply location';

  @override
  String get homeLocationClear => 'Clear location';

  @override
  String get homeLocationActiveNearby => 'Nearby';

  @override
  String get homeSearchPlaceholder => 'Search events by name';

  @override
  String get homeSearchEmpty => 'We couldn\'t find any events with that term.';

  @override
  String get homeSearchRecentTitle => 'Recent searches';

  @override
  String get homeSearchClearHistory => 'Clear';

  @override
  String get homeSearchSuggestionsTitle => 'Suggestions';

  @override
  String get homeFiltersTitle => 'Filters';

  @override
  String get homeFiltersDate => 'Date';

  @override
  String get homeFiltersPrice => 'Price';

  @override
  String get homeFiltersCityZone => 'City / Zone';

  @override
  String get homeFiltersVenueType => 'Venue type';

  @override
  String get homeFiltersFreeOnly => 'Free events only';

  @override
  String get homeFiltersCityLabel => 'City';

  @override
  String get homeFiltersZoneLabel => 'Neighbourhood';

  @override
  String get homeFiltersClear => 'Clear filters';

  @override
  String get homeFiltersApply => 'Apply';

  @override
  String homeFiltersApplyCount(int count) {
    return 'Apply ($count)';
  }

  @override
  String get homeFiltersCustomRange => 'Custom range';

  @override
  String homeFiltersDateFrom(String date) {
    return 'From $date';
  }

  @override
  String homeFiltersDateUntil(String date) {
    return 'Until $date';
  }

  @override
  String homeFiltersDateRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get homeFiltersAllCities => 'All cities';

  @override
  String get allEventsTitle => 'All events';

  @override
  String get allEventsSubtitle => 'Browse every published event on YouPass';

  @override
  String get allEventsSearchHint => 'Search event';

  @override
  String allEventsAvailableCount(int count) {
    return '$count events available';
  }

  @override
  String get favoritesEventsSubtitle => 'Your favorite producers appear here';

  @override
  String get favoritesEventsSearchHint => 'Search producer';

  @override
  String get favoritesEventsEmpty =>
      'No followed promoters yet. Follow a promoter from an event to see them here.';

  @override
  String favoritesSavedEventsCount(int count) {
    return '$count saved events';
  }

  @override
  String get seeAll => 'See all';

  @override
  String get buyTickets => 'BUY TICKETS';

  @override
  String get eventDetailTitle => 'Event details';

  @override
  String get eventDetailAboutSection => 'About this event';

  @override
  String get eventDetailAboutHeading => 'ABOUT THE EVENT';

  @override
  String get eventDetailReadMore => 'See more';

  @override
  String get eventDetailReadLess => 'Read less';

  @override
  String get eventDetailBuyTicketsLabel => 'Buy tickets';

  @override
  String get eventDetailSoldOut => 'Sold Out';

  @override
  String get eventDetailPromoterLabel => 'Promoter';

  @override
  String eventDetailFollowPromoter(String name) {
    return 'You are now following $name';
  }

  @override
  String eventDetailUnfollowPromoter(String name) {
    return 'You unfollowed $name';
  }

  @override
  String get eventCaribeDate => 'Saturday, January 31, 2026';

  @override
  String get eventCaribeLocation => 'Club Océano, Viña del Mar';

  @override
  String get eventRockDate => 'Sunday, February 15, 2026';

  @override
  String get eventRockLocation => 'Simón Bolívar Park, Bogotá';

  @override
  String get defaultGuestName => 'Christian';

  @override
  String get brandBadgeOff => 'OFF';

  @override
  String get brandBadgeOn => 'ON';

  @override
  String get brandModeProduction => 'PRODUCTION';

  @override
  String get brandModeFiesta => 'PARTY MODE';

  @override
  String get featuredEventSummerTitle => 'SUMMER BEATS 2026';

  @override
  String get featuredEventUrbanTitle => 'URBAN NIGHT LIVE';

  @override
  String get eventCaribeTitle => 'Caribe Night';

  @override
  String get eventRockTitle => 'Rock al Parque';

  @override
  String helloUser(String name) {
    return 'Hello, $name';
  }

  @override
  String get logoutButton => 'Logout';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneInvalidLength => 'Enter a 9-digit number';

  @override
  String get phoneMustStartWithNine => 'Number must start with 9';

  @override
  String get phoneInvalidGeneric => 'Enter a valid phone number';

  @override
  String get otpRequired => 'Enter the verification code';

  @override
  String get otpInvalidLength => 'The code must be 6 digits';

  @override
  String get registerFullNameRequired => 'Enter your full name';

  @override
  String get registerIdDocumentRequired => 'Enter your ID or passport';

  @override
  String get registerBirthDateRequired => 'Select your date of birth';

  @override
  String get registerGenderRequired => 'Select your gender';

  @override
  String get registerEmailRequired => 'Enter your email';

  @override
  String get registerTermsRequired =>
      'You must accept the terms and conditions';

  @override
  String get errorInvalidPhone => 'Invalid phone number';

  @override
  String get errorUnsupportedCountry => 'This country is not supported';

  @override
  String get errorOtpDeliveryFailed =>
      'Could not send the code. Try again later.';

  @override
  String get errorWhatsAppRequired =>
      'This number cannot receive WhatsApp. YouPass uses WhatsApp Business only for verification.';

  @override
  String otpCodeExpiresIn(int seconds) {
    return 'Code expires in ${seconds}s';
  }

  @override
  String get phoneChangeSuccess => 'Phone number updated successfully.';

  @override
  String get errorInvalidCode => 'Invalid code. Request a new one.';

  @override
  String get errorIncorrectCode => 'Incorrect code';

  @override
  String errorIncorrectCodeRemaining(int attempts) {
    return 'Incorrect code. $attempts attempt(s) remaining.';
  }

  @override
  String errorBlockedCountdown(int seconds) {
    return 'Too many failed attempts. Try again in $seconds seconds.';
  }

  @override
  String errorMaxResendsCountdown(int seconds) {
    return 'Too many resend attempts. Try again in $seconds seconds.';
  }

  @override
  String get errorRecaptchaFailed =>
      'Security verification failed. Please try again.';

  @override
  String get errorCardTokenizationRequired =>
      'Card details must be tokenized. Please use the secure payment form.';

  @override
  String changePhoneOtpMessage(String phone) {
    return 'Enter the code we sent to your NEW WhatsApp number $phone.';
  }

  @override
  String get errorCodeExpired => 'The code expired. Request a new one.';

  @override
  String get errorUserNotFound => 'No account found for this number';

  @override
  String get errorUserExists => 'This number is already registered';

  @override
  String errorResendCooldown(int seconds) {
    return 'Resend code in $seconds seconds';
  }

  @override
  String get errorMaxResends => 'Too many resend attempts. Try again later.';

  @override
  String get errorBlocked => 'Too many failed attempts. Try again later.';

  @override
  String get errorValidation => 'Please check the information entered';

  @override
  String get routeNotFound => 'Route not found';

  @override
  String get backButton => 'BACK';

  @override
  String get createAccountTitle => 'CREATE ACCOUNT';

  @override
  String get createAccountSubtitle =>
      'Complete the following details to create your account';

  @override
  String get fullNameLabel => 'FULL NAME';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get idDocumentLabel => 'ID OR PASSPORT';

  @override
  String get idDocumentHint => 'Enter your ID or passport';

  @override
  String get birthDateLabel => 'DATE OF BIRTH';

  @override
  String get birthDateHint => 'Select your date of birth';

  @override
  String get genderLabel => 'GENDER';

  @override
  String get genderHint => 'Select your gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get genderPreferNotToSay => 'Prefer not to say';

  @override
  String get emailLabel => 'EMAIL';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get instagramLabel => 'INSTAGRAM USERNAME';

  @override
  String get instagramHint => '@instagramuser';

  @override
  String get termsPrefix => 'I accept the ';

  @override
  String get termsLink => 'terms and conditions';

  @override
  String get termsAnd => 'and';

  @override
  String get privacyLink => 'privacy policy';

  @override
  String get createAccountButton => 'CREATE ACCOUNT';

  @override
  String get alreadyHaveAccountQuestion => 'ALREADY HAVE AN ACCOUNT?';

  @override
  String get signInLink => 'SIGN IN';

  @override
  String get drawerMyProfile => 'My Profile';

  @override
  String get drawerHome => 'Home';

  @override
  String get drawerMyTickets => 'My Tickets';

  @override
  String get drawerMyFavorites => 'My Favourites';

  @override
  String get drawerInvitations => 'INVITATIONS';

  @override
  String get drawerDrinkMenu => 'Drink Menu';

  @override
  String get drawerMyPurchases => 'My Purchases';

  @override
  String get partyModeUnavailable =>
      'Party Mode opens when you have a scanned ticket at a live event.';

  @override
  String get partyModeNeedTicket => 'Buy a ticket first to unlock Party Mode.';

  @override
  String get partyModeNeedScan =>
      'Have your ticket scanned at the door to unlock Party Mode.';

  @override
  String get partyModeNeedLocation =>
      'Go to the event venue to unlock Party Mode.';

  @override
  String get partyDrinkMenuEmpty =>
      'The drink menu for this event will appear here soon.';

  @override
  String get partyDrinkMenuSubtitle => 'Choose a category to explore';

  @override
  String get partyDrinkEventChooserTitle => 'Which drink menu?';

  @override
  String get partyDrinkEventChooserSubtitle =>
      'You have tickets for more than one event. Choose which menu to open.';

  @override
  String get partyDrinkEventChooserRecommended => 'Suggested now';

  @override
  String get partyDrinkChangeEvent => 'Change event';

  @override
  String get partyDrinkCategoryAll => 'All';

  @override
  String get partyDrinkCategoryPiscos => 'Piscos';

  @override
  String get partyDrinkCategoryBeers => 'Beers';

  @override
  String get partyDrinkCategorySparkling => 'Sparkling wines';

  @override
  String get partyDrinkCategoryEnergy => 'Energy drinks';

  @override
  String get partyDrinkQuickRecommendations => 'Quick recommendations';

  @override
  String get partyDrinkQuickRecommendationsSubtitle =>
      'Most ordered at YouFest';

  @override
  String get partyDrinkMockPiscola => 'Piscola';

  @override
  String get partyDrinkMockPiscolaDesc => 'Pisco + cola drink';

  @override
  String get partyDrinkMockJagerBomb => 'Jager Bomb';

  @override
  String get partyDrinkMockJagerBombDesc => 'Jägermeister + Red Bull';

  @override
  String get partyDrinkMockTropicalGin => 'Tropical Gin';

  @override
  String get partyDrinkMockTropicalGinDesc => 'Gin + tonic + fruits';

  @override
  String get partyDrinkMockCubaLibre => 'Cuba Libre';

  @override
  String get partyDrinkMockCubaLibreDesc => 'Rum + cola + lime';

  @override
  String get partyDrinkMockCorona => 'Corona';

  @override
  String get partyDrinkMockCoronaDesc => 'Mexican lager beer';

  @override
  String get partyDrinkMockChandon => 'Chandon';

  @override
  String get partyDrinkMockChandonDesc => 'Sparkling wine bottle';

  @override
  String partyDrinkVolumeMl(int volume) {
    return '$volume ml';
  }

  @override
  String get partyDrinkCheckoutPaymentMethod => 'Payment method';

  @override
  String get partyDrinkCheckoutCreditCard => 'Credit card';

  @override
  String partyDrinkCheckoutCardMask(String last4) {
    return '**** $last4';
  }

  @override
  String partyDrinkCheckoutProducts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products',
      one: '1 product',
    );
    return '$_temp0';
  }

  @override
  String get partyDrinkCheckoutBuy => 'BUY';

  @override
  String get partyDrinkCheckoutSummaryTitle => 'Purchase summary';

  @override
  String get partyDrinkCheckoutSummarySubtitle =>
      'Review your products before continuing.';

  @override
  String get partyDrinkCheckoutSubtotal => 'Subtotal';

  @override
  String get partyDrinkCheckoutServiceCharge => 'Service charge';

  @override
  String get partyDrinkCheckoutTotal => 'Total';

  @override
  String get partyDrinkCheckoutChangePayment => 'Change';

  @override
  String get partyDrinkCheckoutCompletePurchase => 'Complete purchase';

  @override
  String get partyDrinkCheckoutSecurePayment => '100% secure payment';

  @override
  String get partyDrinkPurchaseSuccessTitle => 'Purchase complete!';

  @override
  String get partyDrinkPurchaseSuccessSubtitle =>
      'Show this code at the bar to receive your drink.';

  @override
  String get partyDrinkQrAcceptedTitle => 'QR accepted!';

  @override
  String get partyDrinkQrAcceptedMessage =>
      'Your drink code was scanned successfully. Enjoy!';

  @override
  String partyDrinkPurchaseValidity(String target) {
    return 'This code is valid for $target.';
  }

  @override
  String get partyDrinkPurchaseShowBartender =>
      'Show it to the bartender to receive your order.';

  @override
  String get partyDrinkPurchasesTitle => 'MY PURCHASES';

  @override
  String get partyDrinkPurchasesSubtitle =>
      'Review and redeem your orders inside the event.';

  @override
  String get partyDrinkPurchasesTabPending => 'To redeem';

  @override
  String get partyDrinkPurchasesTabUsed => 'Used';

  @override
  String partyDrinkPurchasesOrderLabel(String id) {
    return 'Order $id';
  }

  @override
  String partyDrinkPurchasesQuantityLabel(int count, String name) {
    return '$count x $name';
  }

  @override
  String partyDrinkPurchasesBoughtAgo(String timeAgo) {
    return 'Purchased $timeAgo';
  }

  @override
  String partyDrinkPurchasesRedeemedAgo(String timeAgo) {
    return 'Redeemed $timeAgo';
  }

  @override
  String get partyDrinkPurchasesViewQr => 'VIEW QR';

  @override
  String get partyDrinkPurchasesRedeemedBadge => 'REDEEMED';

  @override
  String get partyDrinkPurchasesEmptyPending =>
      'You have no drinks waiting to be redeemed.';

  @override
  String get partyDrinkPurchasesEmptyUsed =>
      'You have no redeemed drink orders yet.';

  @override
  String get partyDrinkPurchasesQrUnavailable =>
      'This order QR is no longer available.';

  @override
  String get partyDrinkPurchasesJustNow => 'just now';

  @override
  String partyDrinkPurchasesMinutesAgo(int count) {
    return '$count min';
  }

  @override
  String partyDrinkPurchasesHoursAgo(int count) {
    return '$count h';
  }

  @override
  String partyDrinkPurchasesDaysAgo(int count) {
    return '$count d';
  }

  @override
  String get partyDrinkCourtesiesTitle => 'MY COURTESIES';

  @override
  String get partyDrinkCourtesiesSubtitle =>
      'Review and redeem your complimentary drinks inside the event.';

  @override
  String partyDrinkCourtesiesReceivedAgo(String timeAgo) {
    return 'Received $timeAgo';
  }

  @override
  String get partyDrinkCourtesiesEmptyPending =>
      'You have no complimentary drinks waiting to be redeemed.';

  @override
  String get partyDrinkCourtesiesEmptyUsed =>
      'You have no redeemed courtesies yet.';

  @override
  String drawerInvitationsNewBadge(int count) {
    return '$count new';
  }

  @override
  String get drawerTierBronze => 'BRONZE';

  @override
  String get drawerTierSilver => 'SILVER';

  @override
  String get drawerTierGold => 'GOLD';

  @override
  String get drawerTierPlatinum => 'PLATINUM';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get profileViewBenefits => 'View my benefits';

  @override
  String get profilePersonalData => 'PERSONAL DATA';

  @override
  String get profileFullName => 'Full name';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileBirthDate => 'Date of birth';

  @override
  String get profileGender => 'Gender';

  @override
  String get profileGenderMaleValue => 'Male';

  @override
  String get profileInstagram => 'Instagram username';

  @override
  String get profilePhone => 'PHONE';

  @override
  String get profileChangePhone => 'Change phone number';

  @override
  String get changePhoneTitle => 'Change phone';

  @override
  String get changePhoneSubtitle =>
      'Enter your new number. We will send a verification code to your NEW WhatsApp number.';

  @override
  String get changePhoneCurrentLabel => 'Current number';

  @override
  String get changePhoneNewLabel => 'New number';

  @override
  String get changePhoneContinueButton => 'Send verification code';

  @override
  String get changePhoneSameNumber => 'That is already your current number.';

  @override
  String get profileEditData => 'Edit details';

  @override
  String get profileWalletSection => 'YOUPASS WALLET';

  @override
  String get profilePaymentMethods => 'My payment methods';

  @override
  String get profileCardVisa => 'Visa ••••4205';

  @override
  String get profileCardMastercard => 'Mastercard ••••9988';

  @override
  String get profileDefaultCard => 'Default';

  @override
  String get profileSetDefaultCard => 'Set as default';

  @override
  String get profileDeleteCard => 'Delete card';

  @override
  String get profileDefaultCardUpdated => 'Default payment method updated';

  @override
  String get profileViewFullWallet => 'View full wallet';

  @override
  String get profileWalletAvailableBalance => 'Available balance';

  @override
  String profileWalletCredits(String amount) {
    return '$amount credits';
  }

  @override
  String get profileWalletTransactionHistory => 'Transaction history';

  @override
  String get profileWalletNoTransactions => 'No transactions yet';

  @override
  String get profileWalletDefaultDeleteRequired =>
      'Choose a new default card before deleting this one';

  @override
  String get profileWalletSelectNewDefault => 'Select new default card';

  @override
  String get profileWalletAddCard => 'Add new card';

  @override
  String get profileNotifications => 'NOTIFICATIONS';

  @override
  String get profileReceiveNotifications => 'Receive notifications';

  @override
  String get profileNotificationChannels => 'Email · Push · WhatsApp';

  @override
  String get profileNotificationChannelEmail => 'Email';

  @override
  String get profileNotificationChannelEmailDesc =>
      'Formal communications, order confirmations, receipts, and long reminders';

  @override
  String get profileNotificationChannelPush => 'Push notification';

  @override
  String get profileNotificationChannelPushDesc =>
      'Real-time alerts, invitations, short reminders, and urgent updates';

  @override
  String get profileNotificationChannelWhatsApp => 'WhatsApp';

  @override
  String get profileNotificationChannelWhatsAppDesc =>
      'Interactive bot messages, invitations, payment links, and conversational updates';

  @override
  String get profileNotificationAdvancedSettings => 'Advanced settings';

  @override
  String get profileNotificationCriticalDisclaimer =>
      'These notifications cannot be disabled as they are essential to your experience.';

  @override
  String get profileNotificationAdvancedTitle =>
      'Advanced notification settings';

  @override
  String get profileNotificationByType => 'By type';

  @override
  String get profileNotificationTypePurchases => 'Purchases';

  @override
  String get profileNotificationTypeReminders => 'Reminders';

  @override
  String get profileNotificationTypePromotions => 'Promotions';

  @override
  String get profileNotificationTypeSocial => 'Social';

  @override
  String get profileNotificationByChannel => 'By channel';

  @override
  String get profileNotificationNightSilence => 'Night silence';

  @override
  String get profileNotificationNightSilenceDesc =>
      'No push notifications after the selected time (your local timezone)';

  @override
  String get profileNotificationNightSilenceFrom => 'Silence push from';

  @override
  String get profileNotificationCriticalTitle => 'Critical notifications';

  @override
  String get profileNotificationCriticalEventCancellation =>
      'Event cancellation';

  @override
  String get profileNotificationCriticalEventDatetime =>
      'Event date or time change';

  @override
  String get profileNotificationCriticalEventVenue =>
      'Event venue or location change';

  @override
  String get profileNotificationCriticalSecurity => 'Critical security alerts';

  @override
  String get profileNotificationCriticalPaymentReceipts =>
      'Payment receipts / purchase confirmations';

  @override
  String get profileNotificationCriticalRefunds => 'Processed refunds';

  @override
  String get profileNotificationUpdateFailed =>
      'Could not update notification settings. Please try again.';

  @override
  String get profileSupport => 'SUPPORT';

  @override
  String get profileWhatsAppSupport => 'WhatsApp support';

  @override
  String get profileWriteEmail => 'Send email';

  @override
  String profileSupportEmailMessage(String email) {
    return 'Write to YouPass support at $email';
  }

  @override
  String get profileSupportEmailCopy => 'Copy address';

  @override
  String get profileSupportEmailCopied => 'Email copied';

  @override
  String get profileSupportEmailOpen => 'Open mail app';

  @override
  String get profileFaq => 'Frequently asked questions';

  @override
  String get profileLogout => 'Sign out';

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profileDeleteInfoIntro =>
      'The following will be permanently deleted:';

  @override
  String get profileDeleteItemPersonalData => 'Personal data';

  @override
  String get profileDeleteItemTickets => 'Active and future tickets';

  @override
  String get profileDeleteItemPaymentMethods => 'Payment methods';

  @override
  String get profileDeleteItemPoints => 'Accumulated points';

  @override
  String get profileDeleteItemHistory => 'Complete history';

  @override
  String get profileDeleteIrreversibleWarning =>
      'This action is IRREVERSIBLE after 7 days.';

  @override
  String get accountDeletionBiometricReason =>
      'Confirm your identity to continue with account deletion';

  @override
  String get accountDeletionBiometricFailed =>
      'Authentication failed. Account deletion was not started.';

  @override
  String get accountDeletionPendingBannerTitle => 'Account pending deletion';

  @override
  String accountDeletionPendingBannerSubtitle(String date, int days) {
    return 'Your account will be deleted on $date ($days days remaining). Tap to cancel.';
  }

  @override
  String get accountDeletionCancelAction => 'Cancel deletion';

  @override
  String get accountDeletionCancelled =>
      'Your YOUPASS account is still active.';

  @override
  String get profilePhotoUpdated => 'Profile photo updated';

  @override
  String get profileCompleteBannerTitle => 'Complete your profile';

  @override
  String get profileCompleteBannerSubtitleBoth =>
      'Add your photo and Instagram to personalise your experience';

  @override
  String get profileCompleteBannerSubtitlePhoto =>
      'Add your profile photo to be better identified';

  @override
  String get profileCompleteBannerSubtitleInstagram =>
      'Add your Instagram to connect with other attendees';

  @override
  String get profileCompleteBannerButton => 'COMPLETE';

  @override
  String get profilePhotoChooseSource => 'Change profile photo';

  @override
  String get profilePhotoTake => 'Take photo';

  @override
  String get profilePhotoGallery => 'Choose from gallery';

  @override
  String get profileNotAdded => 'Not added';

  @override
  String get profileEditTitle => 'Edit details';

  @override
  String get profileSave => 'Save';

  @override
  String get profileSaved => 'Profile updated successfully';

  @override
  String get profileGenderFemaleValue => 'Female';

  @override
  String get profileGenderOtherValue => 'Other';

  @override
  String get profileGenderPreferNotSayValue => 'Prefer not to say';

  @override
  String get profileCategoryBenefits => 'My benefits';

  @override
  String profileUnlockTierTitle(String tier) {
    return 'Unlock $tier';
  }

  @override
  String profileUnlockTierButton(String tier) {
    return 'Ask support about $tier';
  }

  @override
  String get profileFaqTitle => 'Frequently asked questions';

  @override
  String get profileFaqSearch => 'Search';

  @override
  String get profileFaqHelpful => 'Was this helpful?';

  @override
  String get profileFaqYes => 'Yes';

  @override
  String get profileFaqNo => 'No';

  @override
  String get profileFaqNoResults =>
      'We couldn\'t find an answer. Contact us directly.';

  @override
  String get profileFaqContactWhatsApp => 'Contact via WhatsApp';

  @override
  String get profileFaqContactEmail => 'Send email';

  @override
  String get profileWhatsAppNotInstalled =>
      'WhatsApp is not installed on this device. Please contact us by email instead.';

  @override
  String get profileDeleteInfoTitle => 'Delete account';

  @override
  String get profileDeleteInfoMessage =>
      'Your personal data, active and future tickets, payment methods, accumulated points, and full history will be deleted. This action is IRREVERSIBLE after 7 days.';

  @override
  String get profileDeleteContinue => 'Continue with deletion';

  @override
  String profileDeletePendingMessage(int days) {
    return 'Your account will be deleted in $days days. Cancel deletion?';
  }

  @override
  String get profileEmailSubject => 'YouPass support request';

  @override
  String get profileAdvancedNotifications => 'Advanced settings';

  @override
  String get confirmDialogCancel => 'Cancel';

  @override
  String get confirmLogoutTitle => 'Are you sure you want to sign out?';

  @override
  String get confirmLogoutMessage =>
      'Your account, tickets, wallet, and points will be saved. You can sign back in anytime with your phone number and OTP code.';

  @override
  String get confirmLogoutAction => 'Yes, sign out';

  @override
  String get confirmDeleteAccountTitle => 'Delete your account?';

  @override
  String get confirmDeleteAccountMessage =>
      'This permanently removes your account, tickets, and profile data. We will send a verification code to confirm.';

  @override
  String get confirmDeleteAccountAction => 'Continue';

  @override
  String get confirmExitAppTitle => 'Exit YouPass?';

  @override
  String get confirmExitAppMessage => 'Are you sure you want to close the app?';

  @override
  String get confirmExitAppAction => 'Exit';

  @override
  String get confirmExitAppStay => 'Stay';

  @override
  String get ticketsTabUpcoming => 'Active / Upcoming';

  @override
  String get ticketsTabPast => 'History';

  @override
  String get ticketsStatusActive => 'ACTIVE';

  @override
  String get ticketsStatusValidated => 'VALIDATED';

  @override
  String get ticketsStatusExpired => 'EXPIRED';

  @override
  String get ticketsStatusCancelled => 'CANCELLED';

  @override
  String get ticketsStatusRefunded => 'REFUNDED';

  @override
  String get ticketsInvitationPending => 'INVITATION';

  @override
  String ticketsInvitationExpires(String deadline) {
    return 'Respond before $deadline';
  }

  @override
  String ticketsQrCountdown(String eventDate) {
    return 'Your QR will be available on $eventDate';
  }

  @override
  String get ticketsQrUnavailable => 'QR LOCKED';

  @override
  String get ticketsCancelTicket => 'Cancel ticket';

  @override
  String get ticketsCancelTicketTitle => 'Cancel this ticket?';

  @override
  String get ticketsCancelTicketMessage =>
      'Your ticket will be cancelled and an automatic refund will be processed when applicable.';

  @override
  String get ticketsCancelTicketConfirm => 'Yes, cancel';

  @override
  String get ticketsCancelTicketSuccess =>
      'Ticket cancelled. Refund is being processed.';

  @override
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavInvitations => 'Invites';

  @override
  String get bottomNavTickets => 'Tickets';

  @override
  String get ticketsViewQr => 'VIEW QR';

  @override
  String get ticketsAssignEntries => 'ASSIGN TICKETS';

  @override
  String get ticketsAssignVip => 'ASSIGN VIP TICKETS';

  @override
  String get ticketsViewAssigned => 'VIEW ASSIGNED TICKETS';

  @override
  String get ticketsAttendedSectionTitle => 'ATTENDED EVENTS';

  @override
  String get ticketsAttendedSectionSubtitle =>
      'Review your past events and your personal statistics.';

  @override
  String get ticketsSearchHint => 'Search event / Event name / promoter';

  @override
  String get ticketsFiltersLabel => 'FILTERS';

  @override
  String get ticketsFilterAll => 'All';

  @override
  String get ticketsFilterParties => 'Parties';

  @override
  String get ticketsFilterConcerts => 'Concerts';

  @override
  String get ticketsFilterBar => 'Bar';

  @override
  String ticketsYearlySummaryAttended(int count, int year) {
    return '$count events attended in $year';
  }

  @override
  String ticketsYearlySummaryProducer(String name, int count) {
    return 'Favorite producer: $name ($count events)';
  }

  @override
  String get ticketsEmptyUpcoming => 'No upcoming tickets yet.';

  @override
  String get ticketsEmptyPast => 'No past events found.';

  @override
  String get ticketsRetry => 'Try again';

  @override
  String get ticketsStatistics => 'STATISTICS';

  @override
  String get ticketsStatEntry => 'Entry';

  @override
  String get ticketsStatConsumption => 'Consumption';

  @override
  String get ticketsStatStay => 'Stay';

  @override
  String get ticketsFavoritesTip =>
      'You can mark events to add them to favorites.';

  @override
  String get favoritesSubtitle =>
      'Your favorite producers and events will appear here';

  @override
  String get favoritesSearchHint => 'Search producer or event';

  @override
  String get favoritesFiltersLabel => 'FILTERS';

  @override
  String get favoritesFilterAll => 'All';

  @override
  String get favoritesFilterUpcoming => 'Upcoming';

  @override
  String get favoritesFilterParties => 'Parties';

  @override
  String get favoritesFilterVip => 'VIP';

  @override
  String get favoritesProducerType => 'Event producer';

  @override
  String get favoritesProducerCoverage => 'Events across Chile';

  @override
  String get favoritesViewEvents => 'VIEW EVENTS';

  @override
  String favoritesSavedProducersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saved producers',
      one: '1 saved producer',
    );
    return '$_temp0';
  }

  @override
  String get favoritesYoufestDescription =>
      'The best festivals and live experiences.';

  @override
  String get favoritesIguanaDescription =>
      'Electronic music, parties and unique experiences.';

  @override
  String favoritesFollowerCount(String count) {
    return '$count followers';
  }

  @override
  String get favoritesNoSearchResults =>
      'No promoters found matching your search';

  @override
  String get favoritesExploreCta => 'Explore events';

  @override
  String get favoritesSectionFollowedPromoters => 'FOLLOWED PROMOTERS';

  @override
  String get favoritesSectionSavedEvents => 'SAVED EVENTS';

  @override
  String get producerEventPresale => 'PRE-SALE';

  @override
  String get producerEventPrepay => 'PRE-PAY';

  @override
  String get producerEventsUpcomingTitle => 'UPCOMING EVENTS';

  @override
  String producerEventsUpcomingSubtitle(String producerName) {
    return 'Discover upcoming events from $producerName';
  }

  @override
  String get producerEventsSearchHint => 'Search event';

  @override
  String get producerEventsEmpty =>
      'No upcoming events from this promoter yet.';

  @override
  String get producerEventCategoryParties => 'Parties';

  @override
  String get producerEventCategoryFestivals => 'Festivals';

  @override
  String get producerEventCategoryConcerts => 'Concerts';

  @override
  String get producerEventFromPrice => 'From';

  @override
  String get producerEventBuyTicket => 'BUY TICKET';

  @override
  String producerEventsAvailableCount(int count) {
    return '$count events available';
  }

  @override
  String get drawerMyInvitations => 'My Invitations';

  @override
  String get invitationsScreenTitle => 'MY INVITATIONS';

  @override
  String get invitationsSubtitle =>
      'Manage your event accesses and invitations';

  @override
  String get invitationsSearchHint => 'Search invitation · Event / promoter';

  @override
  String get invitationsFiltersLabel => 'FILTERS';

  @override
  String get invitationsFilterCourtesy => 'Courtesies';

  @override
  String get invitationsFilterAll => 'All';

  @override
  String get invitationsFilterFree => 'Free';

  @override
  String get invitationsFilterGuaranteedPass => 'Guaranteed Pass';

  @override
  String get invitationsFilterDiscounted => 'Discounted';

  @override
  String get invitationsTypeFree => 'Free Invitation';

  @override
  String get invitationsTypeAssigned => 'Invitation';

  @override
  String get invitationsTypeVip => 'VIP Invitation';

  @override
  String get invitationsTypeGuaranteedPass => 'Guaranteed Pass';

  @override
  String get invitationsTypeDiscounted => 'Discounted Invitation';

  @override
  String get invitationsGuaranteedPassTitle => 'Guaranteed Pass';

  @override
  String invitationsGuaranteedPassMessage(String deadline, String amount) {
    return 'This pass is FREE if you attend. If you do not attend and do not cancel by $deadline, $amount will be charged to your card.';
  }

  @override
  String get invitationsGuaranteedPassTerms =>
      'I understand the attendance commitment and possible charge';

  @override
  String get invitationsGpTermsRequired =>
      'Please accept the terms to continue';

  @override
  String invitationsPreauthNotice(String amount) {
    return 'Your card will be pre-authorised for $amount. You will only be charged if you no-show.';
  }

  @override
  String get invitationsDiscountedPayTitle => 'Discounted Invitation';

  @override
  String invitationsDiscountedPayMessage(String amount) {
    return 'Pay $amount now to accept this invitation.';
  }

  @override
  String invitationsDiscountPercent(int percent) {
    return '$percent% discount';
  }

  @override
  String invitationsCancelBy(String deadline) {
    return 'Cancel by $deadline';
  }

  @override
  String get invitationsAcceptGuaranteed => 'ACCEPT AND RESERVE';

  @override
  String get invitationsAcceptAndReserve => 'ACCEPT AND RESERVE';

  @override
  String get invitationsGuaranteedPassDetailTitle => 'Guaranteed Pass';

  @override
  String get invitationsDetailTitle => 'Invitation details';

  @override
  String get invitationsGuaranteedBadge => 'GUARANTEED';

  @override
  String invitationsAssignedSlot(String slot) {
    return 'Slot: $slot';
  }

  @override
  String invitationsPassStatus(String status) {
    return 'Status: $status';
  }

  @override
  String get invitationsGpWarningTitle => '⚠ IMPORTANT';

  @override
  String invitationsGpWarningBody(String amount, String deadline) {
    return 'If you attend: 100% FREE\nIf you don\'t attend: $amount will be charged to your card\n\nCANCELLATION DEADLINE\nUntil $deadline without charge\n\nBy accepting, you authorise the charge to your card if you do not attend the event.';
  }

  @override
  String get invitationsBiometricReason =>
      'Confirm your Guaranteed Pass acceptance';

  @override
  String get invitationsGpPaymentRequired =>
      'You need to add a payment method to accept a Guaranteed Pass';

  @override
  String get invitationsGpActiveTitle => 'Guaranteed Pass active';

  @override
  String invitationsGpActiveMessage(String event, String deadline) {
    return 'Your pass to $event is reserved. Cancel before $deadline without charge.';
  }

  @override
  String get invitationsGpActiveCta => 'Go to My Tickets';

  @override
  String get invitationsCancelInvitation => 'Cancel invitation';

  @override
  String get invitationsGpCancelTitle => 'Cancel your Guaranteed Pass?';

  @override
  String get invitationsGpCancelMessage =>
      'Your card hold will be released immediately. This cannot be undone.';

  @override
  String get invitationsGpCancelConfirm => 'Yes, cancel';

  @override
  String get invitationsGpCancelSuccess =>
      'Your Guaranteed Pass was cancelled without charge.';

  @override
  String get invitationsAcceptDiscounted => 'PAY & ACCEPT';

  @override
  String get invitationsFilterGeneral => 'General';

  @override
  String get invitationsFilterVip => 'VIP';

  @override
  String get invitationsFilterTables => 'Tables';

  @override
  String get invitationsTierVipDj => 'VIP DJ';

  @override
  String get invitationsTierVip => 'VIP';

  @override
  String get invitationsTierVipMesa => 'VIP Table';

  @override
  String get invitationsTierGeneral => 'General';

  @override
  String get invitationsTierFree => 'Free';

  @override
  String invitationsInvitedBy(String name) {
    return 'Invited by $name';
  }

  @override
  String invitationsAcceptBy(String deadline) {
    return 'Accept by $deadline';
  }

  @override
  String invitationsStatusLine(String status) {
    return 'Status: $status';
  }

  @override
  String get invitationsStatusPrefix => 'Status:';

  @override
  String get invitationsStatusPending => 'Pending';

  @override
  String get invitationsStatusConfirmed => 'Confirmed';

  @override
  String get invitationsStatusRejected => 'Declined';

  @override
  String get invitationsConfirmAttendance => 'CONFIRM ATTENDANCE';

  @override
  String get invitationsTabPending => 'Pending';

  @override
  String get invitationsTabConfirmed => 'Confirmed';

  @override
  String get invitationsEmptyNone => 'You have no invitations yet.';

  @override
  String get invitationsEmptySearch => 'No invitations found for that search.';

  @override
  String get invitationsEmptyPending => 'You have no pending invitations.';

  @override
  String get invitationsEmptyConfirmed =>
      'You have no confirmed invitations yet.';

  @override
  String get invitationsRejectConfirmTitle => 'Reject invitation?';

  @override
  String get invitationsRejectConfirmMessage =>
      'Are you sure you want to reject this invitation?';

  @override
  String get invitationsRejectConfirmAction => 'REJECT';

  @override
  String get invitationsCancellationDeadlinePassed =>
      'Cancellation deadline has passed';

  @override
  String get invitationsWaitingConfirmation => 'Waiting for confirmation…';

  @override
  String invitationsQrAvailableOn(String date) {
    return 'Your QR will be available on $date';
  }

  @override
  String get invitationsReject => 'REJECT';

  @override
  String get invitationsCancel => 'CANCEL';

  @override
  String get invitationsAttendanceConfirmed => 'ATTENDANCE CONFIRMED';

  @override
  String get invitationsViewQr => 'VIEW QR';

  @override
  String get invitationsQrPendingTitle => 'Confirm attendance first';

  @override
  String get invitationsQrPendingMessage =>
      'Your QR code will be available after you confirm this invitation.';

  @override
  String get invitationsQrLockedTitle => 'QR not available yet';

  @override
  String get invitationsQrLockedMessage =>
      'Your QR will be available from 00:00 on the day of the event.';

  @override
  String get invitationsQrExpiredTitle => 'QR expired';

  @override
  String get invitationsQrExpiredMessage =>
      'This event QR is no longer available.';

  @override
  String invitationsQrUnlockAt(String date) {
    return 'Available from $date';
  }

  @override
  String get invitationsQrGotIt => 'GOT IT';

  @override
  String get invitationsFooterNote =>
      'Confirmed invitations generate a unique and non-transferable QR code.';

  @override
  String get invitationsImportantTitle => 'Important ⚠';

  @override
  String get invitationsImportantMessage =>
      'By confirming your attendance, your ticket will be reserved exclusively for you. If you do not attend the event, you may be charged the full ticket price when this condition applies.';

  @override
  String get invitationsAddPaymentMethod => 'ADD PAYMENT METHOD';

  @override
  String get invitationsDialogCancel => 'CANCEL';

  @override
  String get invitationsPaymentTitle => 'Add payment method';

  @override
  String get invitationsPaymentSubtitle => 'Enter your card details';

  @override
  String get invitationsCardNumber => 'Card number';

  @override
  String get invitationsCardNumberHint => '1234 5678 9012 3456';

  @override
  String get invitationsCardExpiry => 'Expiry date';

  @override
  String get invitationsCardExpiryHint => 'MM/YY';

  @override
  String get invitationsCardCvv => 'CVV';

  @override
  String get invitationsCardCvvHint => '123';

  @override
  String get invitationsCardholderName => 'Name on card';

  @override
  String get invitationsCardholderNameHint => 'As shown on the card';

  @override
  String get invitationsPaymentSecureNote =>
      'Your information is protected and will be used securely.';

  @override
  String get invitationsSaveCard => 'SAVE CARD';

  @override
  String get invitationsCardSavedTitle => 'Card saved successfully!';

  @override
  String get invitationsCardSavedMessage =>
      'Your payment method has been registered correctly. Remember the following:';

  @override
  String get invitationsCardSavedReminderCharge =>
      'If you confirm attendance and do not show up, you will be charged the full ticket price.';

  @override
  String get invitationsCardSavedReminderCancel =>
      'If you wish to cancel your attendance, you must do so at least 48 hours in advance to avoid being charged.';

  @override
  String get eventTicketScreenTitle => 'Event ticket';

  @override
  String get eventTicketReadyTitle => 'Your ticket is ready!';

  @override
  String get eventTicketReadySubtitle =>
      'Show this code at the entrance to enter the event.';

  @override
  String get eventTicketManualIdLabel => 'Manual entry ID';

  @override
  String get welcomeFallbackTitle => 'Welcome to YouPass';

  @override
  String get welcomeFallbackSubtitle =>
      'Your access to the best events starts here';

  @override
  String get paymentBrandVisa => 'VISA';

  @override
  String get paymentBrandMastercard => 'MC';

  @override
  String get errorMissingAccessToken =>
      'Could not complete sign in. Please try again.';

  @override
  String get errorAuthenticationRequired => 'Please sign in to continue.';

  @override
  String get errorTicketOrderNotFound =>
      'This ticket order could not be found.';

  @override
  String get errorTicketSlotNotFound => 'This ticket slot could not be found.';

  @override
  String get errorTicketSlotNotAvailable =>
      'This ticket is no longer available to assign.';

  @override
  String get errorWhatsAppSendFailed =>
      'Could not send the WhatsApp invitation. Try again.';

  @override
  String get errorCannotAssignToSelf =>
      'You cannot assign a ticket to your own phone number.';

  @override
  String get errorClaimNotFound =>
      'This invitation link is invalid or has expired.';

  @override
  String get errorInvitationForbidden =>
      'You are not allowed to manage this invitation.';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get phoneHintChile => '9 1234 5678';

  @override
  String get phoneHintGeneric => '123 456 7890';

  @override
  String get phoneHintPakistan => '321 6548001';

  @override
  String get mockEventFestivalVerano2026 => 'Summer Festival 2026';

  @override
  String get mockEventConciertoX => 'Concert X';

  @override
  String get mockEventYoufest2026 => 'YouFest 2026';

  @override
  String get mockEventIguanaSummer => 'IGUANA SUMMER';

  @override
  String get mockEventYoufestWinter2026 => 'YouFest Winter 2026';

  @override
  String get mockEventNeonRooftopSessions => 'Neon Rooftop Sessions';

  @override
  String get mockEventSummerClosingParty => 'Summer Closing Party';

  @override
  String get mockDateSaturdayMay15 => 'Saturday, May 15 · 10:00 PM';

  @override
  String get mockDateSaturdayMay15Long => 'Saturday, May 15, 2026 - 10:00 PM';

  @override
  String get mockDateSaturdayJuly4 => 'Sat, Jul 4 · 10:00 PM';

  @override
  String get mockLocationClubAmanda => 'Club Amanda, Santiago';

  @override
  String get mockLocationClubAmandaShort => 'Club Amanda';

  @override
  String get mockLocationMovistarArena => 'Movistar Arena';

  @override
  String get mockLocationCentroEventosHilaria => 'Centro Eventos Hilaria';

  @override
  String get mockTicketGeneralOne => 'General · 1 ticket';

  @override
  String get mockTicketVipTwo => 'VIP · 2 tickets';

  @override
  String get mockStayDuration5h14m => '5h 14m';

  @override
  String get mockSeatVipTable => 'Table 1 - VIP 1 | 10 guests';

  @override
  String get mockProducerYoufest => 'YouFest';

  @override
  String get mockProducerIguana => 'IGUANA';

  @override
  String get mockPriceFrom35000 => 'From \$35,000 CLP';

  @override
  String get mockPriceFrom28000 => 'From \$28,000 CLP';

  @override
  String get mockPriceFrom42000 => 'From \$42,000 CLP';

  @override
  String get mockPriceFrom55000 => 'From \$55,000 CLP';

  @override
  String get mockPriceFrom32000 => 'From \$32,000 CLP';

  @override
  String get mockDateSaturdayJuly18 => 'Sat, Jul 18, 2026';

  @override
  String get mockDateFridayAugust7 => 'Fri, Aug 7, 2026';

  @override
  String get mockDateSaturdaySeptember12 => 'Sat, Sep 12, 2026';

  @override
  String get mockDateSaturdayAugust22 => 'Sat, Aug 22, 2026';

  @override
  String get mockLocationParqueBicentenario => 'Bicentennial Park, Santiago';

  @override
  String get mockLocationTerrazaNeon => 'Neon Rooftop, Santiago';

  @override
  String get mockLocationClubAmandaValparaiso => 'Club Amanda, Valparaiso';

  @override
  String get mockLocationMovistarArenaShort => 'Movistar Arena, Santiago';

  @override
  String get mockTime2200Hrs => '10:00 PM';

  @override
  String get mockTime2300Hrs => '11:00 PM';

  @override
  String get mockTime2130Hrs => '9:30 PM';

  @override
  String get mockPriceFrom50000 => 'From \$50,000 CLP';

  @override
  String get mockLocationSkyCostanera => 'Sky Costanera';

  @override
  String get mockLocationClubOceano => 'Club Océano';

  @override
  String get mockDateSaturdayJuly4Short => 'Sat, Jul 4, 2026';

  @override
  String get mockDateFridayAugust7Short => 'Fri, Aug 7, 2026';

  @override
  String get mockDateSaturdaySeptember12Short => 'Sat, Sep 12, 2026';

  @override
  String get ticketAssignmentTitle => 'Assign tickets';

  @override
  String get ticketAssignmentHeading => 'Assign tickets';

  @override
  String ticketAssignmentSlotLabel(int number) {
    return 'Ticket $number';
  }

  @override
  String ticketAssignmentSummarySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tickets available • You can do it in parts',
      one: '1 ticket available • You can do it in parts',
    );
    return '$_temp0';
  }

  @override
  String ticketAssignmentAvailableCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tickets available to assign',
      one: '1 ticket available to assign',
    );
    return '$_temp0';
  }

  @override
  String ticketAssignmentPendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pending',
      one: '1 pending',
    );
    return '$_temp0';
  }

  @override
  String ticketAssignmentClaimedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accepted',
      one: '1 accepted',
    );
    return '$_temp0';
  }

  @override
  String get ticketAssignmentSentSectionTitle => 'Sent invitations';

  @override
  String get ticketAssignmentSendNewSectionTitle => 'Send new tickets';

  @override
  String ticketAssignmentSendNewSectionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count tickets ready to assign to new guests.',
      one: 'You have 1 ticket ready to assign to a new guest.',
    );
    return '$_temp0';
  }

  @override
  String get ticketAssignmentAcceptedBadge => 'ACCEPTED';

  @override
  String get ticketAssignmentOwnerTicket => 'Your ticket';

  @override
  String get ticketAssignmentClaimedTicket => 'Ticket claimed';

  @override
  String get ticketAssignmentPendingBadge => 'PENDING';

  @override
  String get ticketAssignmentAvailableBadge => 'AVAILABLE';

  @override
  String get ticketAssignmentGuestNameLabel => 'Guest name';

  @override
  String get ticketAssignmentGuestNameHint => 'Full name';

  @override
  String get ticketAssignmentGuestPhoneLabel => 'Guest phone';

  @override
  String get ticketAssignmentGuestPhoneHint => 'Phone (e.g. +56 9 1234 5678)';

  @override
  String get ticketAssignmentPickContact => 'Search from contacts';

  @override
  String get ticketAssignmentSearchGuestTitle => 'Find guest';

  @override
  String get ticketAssignmentSearchGuestSubtitle =>
      'Search registered YouPass users by name or phone. If they are not registered, enter their details manually on the card.';

  @override
  String get ticketAssignmentSearchGuestHint => 'Name or phone number';

  @override
  String get ticketAssignmentSearchGuestEmpty =>
      'No registered user found. You can type their name and phone manually, then send the WhatsApp invitation.';

  @override
  String get ticketAssignmentSearchGuestManualHint =>
      'Close this sheet to type guest details manually on the ticket card.';

  @override
  String get ticketAssignmentRegisteredBadge => 'YouPass';

  @override
  String get ticketAssignmentSendTicket => 'Send ticket';

  @override
  String get ticketAssignmentCancelTicket => 'Cancel ticket';

  @override
  String get ticketAssignmentResendWhatsApp => 'Resend WhatsApp';

  @override
  String get ticketAssignmentSentSuccess =>
      'WhatsApp opened — tap Send to deliver the invitation';

  @override
  String get ticketAssignmentContactsPermissionDenied =>
      'Contacts permission is required to pick a guest';

  @override
  String get ticketAssignmentMissingOrder =>
      'This ticket cannot be assigned yet';

  @override
  String get ticketAssignmentNoAssignableTickets =>
      'No tickets available to assign right now';

  @override
  String get ticketAssignmentRetry => 'Retry';

  @override
  String get ticketAssignmentWhatsAppInfo =>
      'When you send the ticket, WhatsApp opens with your guest\'s number and a pre-filled message. Tap Send in WhatsApp to deliver the invitation link.';

  @override
  String get ticketAssignmentPrivacyNote =>
      'Your data and your guests\' data are protected';

  @override
  String get invitationClaimTitle => 'You have a ticket invitation';

  @override
  String get invitationClaimGuestLabel => 'Guest';

  @override
  String get invitationClaimInvitedByLabel => 'Invited by';

  @override
  String get invitationClaimStepsTitle => 'How to claim your ticket';

  @override
  String get invitationClaimOpenInvitations => 'Open Invitations';

  @override
  String get invitationClaimLoginRegister => 'Log in or register';

  @override
  String get vipTicketSelectionTitle => 'Buy tickets';

  @override
  String get vipTicketSelectionHeading => 'Choose your ticket';

  @override
  String get vipSectionGeneralTickets => 'GENERAL TICKETS';

  @override
  String get vipSectionVipTables => 'VIP TABLES';

  @override
  String get vipSectionVipTickets => 'VIP ADMISSION';

  @override
  String get vipOfferingPreventa1 => 'PRE-SALE 1';

  @override
  String get vipOfferingPreventa2 => 'PRE-SALE 2';

  @override
  String get vipOfferingGeneralCover => 'GENERAL + COVER';

  @override
  String get vipOfferingVipGeneral => 'VIP GENERAL';

  @override
  String get vipOfferingWithoutTable => 'Without table';

  @override
  String get vipOfferingGeneralAccessDescription => 'General event access';

  @override
  String vipTicketCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tickets',
      one: '1 ticket',
    );
    return '$_temp0';
  }

  @override
  String vipTicketSelectionSummaryLine(String ticketCount, String amount) {
    return '$ticketCount • $amount';
  }

  @override
  String get vipBackButton => 'Back';

  @override
  String get vipContinueButton => 'Continue';

  @override
  String vipContinueWithTickets(String ticketCount) {
    return 'Continue - $ticketCount';
  }

  @override
  String vipContinueWithAmount(String amount) {
    return 'Continue · $amount';
  }

  @override
  String get vipTicketSoldOutBadge => 'Sold out';

  @override
  String get vipTicketsNoneAvailable => 'No tickets available for this event.';

  @override
  String get vipTicketsAllSoldOut => 'All tickets for this event are sold out.';

  @override
  String get errorCheckoutInsufficientStock =>
      'Not enough tickets available. Lower the quantity or choose another option.';

  @override
  String get errorCheckoutOfferingSoldOut =>
      'This ticket option just sold out. Please choose another.';

  @override
  String get errorCheckoutTableLockRequired =>
      'Your table reservation expired. Please reserve the table again.';

  @override
  String get errorCheckoutTableNotAvailable =>
      'This table is no longer available.';

  @override
  String get errorCheckoutTableLocked => 'This table is held by another guest.';

  @override
  String get errorCheckoutOfferingNotFound =>
      'This ticket option is no longer available.';

  @override
  String get vipSecurePayment => '100% secure payment';

  @override
  String get vipOfferingGeneral => 'GENERAL - STANDARD';

  @override
  String get vipMesasVipTitle => 'VIP Tables';

  @override
  String get vipMesasVipSubtitle => 'Choose your table →';

  @override
  String get vipFloorPlanTitle => 'Venue floor plan';

  @override
  String get vipFloorPlanHeading => 'Venue floor plan';

  @override
  String get vipFloorPlanVenueName => 'Main hall';

  @override
  String get vipFloorPlanSize => '36 x 18 m';

  @override
  String vipFloorPlanSubtitle(String venue, String size) {
    return '$venue • $size';
  }

  @override
  String get vipFloorPlanDimensions => 'Main hall - 36 x 18 m';

  @override
  String get vipTapVipZoneTitle => 'Tap a VIP zone';

  @override
  String get vipTapVipZoneSubtitle => 'Select a zone to see available tables';

  @override
  String get vipYouFestBrand => 'YouFest';

  @override
  String get vipLegendAvailable => 'Available';

  @override
  String get vipLegendPremium => 'Premium';

  @override
  String get vipLegendSold => 'Sold';

  @override
  String get vipZone1Name => 'VIP 1';

  @override
  String get vipZone2Name => 'VIP 2';

  @override
  String get vipZoneDj => 'VIP DJ';

  @override
  String get vipZoneStage => 'DJ STAGE';

  @override
  String get vipZoneDanceFloor => 'DANCE FLOOR';

  @override
  String get vipZoneLabel => 'ZONE';

  @override
  String vipZoneCapacity(int count) {
    return '$count spots/table';
  }

  @override
  String get vipEmergencyExit => 'EMERGENCY EXIT';

  @override
  String get vipLegendAvailableShort => 'Avail';

  @override
  String get vipLegendUnselected => 'Unselected';

  @override
  String get vipDanceFloorGeneral => 'General';

  @override
  String vipTableDistributionTitle(String zone) {
    return '$zone DISTRIBUTION';
  }

  @override
  String get vipTableDistributionStage => 'DJ Stage';

  @override
  String get vipLegendTableAvailable => 'Available';

  @override
  String get vipLegendTablePremium => 'Premium';

  @override
  String get vipLegendTableSelection => 'Selected';

  @override
  String get vipLegendTableSold => 'Sold';

  @override
  String vipZoneTablesScreenTitle(String zone) {
    return 'Tables $zone';
  }

  @override
  String get vipTablesZoneSoldOut => 'All tables in this zone are sold out.';

  @override
  String get vipTablePremiumBadge => 'Premium';

  @override
  String get vipTablesZoneTitle => 'VIP Tables 1';

  @override
  String vipTablesCapacitySubtitle(int count) {
    return '$count people per table';
  }

  @override
  String vipPurchaseOfferingLine(String label, int quantity) {
    return '$label x$quantity';
  }

  @override
  String vipTableReserve(String table) {
    return 'Reserve Table $table';
  }

  @override
  String vipTableDetailTitle(String table, String zone) {
    return 'Table $table — $zone';
  }

  @override
  String vipTableCapacity(int count) {
    return '$count guests';
  }

  @override
  String vipTableIncludes(int bottles, int vouchers) {
    return '$bottles bottles · $vouchers vouchers';
  }

  @override
  String vipTableBottles(int count) {
    return '$count bottles';
  }

  @override
  String vipTableVouchers(int count) {
    return '$count vouchers';
  }

  @override
  String vipTableIncludesShort(String people, String bottles, String vouchers) {
    return '$people • $bottles • $vouchers';
  }

  @override
  String get vipPurchaseSummaryTitle => 'Purchase summary';

  @override
  String vipPurchaseSummaryItemTitle(String table, String zone, String event) {
    return 'Table $table - $zone | $event';
  }

  @override
  String get vipServiceFee => 'Service';

  @override
  String get vipPurchaseSubtotal => 'Subtotal';

  @override
  String get vipPurchaseServiceCharge => 'Service charge';

  @override
  String get vipGeneralAccessLabel => 'General access';

  @override
  String vipVoucherCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vouchers',
      one: '1 voucher',
    );
    return '$_temp0';
  }

  @override
  String vipPurchaseTicketDetailsLine(
    String entries,
    String access,
    String vouchers,
  ) {
    return '$entries • $access • $vouchers';
  }

  @override
  String get vipPurchaseTotal => 'Total';

  @override
  String get vipPaymentMethod => 'PAYMENT METHOD';

  @override
  String get vipSavedCard => 'Visa ending in 4205';

  @override
  String get vipAddPaymentMethod => 'Add payment method';

  @override
  String vipPurchaseAssignTicketsInfo(String myTickets) {
    return 'After payment, you can assign tickets to your guests or do it later from $myTickets.';
  }

  @override
  String vipPayButton(String amount) {
    return 'Pay $amount';
  }

  @override
  String get vipPurchaseSuccessTitle => 'Purchase successful!';

  @override
  String get vipPurchaseSuccessMessage =>
      'Your tickets are ready in My Tickets.';

  @override
  String get vipPurchaseGoToMyTickets => 'Go to my tickets';

  @override
  String vipTableLockCountdown(String time) {
    return 'Complete payment in $time';
  }

  @override
  String vipTableLockReservedCountdown(String time) {
    return 'Your table is reserved for $time';
  }

  @override
  String get vipTableLockExpired =>
      'Your table reservation expired. Please select a table again.';

  @override
  String get vipTableLockExpiredTitle => 'Your reservation has expired';

  @override
  String get vipTableLockExpiredMessage =>
      'The table has been released. Please return to the floor plan to select again.';

  @override
  String get vipTableLockExpiredReturnFloorPlan => 'Return to floor plan';

  @override
  String get vipTableBlockedMessage =>
      'This table is being reserved. Try again in a few minutes or choose another table.';

  @override
  String get vipTableBlockedReserve =>
      'This table is being reserved. Try again in a few minutes or choose another table.';

  @override
  String get vipLegendTableBlocked => 'Blocked';

  @override
  String get eventDetailTicketsUnavailable =>
      'Tickets are not available for this event yet.';

  @override
  String get vipViewQr => 'View QR';

  @override
  String get waitlistJoinButton => 'Join waiting list';

  @override
  String get waitlistLeaveButton => 'Leave waiting list';

  @override
  String get waitlistJoinTitle => 'Join waiting list';

  @override
  String get waitlistJoinConfirm => 'Confirm join';

  @override
  String waitlistJoinSuccess(String eventName) {
    return 'You are on the waiting list for $eventName. We will notify you immediately if a slot opens up.';
  }

  @override
  String waitlistEstimatedPosition(String position) {
    return 'You are #$position on the waiting list';
  }

  @override
  String get waitlistLeaveTitle => 'Leave waiting list?';

  @override
  String get waitlistLeaveMessage =>
      'Are you sure? You will lose your position in the queue.';

  @override
  String get waitlistLeaveConfirm => 'Leave list';

  @override
  String get waitlistClaimSlot => 'CLAIM MY SLOT';

  @override
  String waitlistOfferBanner(String time) {
    return 'A slot is waiting for you! Confirm before $time';
  }

  @override
  String get waitlistAlreadyHasCourtesy =>
      'You already have a courtesy invitation';

  @override
  String get waitlistAlreadyHasCourtesyHint =>
      'You don\'t need the waiting list for this event. Open your invitations to view or manage it.';

  @override
  String get waitlistAlreadyOnWaitlist => 'You are already on the waiting list';

  @override
  String get waitlistDisabled => 'Waiting list is not enabled for this event';

  @override
  String get waitlistNotAvailable =>
      'Courtesy slots are still available. You can request an invitation instead of joining the waiting list.';

  @override
  String get waitlistViewInvitations => 'View invitations';

  @override
  String get waitlistStatusTitle => 'Waiting list unavailable';

  @override
  String get errorStaffNotFound =>
      'No staff account found for this number. Ask your admin to register you.';

  @override
  String get errorNetworkConnection =>
      'Could not reach the server. Check your connection and try again.';

  @override
  String get staffScanQrTitle => 'SCAN QR';

  @override
  String get staffScanQrSubtitle => 'Tap to start scanning';

  @override
  String get staffScanQrAreaLabel => 'AREA QR';

  @override
  String get staffScanQrInstruction => 'Keep the code\ninside the frame';

  @override
  String get staffScanFlashLabel => 'Flash';

  @override
  String get staffScanCameraUnavailable =>
      'Camera is not available on this device.';

  @override
  String get staffScanPermissionDenied =>
      'Camera permission is required to scan QR codes.';

  @override
  String get staffManualEntryButton => 'MANUAL ENTRY';

  @override
  String get staffSupervisorModeButton => 'SUPERVISOR MODE';

  @override
  String get staffManualEntryScreenTitle => 'Manual entry';

  @override
  String get staffManualEntryScreenSubtitle =>
      'Type the ticket code to validate entry. Results match QR scanning and cannot be overridden.';

  @override
  String get staffManualConsumptionScreenTitle => 'Manual consumption';

  @override
  String get staffManualConsumptionScreenSubtitle =>
      'Type the redemption code to validate the purchase. Results match QR scanning and cannot be overridden.';

  @override
  String get staffManualEntryCodeHint => '8F7A2B';

  @override
  String get staffManualEntryValidateButton => 'VALIDATE';

  @override
  String get staffScanConsumptionTitle => 'SCAN CONSUMPTION';

  @override
  String get staffSupervisorSearchManageTicketTitle => 'Search / Manage ticket';

  @override
  String get staffSupervisorSearchManageTicketDescription =>
      'Find a ticket by code, name, phone, ID, or purchase ID, then take only the actions that fit its status.';

  @override
  String get staffSupervisorAccessHistoryTitle => 'Access history';

  @override
  String get staffSupervisorAccessHistoryDescription =>
      'Review recent entry activity and open any record for full details.';

  @override
  String get staffSupervisorSearchManagePurchaseTitle =>
      'Search / Manage purchase';

  @override
  String get staffSupervisorSearchManagePurchaseLine1 =>
      'Find an order by code, name, phone, or purchase ID';

  @override
  String get staffSupervisorSearchManagePurchaseLine2 =>
      'Restore consumption when delivery failed';

  @override
  String get staffSupervisorRedemptionHistoryTitle => 'Redemption history';

  @override
  String get staffSupervisorRedemptionHistoryLine1 =>
      'Recent drink redemptions and restorations';

  @override
  String get staffSupervisorRedemptionHistoryLine2 =>
      'Open any record for full audit details';

  @override
  String get staffSupervisorAuthorizeReentryAction => 'Authorize re-entry';

  @override
  String get staffSupervisorRegisterExceptionalEntryAction =>
      'Register exceptional entry';

  @override
  String get staffSupervisorNoActionForBlockedTicket =>
      'This ticket is blocked or cancelled. No authorization action is available.';

  @override
  String get staffSupervisorNoActionForActiveTicket =>
      'This ticket is active and unused. No supervisor override is required.';

  @override
  String get staffSupervisorNoRestoreActionAvailable =>
      'No exceptional action is available for this purchase status.';

  @override
  String get staffSupervisorRestoreConsumptionAction => 'Restore consumption';

  @override
  String get staffSupervisorRestoreReasonTitle => 'Restore reason';

  @override
  String get staffSupervisorRestoreReasonProductNotDelivered =>
      'Product not delivered';

  @override
  String get staffSupervisorRestoreReasonAccidentalScan => 'Accidental scan';

  @override
  String get staffSupervisorRestoreReasonOperationalIssue =>
      'Operational issue';

  @override
  String get staffSupervisorRestoreReasonOther => 'Other';

  @override
  String get staffSupervisorRestoreReasonOtherHint => 'Describe the issue';

  @override
  String get staffSupervisorRestoreExecuteButton => 'RESTORE CONSUMPTION';

  @override
  String get staffSupervisorAccessHistoryEmpty =>
      'No entry activity yet for this event.';

  @override
  String get staffSupervisorAccessResultValid => 'VALID';

  @override
  String get staffSupervisorAccessResultReEntry => 'RE-ENTRY';

  @override
  String get staffSupervisorAccessResultRejected => 'REJECTED';

  @override
  String get staffSupervisorAccessResultSupervisor => 'SUPERVISOR';

  @override
  String get staffSupervisorRedemptionHistoryEmpty =>
      'No redemptions yet for this event.';

  @override
  String get staffSupervisorRedemptionResultRedeemed => 'REDEEMED';

  @override
  String get staffSupervisorRedemptionResultRestored => 'RESTORED';

  @override
  String get staffSupervisorRedemptionResultDuplicate => 'DUPLICATE ATTEMPT';

  @override
  String get staffSupervisorRedemptionResultSupervisor => 'SUPERVISOR';

  @override
  String get staffSupervisorRedemptionDetailTitle => 'Redemption details';

  @override
  String get staffSupervisorRedemptionDetailResult => 'Result';

  @override
  String get staffSupervisorRedemptionDetailProduct => 'Product';

  @override
  String get staffSupervisorRedemptionDetailCustomer => 'Customer';

  @override
  String get staffSupervisorRedemptionDetailOrder => 'Order ID';

  @override
  String get staffSupervisorRedemptionDetailCode => 'Manual code';

  @override
  String get staffSupervisorRedemptionDetailBar => 'Bar / location';

  @override
  String get staffSupervisorRedemptionDetailStaff => 'Staff';

  @override
  String get staffSupervisorRedemptionDetailTime => 'Time';

  @override
  String get staffSupervisorRedemptionDetailStatus => 'Current status';

  @override
  String get staffSupervisorSearchEntryTicketTypeLabel => 'Ticket';

  @override
  String get staffSupervisorSearchEntryPurchaseStatusLabel => 'Purchase status';

  @override
  String get staffSupervisorSearchEntryAccessPointLabel => 'Access point';

  @override
  String get staffRecentScansTitle => 'Recent scans';

  @override
  String get staffRecentScanActionAuthorizeConsumption =>
      'Consumption authorized';

  @override
  String get staffRecentScanActionRejectConsumption => 'Consumption rejected';

  @override
  String get staffRecentScansEmpty =>
      'No product scans yet. Scan a drink QR to see it here.';

  @override
  String get staffViewAllScans => 'View all >';

  @override
  String get staffScanDuplicateLabel => 'Duplicate';

  @override
  String get staffConnectedLabel => 'Connected';

  @override
  String get staffDisconnectedLabel => 'Disconnected';

  @override
  String get staffOnlineStatus => 'Online';

  @override
  String get staffAwayStatus => 'Away';

  @override
  String get staffDrawerTitle => 'Staff menu';

  @override
  String get staffApiEnvironmentLabel => 'API environment';

  @override
  String get staffApiEnvDevLocal => 'Dev (local)';

  @override
  String get staffApiEnvDevNgrok => 'Dev (ngrok)';

  @override
  String get staffApiEnvProduction => 'Production';

  @override
  String get staffApiEnvCustom => 'Custom API';

  @override
  String get staffNgrokTunnelLabel => 'Ngrok tunnel (physical device)';

  @override
  String get staffLanguageLabel => 'Language';

  @override
  String get staffLanguageEnglish => 'English';

  @override
  String get staffLanguageSpanish => 'Spanish';

  @override
  String get staffLogout => 'Log out';

  @override
  String get staffSupervisorMode => 'Supervisor mode';

  @override
  String get staffBarSupervisorMode => 'Bar supervisor';

  @override
  String get staffTicketsSupervisorMode => 'Tickets supervisor';

  @override
  String get staffAccessValidatorMenu => 'Access validator';

  @override
  String get staffSupervisorPinTitle => 'Supervisor access';

  @override
  String get staffSupervisorPinSubtitle =>
      'Enter your PIN to continue and access supervisor mode.';

  @override
  String get staffSupervisorPinFieldLabel => 'Enter PIN';

  @override
  String get staffSupervisorPinContinueButton => 'CONTINUE';

  @override
  String get staffSupervisorPinFooter => 'Only authorized staff can access.';

  @override
  String get staffSupervisorPinInvalid => 'Incorrect PIN. Try again.';

  @override
  String get staffSupervisorPinNotConfigured =>
      'Supervisor PIN has not been set up yet. Ask an administrator to generate one.';

  @override
  String get staffSupervisorPinAccessDenied =>
      'Your account is not authorized for supervisor mode.';

  @override
  String get staffSupervisorDashboardTitle => 'SUPERVISOR MODE';

  @override
  String get staffSupervisorDashboardSubtitle => 'Advanced bar control';

  @override
  String get staffSupervisorCancellationsTitle => 'CANCELLATIONS';

  @override
  String get staffSupervisorCancelConsumption => 'Cancel consumption';

  @override
  String get staffSupervisorRevertValidation => 'Revert validation';

  @override
  String get staffSupervisorReleaseBlockedQr => 'Release blocked QR code';

  @override
  String get staffSupervisorManualValidationTitle => 'MANUAL VALIDATION';

  @override
  String staffSupervisorManualValidationUser(String userName) {
    return 'User: $userName';
  }

  @override
  String staffSupervisorManualValidationProduct(String productName) {
    return 'Product: $productName';
  }

  @override
  String staffSupervisorManualValidationCode(String code) {
    return 'Partial code: $code';
  }

  @override
  String get staffSupervisorQrOverrideTitle => 'QR CODE OVERRIDE';

  @override
  String staffSupervisorQrOverrideSupervisor(String supervisorName) {
    return 'Supervisor: $supervisorName';
  }

  @override
  String get staffSupervisorGoButton => 'Go';

  @override
  String get staffSupervisorRecentActionsTitle => 'RECENT ACTIONS';

  @override
  String get staffSupervisorViewAllActions => 'View all >';

  @override
  String get staffSupervisorActionQrReleased => 'QR code released';

  @override
  String get staffSupervisorActionManualValidation => 'Manual validation';

  @override
  String get staffSupervisorActionConsumptionCancelled =>
      'Consumption cancelled';

  @override
  String get staffSupervisorComingSoon => 'Coming soon';

  @override
  String get staffSupervisorCancellationsScreenTitle => 'Cancellations';

  @override
  String get staffSupervisorCancellationsScreenSubtitle =>
      'Supervisor · YouPass';

  @override
  String get staffSupervisorSearchConsumptionTitle => 'SEARCH CONSUMPTION';

  @override
  String get staffSupervisorSearchConsumptionHeading => 'Search consumption';

  @override
  String get staffSupervisorSearchDrinkNoResults =>
      'No consumptions found for this search.';

  @override
  String get staffSupervisorSearchDrinkSearchError =>
      'Could not search consumptions. Try again.';

  @override
  String staffSupervisorSearchDrinkResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results found',
      one: '1 result found',
    );
    return '$_temp0';
  }

  @override
  String get staffSupervisorSearchPlaceholder => 'QR / user / product';

  @override
  String get staffSupervisorSearchButton => 'SEARCH';

  @override
  String get staffSupervisorConsumptionFoundTitle => 'CONSUMPTION FOUND';

  @override
  String get staffSupervisorConsumptionUserLabel => 'User';

  @override
  String get staffSupervisorConsumptionProductLabel => 'Product';

  @override
  String get staffSupervisorConsumptionBarLabel => 'Bar';

  @override
  String get staffSupervisorConsumptionTimeLabel => 'Validation time';

  @override
  String get staffSupervisorConsumptionPurchaseTimeLabel => 'Purchase time';

  @override
  String get staffSupervisorConsumptionRedemptionTimeLabel => 'Redemption time';

  @override
  String get staffSupervisorConsumptionIdLabel => 'Consumption ID';

  @override
  String get staffSupervisorConsumptionStatusLabel => 'Status';

  @override
  String get staffSupervisorConsumptionStatusValidated => 'VALIDATED';

  @override
  String get staffSupervisorActionsTitle => 'ACTIONS';

  @override
  String get staffSupervisorReasonTitle => 'MANDATORY REASON';

  @override
  String get staffSupervisorReasonPlaceholder =>
      'Write the reason for the cancellation...';

  @override
  String get staffSupervisorReasonHint =>
      'Example: \'Wrong product delivered\'';

  @override
  String get staffSupervisorAuthorizationTitle => 'AUTHORIZATION';

  @override
  String get staffSupervisorAuthorizationSupervisorLabel => 'Supervisor';

  @override
  String get staffSupervisorAuthorizationPinLabel => 'Supervisor PIN';

  @override
  String get staffSupervisorHistoryTitle => 'HISTORY';

  @override
  String staffSupervisorHistoryValidated(String time) {
    return 'Validated — $time';
  }

  @override
  String get staffSupervisorHistoryPending => 'Supervisor pending';

  @override
  String get staffSupervisorExecuteCancellationButton => 'EXECUTE CANCELLATION';

  @override
  String get staffSupervisorCancellationSuccess =>
      'Cancellation recorded successfully.';

  @override
  String get staffSupervisorManualValidationScreenTitle => 'Manual validation';

  @override
  String get staffSupervisorNoQrBannerTitle => 'CONSUMPTION WITHOUT QR';

  @override
  String get staffSupervisorNoQrBannerBody =>
      'Enter the purchase QR code to validate manually.';

  @override
  String get staffSupervisorEnterQrCodeTitle =>
      'ENTER QR CODE (PRIMARY OPTION)';

  @override
  String get staffSupervisorEnterQrCodePlaceholder => 'Enter the QR code';

  @override
  String get staffSupervisorSearchQrCodeButton => 'SEARCH CODE';

  @override
  String get staffSupervisorOrDivider => 'or';

  @override
  String get staffSupervisorSearchUserHeading => 'Search user';

  @override
  String get staffSupervisorSearchUserPlaceholder => 'Name / phone';

  @override
  String get staffSupervisorSearchSystemButton => 'SEARCH SYSTEM';

  @override
  String get staffSupervisorResultFoundTitle => 'RESULT FOUND';

  @override
  String get staffSupervisorResultEventLabel => 'Event';

  @override
  String get staffSupervisorResultPurchaseLabel => 'Purchase';

  @override
  String get staffSupervisorQrStatusLabel => 'QR status';

  @override
  String get staffSupervisorQrStatusUnavailable => 'QR UNAVAILABLE';

  @override
  String get staffSupervisorValidationReasonTitle => 'VALIDATION REASON';

  @override
  String get staffSupervisorReasonPhoneBattery => 'Phone out of battery';

  @override
  String get staffSupervisorReasonNoConnection => 'No connection';

  @override
  String get staffSupervisorReasonDamagedQr => 'Damaged QR';

  @override
  String get staffSupervisorReasonBrokenScreen => 'Broken screen';

  @override
  String get staffSupervisorReasonOther => 'Other';

  @override
  String get staffSupervisorIdentityValidationTitle => 'IDENTITY VALIDATION';

  @override
  String get staffSupervisorIdentityFullNameLabel => 'Full name';

  @override
  String get staffSupervisorIdentityLastDigitsLabel => 'Last 4 digits';

  @override
  String get staffSupervisorIdentityDocumentLabel => 'Document validated';

  @override
  String get staffSupervisorIdentityConfirmed => 'Confirmed';

  @override
  String get staffSupervisorAuthorizeConsumptionButton =>
      'AUTHORIZE CONSUMPTION';

  @override
  String get staffSupervisorGenerateTemporaryQrButton =>
      'GENERATE TEMPORARY QR';

  @override
  String get staffSupervisorRejectButton => 'REJECT';

  @override
  String get staffSupervisorValidationReasonPlaceholder =>
      'Write the reason for the validation...';

  @override
  String get staffSupervisorSystemRecordTitle => 'SYSTEM RECORD';

  @override
  String staffSupervisorSystemRecordSupervisor(String name) {
    return 'Supervisor: $name';
  }

  @override
  String staffSupervisorSystemRecordTime(String time) {
    return 'Time: $time';
  }

  @override
  String get staffSupervisorSystemRecordStatus => 'Status: ';

  @override
  String get staffSupervisorSystemRecordStatusPending => 'Pending';

  @override
  String get staffSupervisorQrOverrideScreenTitle => 'QR code override';

  @override
  String get staffSupervisorOverrideCriticalTitle => 'CRITICAL ACTION';

  @override
  String get staffSupervisorOverrideCriticalBody =>
      'This tool modifies the QR status in the system.';

  @override
  String get staffSupervisorOverrideSearchTitle => 'SEARCH QR / USER';

  @override
  String get staffSupervisorOverrideSearchPlaceholder =>
      'QR / name / purchase ID';

  @override
  String get staffSupervisorOverrideActionsTitle => 'OVERRIDE ACTIONS';

  @override
  String get staffSupervisorOverrideReleaseQr => 'Release QR';

  @override
  String get staffSupervisorOverrideRevalidateQr => 'Revalidate QR';

  @override
  String get staffSupervisorOverrideAuthorizeReconsumption =>
      'Authorize re-consumption';

  @override
  String get staffSupervisorOverrideTemporaryUnlock => 'Temporary unlock';

  @override
  String get staffSupervisorOverrideReasonPlaceholder =>
      'Write the reason for the override...';

  @override
  String get staffSupervisorOverrideReasonHint =>
      'Example: \'QR marked incorrectly\'';

  @override
  String get staffSupervisorOverrideQrIdLabel => 'QR ID';

  @override
  String get staffSupervisorOverrideCurrentStatusLabel => 'Current status';

  @override
  String get staffSupervisorOverrideStatusBlocked => 'BLOCKED';

  @override
  String get staffSupervisorOverrideLastUseLabel => 'Last use';

  @override
  String get staffSupervisorOverrideScannerLabel => 'Scanner';

  @override
  String get staffSupervisorOverrideAuthLevelLabel => 'Authorization level:';

  @override
  String get staffSupervisorOverrideAuthLevelHigh => 'HIGH';

  @override
  String get staffSupervisorOverrideExpectedResultTitle => 'EXPECTED RESULT';

  @override
  String get staffSupervisorOverrideExpectedStatusPrefix => 'QR status →';

  @override
  String get staffSupervisorOverrideExpectedStatus => 'QR status → VALID';

  @override
  String get staffSupervisorOverrideExpectedSubtext =>
      'New consumption allowed.';

  @override
  String get staffSupervisorOverrideLogsTitle => 'QR LOGS';

  @override
  String get staffSupervisorOverrideLogsEmpty => 'No QR activity recorded yet.';

  @override
  String get staffSupervisorOverrideLogQrBlocked => 'QR blocked';

  @override
  String get staffSupervisorOverrideLogPending => 'Override pending';

  @override
  String get staffSupervisorExecuteOverrideButton => 'EXECUTE OVERRIDE';

  @override
  String get staffSupervisorAccessDashboardSubtitle =>
      'Access advanced tools to manage entry and resolve contingencies.';

  @override
  String get staffSupervisorSearchEntryTitle => 'Search entry';

  @override
  String get staffSupervisorSearchEntryDescription =>
      'Search and review entry status by name, code, phone, and more.';

  @override
  String get staffSupervisorResolveDuplicateTitle => 'Resolve duplicate';

  @override
  String get staffSupervisorResolveDuplicateDescription =>
      'Manage duplicate entries or unauthorized uses.';

  @override
  String get staffSupervisorEntryOverrideDescription =>
      'Authorize, release, or manually revalidate an entry.';

  @override
  String get staffSupervisorEntryAuthorizationTitle =>
      'SUPERVISOR AUTHORIZATION';

  @override
  String get staffSupervisorEntryAccessLabel => 'Access';

  @override
  String get staffSupervisorEntryOverrideCriticalBody =>
      'This tool directly modifies the QR status within the system.';

  @override
  String get staffSupervisorEntryOverrideReasonPlaceholder =>
      'Describe the reason for the override';

  @override
  String get staffSupervisorEntryOverrideReasonHint =>
      'Example: \'QR marked as used accidentally\'';

  @override
  String get staffSupervisorOverrideAuthorizeReentry => 'Authorize re-entry';

  @override
  String get staffSupervisorEntryOverrideExpectedValid => 'VALID';

  @override
  String get staffSupervisorEntryOverrideExpectedSubtext => 'Re-entry allowed';

  @override
  String get staffSupervisorEntryManualValidationTitle => 'Manual validation';

  @override
  String get staffSupervisorEntryManualValidationDescription =>
      'Validate access manually when no QR is available.';

  @override
  String get staffSupervisorEntryNoQrBannerTitle => 'NO QR ACCESS';

  @override
  String get staffSupervisorEntryNoQrBannerBody =>
      'Use this option only in justified cases';

  @override
  String get staffSupervisorEntryManualSearchPlaceholder =>
      'Name / phone / email';

  @override
  String get staffSupervisorEntryManualReasonTitle => 'Manual access reason';

  @override
  String get staffSupervisorEntryManualReasonOtherPlaceholder =>
      'Specify the reason';

  @override
  String get staffSupervisorEntryManualIdentityPhoneLabel =>
      'Last 4 phone digits';

  @override
  String get staffSupervisorEntryManualAuthorizeEntry => 'AUTHORIZE ENTRY';

  @override
  String get staffSupervisorEntryManualRejectAccess => 'REJECT ACCESS';

  @override
  String get staffSupervisorEntryManualReasonPlaceholder =>
      'Describe the reason for manual access';

  @override
  String get staffSupervisorEntryManualSystemStatusLabel => 'Status: ';

  @override
  String get staffSupervisorEntryManualSystemStatusPending =>
      'Pending authorization';

  @override
  String get staffSupervisorEntryManualValidationSuccess =>
      'Manual validation applied successfully.';

  @override
  String get staffSupervisorTemporaryQrDialogTitle => 'Temporary QR generated';

  @override
  String staffSupervisorTemporaryQrDialogSubtitle(int minutes) {
    return 'Show this QR at the door. Valid for $minutes minutes.';
  }

  @override
  String staffSupervisorTemporaryQrDialogGuest(String guestName) {
    return 'Guest: $guestName';
  }

  @override
  String get staffSupervisorTemporaryQrDialogClose => 'Done';

  @override
  String get staffSupervisorTemporaryQrGeneratedSuccess =>
      'Temporary QR ready to display.';

  @override
  String get staffSupervisorVipManagementTitle => 'VIP management';

  @override
  String get staffSupervisorVipManagementDescription =>
      'Review and authorize special access for VIP guests.';

  @override
  String get staffSupervisorVipSearchPlaceholder =>
      'Search table / user (e.g. Table 12 / Daniel Rojas)';

  @override
  String get staffSupervisorVipSearchSectionTitle => 'SEARCH VIP TABLE';

  @override
  String get staffSupervisorVipSearchNoResults =>
      'No VIP tables found for this search.';

  @override
  String staffSupervisorVipSearchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tables found',
      one: '1 table found',
    );
    return '$_temp0';
  }

  @override
  String get staffSupervisorVipStatusLabel => 'Status:';

  @override
  String get staffSupervisorVipStatusActive => 'ACTIVE';

  @override
  String get staffSupervisorVipCapacityLabel => 'Capacity';

  @override
  String staffSupervisorVipCapacityPeople(int count) {
    return '$count people';
  }

  @override
  String get staffSupervisorVipEnteredLabel => 'Entered';

  @override
  String get staffSupervisorVipPendingLabel => 'Pending';

  @override
  String get staffSupervisorVipPurchaseResponsibleLabel => 'Purchase owner:';

  @override
  String get staffSupervisorVipGuestsTitle => 'GUESTS';

  @override
  String staffSupervisorVipGuestEntered(String time) {
    return 'Entered - $time';
  }

  @override
  String get staffSupervisorVipGuestPending => 'Entry pending';

  @override
  String get staffSupervisorVipActionAuthorizeExtra => 'Authorize extra guest';

  @override
  String get staffSupervisorVipActionChangeAccess => 'Change VIP access';

  @override
  String get staffSupervisorVipActionMoveGuest => 'Move guest';

  @override
  String get staffSupervisorVipActionReleaseInvitation => 'Release invitation';

  @override
  String get staffSupervisorVipNewExtraGuestTitle => 'NEW EXTRA GUEST';

  @override
  String get staffSupervisorVipGuestNameLabel => 'Name';

  @override
  String get staffSupervisorVipGuestNamePlaceholder => 'Full name';

  @override
  String get staffSupervisorVipGuestPhoneLabel => 'Phone';

  @override
  String get staffSupervisorVipGuestPhonePlaceholder => 'E.g. +56 9 1234 5678';

  @override
  String get staffSupervisorVipAuthorizationReasonLabel =>
      'Authorization reason';

  @override
  String get staffSupervisorVipAuthorizationReasonPlaceholder =>
      'Describe the reason for authorization';

  @override
  String get staffSupervisorVipHistoryTitle => 'VIP HISTORY';

  @override
  String get staffSupervisorVipHistorySupervisorPrefix => 'Supervisor';

  @override
  String get staffSupervisorVipHistoryExtraGuest => 'Extra guest authorized';

  @override
  String get staffSupervisorVipHistoryQrReleased => 'VIP QR released';

  @override
  String get staffSupervisorVipHistoryTableModified => 'Table modified';

  @override
  String get staffSupervisorVipSearchResultsTitle => 'MATCHING TABLES';

  @override
  String get staffSupervisorVipActionSuccess =>
      'VIP action applied successfully.';

  @override
  String get staffSupervisorVipSelectGuestRelease =>
      'Tap a guest to release their invitation QR.';

  @override
  String get staffSupervisorVipSelectGuestChangeAccess =>
      'Tap a guest to change their VIP access level.';

  @override
  String get staffSupervisorVipSelectGuestMove =>
      'Tap a guest to move them to another seat.';

  @override
  String get staffSupervisorVipSelectAccessTitle => 'NEW ACCESS LEVEL';

  @override
  String get staffSupervisorVipSelectDestinationTitle => 'DESTINATION SEAT';

  @override
  String get staffSupervisorVipNoAvailableSeats =>
      'No empty seats available on this table.';

  @override
  String get staffSupervisorVipReleaseInvitationHint =>
      'This unlocks the guest QR immediately without removing them from the table.';

  @override
  String get staffSupervisorSystemStatusTitle => 'System status';

  @override
  String get staffSupervisorSystemStatusDescription =>
      'Review connectivity, sync, and validator status.';

  @override
  String get staffSupervisorSystemGeneralStatusTitle => 'GENERAL STATUS';

  @override
  String get staffSupervisorSystemHealthSystem => 'System';

  @override
  String get staffSupervisorSystemHealthSync => 'Synchronization';

  @override
  String get staffSupervisorSystemHealthDatabase => 'Database';

  @override
  String get staffSupervisorSystemHealthOfflineMode => 'Offline mode';

  @override
  String get staffSupervisorSystemStatusOnline => 'ONLINE';

  @override
  String get staffSupervisorSystemStatusSlowSync => 'SLOW';

  @override
  String get staffSupervisorSystemStatusSlowScanner => 'SLOW';

  @override
  String get staffSupervisorSystemStatusOperational => 'OPERATIONAL';

  @override
  String get staffSupervisorSystemStatusDisabled => 'DISABLED';

  @override
  String get staffSupervisorSystemStatusDisconnected => 'DISCONNECTED';

  @override
  String get staffSupervisorSystemActiveScannersTitle => 'ACTIVE SCANNERS';

  @override
  String get staffSupervisorSystemRestartScannerButton => 'RESTART SCANNER';

  @override
  String get staffSupervisorSystemActiveAlertsTitle => 'ACTIVE ALERTS';

  @override
  String get staffSupervisorSystemAlertDuplicateQr => 'Duplicate QRs detected';

  @override
  String get staffSupervisorSystemAlertVipQueue => 'Saturated VIP access queue';

  @override
  String get staffSupervisorSystemAlertScannerSlow => 'Scanner VIP-01 slow';

  @override
  String get staffSupervisorSystemEventFlowTitle => 'EVENT FLOW';

  @override
  String get staffSupervisorSystemEventFlowSubtitle =>
      'Entries in the last 5 min';

  @override
  String get staffSupervisorSystemFlowGeneral => 'General';

  @override
  String get staffSupervisorSystemFlowVip => 'VIP';

  @override
  String get staffSupervisorSystemFlowBackstage => 'Backstage';

  @override
  String get staffSupervisorSystemFlowRejected => 'Rejected';

  @override
  String get staffSupervisorSystemFlowDuplicates => 'Duplicates';

  @override
  String get staffSupervisorSystemQuickActionsTitle => 'QUICK ACTIONS';

  @override
  String get staffSupervisorSystemActionOfflineMode => 'ACTIVATE OFFLINE MODE';

  @override
  String get staffSupervisorSystemActionPauseValidations => 'PAUSE VALIDATIONS';

  @override
  String get staffSupervisorSystemActionManualAccess => 'OPEN MANUAL ACCESS';

  @override
  String get staffSupervisorSystemActionBlockVip => 'BLOCK VIP ACCESS';

  @override
  String get staffSupervisorSystemActionStaffAlert => 'SEND STAFF ALERT';

  @override
  String get staffSupervisorSystemOperationalSemaphoreTitle =>
      'OPERATIONAL SEMAPHORE';

  @override
  String get staffSupervisorSystemRiskModerate => 'MODERATE RISK';

  @override
  String get staffSupervisorSystemRiskReasonLabel => 'Reason: ';

  @override
  String get staffSupervisorSystemRiskReasonVipFlow => 'High VIP access flow';

  @override
  String get staffSupervisorSystemRecentLogsTitle => 'RECENT LOGS';

  @override
  String get staffSupervisorSystemLogOfflineActivated =>
      'Offline mode activated';

  @override
  String get staffSupervisorSystemLogOverrideAuthorized =>
      'Override authorized';

  @override
  String get staffSupervisorSystemLogScannerRestarted =>
      'VIP scanner restarted';

  @override
  String get staffSupervisorSystemLogDuplicateDetected =>
      'Duplicate QR detected';

  @override
  String get staffSupervisorSystemLogOfflineDeactivated =>
      'Offline mode deactivated';

  @override
  String get staffSupervisorSystemLogValidationsPaused => 'Validations paused';

  @override
  String get staffSupervisorSystemLogValidationsResumed =>
      'Validations resumed';

  @override
  String get staffSupervisorSystemLogVipBlocked => 'VIP access blocked';

  @override
  String get staffSupervisorSystemLogStaffAlert => 'Staff alert sent';

  @override
  String get staffSupervisorSystemRiskReasonDuplicateQr =>
      'Duplicate QR activity detected';

  @override
  String get staffSupervisorSystemRiskReasonScannerSlow =>
      'One or more scanners are slow';

  @override
  String get staffSupervisorSystemRiskReasonValidationsPaused =>
      'Validations are paused';

  @override
  String get staffSupervisorSystemActionDeactivateOfflineMode =>
      'DEACTIVATE OFFLINE MODE';

  @override
  String get staffSupervisorSystemActionResumeValidations =>
      'RESUME VALIDATIONS';

  @override
  String get staffSupervisorSystemActionUnblockVip => 'UNBLOCK VIP ACCESS';

  @override
  String get staffSupervisorSystemActionSuccess =>
      'System action applied successfully';

  @override
  String get staffSupervisorSystemLoadError => 'Could not load system status';

  @override
  String get staffSupervisorSystemAlertMessageLabel => 'Alert message';

  @override
  String get staffSupervisorSystemAlertMessagePlaceholder =>
      'Describe the issue for staff on site';

  @override
  String get staffSupervisorSystemPinRequired => 'Supervisor PIN';

  @override
  String get staffSupervisorSystemDialogConfirm => 'Confirm';

  @override
  String get staffSupervisorSystemRetry => 'Retry';

  @override
  String get staffSupervisorActionHistoryTitle => 'Action history';

  @override
  String get staffSupervisorActionHistoryDescription =>
      'Review the latest actions performed in supervisor mode.';

  @override
  String get staffSupervisorActionHistoryEmpty =>
      'No supervisor actions recorded for this event yet.';

  @override
  String get staffSupervisorActionHistoryLoadError =>
      'Could not load action history';

  @override
  String get staffSupervisorActionHistoryKindReleaseQr => 'QR released';

  @override
  String get staffSupervisorActionHistoryKindRevalidateQr => 'QR revalidated';

  @override
  String get staffSupervisorActionHistoryKindRevertValidation =>
      'Validation reverted';

  @override
  String get staffSupervisorActionHistoryKindAuthorizeReentry =>
      'Re-entry authorized';

  @override
  String get staffSupervisorActionHistoryKindTemporaryUnlock =>
      'Temporary unlock applied';

  @override
  String get staffSupervisorActionHistoryKindReleaseReentry =>
      'Re-entry released';

  @override
  String get staffSupervisorActionHistoryKindBlockQr => 'QR blocked';

  @override
  String get staffSupervisorActionHistoryKindEscalateAlert => 'Alert escalated';

  @override
  String get staffSupervisorActionHistoryKindAuthorizeEntry =>
      'Manual entry authorized';

  @override
  String get staffSupervisorActionHistoryKindGenerateTemporaryQr =>
      'Temporary QR generated';

  @override
  String get staffSupervisorActionHistoryKindRejectAccess => 'Access rejected';

  @override
  String get staffSupervisorActionHistoryKindAuthorizeExtraGuest =>
      'Extra VIP guest authorized';

  @override
  String get staffSupervisorActionHistoryKindChangeAccess =>
      'VIP access changed';

  @override
  String get staffSupervisorActionHistoryKindMoveGuest => 'VIP guest moved';

  @override
  String get staffSupervisorActionHistoryKindReleaseInvitation =>
      'VIP invitation released';

  @override
  String get staffSupervisorActionHistoryKindOfflineModeEnabled =>
      'Offline mode activated';

  @override
  String get staffSupervisorActionHistoryKindOfflineModeDisabled =>
      'Offline mode deactivated';

  @override
  String get staffSupervisorActionHistoryKindValidationsPaused =>
      'Validations paused';

  @override
  String get staffSupervisorActionHistoryKindValidationsResumed =>
      'Validations resumed';

  @override
  String get staffSupervisorActionHistoryKindVipAccessBlocked =>
      'VIP access blocked';

  @override
  String get staffSupervisorActionHistoryKindVipAccessUnblocked =>
      'VIP access unblocked';

  @override
  String get staffSupervisorActionHistoryKindScannerRestarted =>
      'Scanner restarted';

  @override
  String get staffSupervisorActionHistoryKindStaffAlert => 'Staff alert sent';

  @override
  String get staffSupervisorExitModeButton => 'Exit supervisor mode';

  @override
  String staffSupervisorValidatorLabel(String validatorId) {
    return 'Validator: $validatorId';
  }

  @override
  String get staffSupervisorSearchEntryScreenTitle => 'Search entry';

  @override
  String get staffSupervisorSearchEntrySectionTitle => 'SEARCH ENTRY';

  @override
  String get staffSupervisorSearchEntryPlaceholder =>
      'Name / phone / RUT / QR / purchase ID / VIP table';

  @override
  String get staffSupervisorSearchEntryHeaderSubtitle =>
      'Supervisor · Supervisor mode';

  @override
  String get staffSupervisorSearchEntryByLabel => 'Search by:';

  @override
  String get staffSupervisorSearchEntryQuickFilters => 'Quick filters';

  @override
  String get staffSupervisorSearchEntryFilterVip => 'VIP';

  @override
  String get staffSupervisorSearchEntryFilterUsed => 'Used';

  @override
  String get staffSupervisorSearchEntryFilterError => 'Error';

  @override
  String get staffSupervisorSearchEntryPurchaseIdLabel => 'Purchase ID';

  @override
  String get staffSupervisorSearchEntryTimeLabel => 'Entry time';

  @override
  String get staffSupervisorSearchEntryValidatorLabel => 'Validator';

  @override
  String get staffSupervisorSearchEntryVipTableLabel => 'VIP table';

  @override
  String get staffSupervisorSearchEntryAssociatedLabel => 'Associated entries';

  @override
  String get staffSupervisorSearchEntryActionHistory => 'View history';

  @override
  String get staffSupervisorEntryHistoryTitle => 'Entry history';

  @override
  String get staffSupervisorEntryHistoryEmpty =>
      'No history recorded for this entry yet.';

  @override
  String staffSupervisorEntryHistoryQrLabel(String code) {
    return 'Entry code: $code';
  }

  @override
  String get staffSupervisorSearchEntryActionOverride => 'Manual override';

  @override
  String get staffSupervisorSearchEntryRecentEventsTitle => 'RECENT EVENTS';

  @override
  String get staffSupervisorEntryGateLabel => 'Gate';

  @override
  String get staffSupervisorEntryStatusValidated => 'VALIDATED';

  @override
  String get staffSupervisorEntryStatusPending => 'PENDING';

  @override
  String get staffSupervisorEntryStatusUsed => 'USED';

  @override
  String get staffSupervisorEntryStatusAlreadyUsed => 'ALREADY USED';

  @override
  String get staffSupervisorEntryStatusBlocked => 'BLOCKED';

  @override
  String get staffSupervisorEntryStatusError => 'ERROR';

  @override
  String get staffSupervisorSearchEntryNoResults =>
      'No entries found for this search.';

  @override
  String get staffSupervisorSearchEntryNoVipResults =>
      'No VIP entries match this search. Turn off the VIP filter or try another term.';

  @override
  String get staffSupervisorSearchEntryNoUsedResults =>
      'No used entries match this search. Turn off the Used filter or try another term.';

  @override
  String get staffSupervisorSearchEntryNoErrorResults =>
      'No error entries match this search. Turn off the Error filter or try another term.';

  @override
  String get staffSupervisorSearchEntrySearchError =>
      'Could not search entries. Try again.';

  @override
  String get staffSupervisorSearchEntryRecentValidated => 'Validated';

  @override
  String get staffSupervisorSearchEntryRecentReentry => 'Re-entry authorized';

  @override
  String get staffSupervisorSearchEntryRecentSupervisor => 'Supervisor';

  @override
  String staffSupervisorSearchEntryResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results found',
      one: '1 result found',
    );
    return '$_temp0';
  }

  @override
  String get staffSupervisorDuplicateAlertTitle => 'DUPLICATE ALERT';

  @override
  String get staffSupervisorDuplicateCurrentStatusTitle => 'CURRENT STATUS';

  @override
  String get staffSupervisorDuplicateLastValidTitle => 'Last valid access';

  @override
  String get staffSupervisorDuplicateNewAttemptTitle => 'New attempt detected';

  @override
  String get staffSupervisorDuplicateTimeLabel => 'Time';

  @override
  String get staffSupervisorDuplicateAccessLabel => 'Access';

  @override
  String get staffSupervisorDuplicateDeviceLabel => 'Device';

  @override
  String get staffSupervisorDuplicatePossibleReasonTitle => 'POSSIBLE REASON';

  @override
  String get staffSupervisorDuplicateReasonScreenshot => 'Shared screenshot';

  @override
  String get staffSupervisorDuplicateReasonResold => 'Resold QR';

  @override
  String get staffSupervisorDuplicateReasonValidationError =>
      'Validation error';

  @override
  String get staffSupervisorDuplicateReasonAuthorizedReentry =>
      'Authorized re-entry';

  @override
  String get staffSupervisorDuplicateSupervisorActionsTitle =>
      'SUPERVISOR ACTIONS';

  @override
  String get staffSupervisorDuplicateReleaseReentry => 'RELEASE RE-ENTRY';

  @override
  String get staffSupervisorDuplicateBlockQr => 'BLOCK QR';

  @override
  String get staffSupervisorDuplicateEscalateAlert => 'ESCALATE ALERT';

  @override
  String get staffSupervisorDuplicateReasonPlaceholder => 'Write the reason...';

  @override
  String get staffSupervisorExecuteDuplicateButton => 'RESOLVE DUPLICATE';

  @override
  String get staffSupervisorDuplicateNotFound =>
      'No duplicate attempts found for this entry.';

  @override
  String get staffSupervisorDuplicateResolvedSuccess =>
      'Duplicate resolved successfully.';

  @override
  String get staffSupervisorEntryOverrideSuccess =>
      'Override applied successfully.';

  @override
  String get staffSupervisorDuplicateLogValidated => 'Validated';

  @override
  String get staffSupervisorDuplicateLogReentryRejected => 'Re-entry rejected';

  @override
  String get staffSupervisorDuplicateLogSupervisorPending =>
      'Supervisor pending';

  @override
  String get staffSupervisorDuplicateLogSupervisorResolved =>
      'Supervisor resolved';

  @override
  String get staffSupervisorDuplicateAlreadyResolved =>
      'This duplicate alert has already been resolved.';

  @override
  String get staffSupervisorDuplicateSearchHint =>
      'Search by name, entry code, phone, or purchase ID';

  @override
  String get staffBarMode => 'Bar mode';

  @override
  String get staffNoScanAccessTitle => 'No scan access assigned';

  @override
  String get staffNoScanAccessSubtitle =>
      'Ask an administrator to assign door or bar scan permissions to your staff account.';

  @override
  String get staffSupervisorAccessDenied =>
      'You do not have supervisor access for this area.';

  @override
  String get staffAccessValidatorTitle => 'ACCESS VALIDATOR';

  @override
  String get staffAccessValidatorSubtitle =>
      'Scan the entry QR code to validate event access';

  @override
  String get staffScanEntryButton => 'SCAN ENTRY';

  @override
  String get staffActiveEventPrefix => 'Active event:';

  @override
  String staffActiveEventLabel(String eventName) {
    return 'Active event: $eventName';
  }

  @override
  String get staffRecentAccessTitle => 'Recent access';

  @override
  String get staffRecentAccessEmpty =>
      'No entry scans yet. Scan a ticket QR to see it here.';

  @override
  String get staffViewAllAccess => 'View all >';

  @override
  String get staffAccessDuplicateLabel => 'Duplicate QR';

  @override
  String get staffScanResultValidTitle => 'VALID';

  @override
  String get staffScanResultValidSubtitle =>
      'The QR code was validated successfully.';

  @override
  String get staffScanResultUsedTitle => 'QR USED';

  @override
  String get staffScanResultUsedSubtitle => 'This code was already redeemed.';

  @override
  String get staffScanResultProductLabel => 'Product';

  @override
  String get staffScanResultUserLabel => 'User';

  @override
  String get staffScanResultTimeLabel => 'Time';

  @override
  String get staffScanResultAttemptTimeLabel => 'Attempt time';

  @override
  String get staffScanResultBarLabel => 'Bar';

  @override
  String get staffScanResultTransactionIdLabel => 'Transaction ID';

  @override
  String get staffScanResultRememberTitle => 'Remember';

  @override
  String get staffScanResultRememberMessage =>
      'Press the button to confirm product delivery.';

  @override
  String get staffScanResultLastSuccessfulUse => 'Last successful use';

  @override
  String get staffScanResultDeliverButton => 'DELIVER PRODUCT';

  @override
  String get staffScanResultConfirmAccessButton => 'CONFIRM ACCESS';

  @override
  String get staffScanResultEntryRememberMessage =>
      'Press the button to confirm event access.';

  @override
  String get staffScanResultTicketLabel => 'Ticket';

  @override
  String get staffScanResultBackButton => 'BACK';

  @override
  String get staffEntryValidTitle => 'VALID';

  @override
  String get staffEntryValidSubtitle => 'Valid unique QR';

  @override
  String get staffEntryValidEventLabel => 'Event';

  @override
  String get staffEntryValidEntryIdLabel => 'Entry ID';

  @override
  String get staffEntryValidTicketTypeLabel => 'Ticket type';

  @override
  String get staffEntryValidAccessLabel => 'Authorized access';

  @override
  String get staffEntryValidTimeLabel => 'Validation time';

  @override
  String get staffEntryValidAllowButton => 'ALLOW ENTRY';

  @override
  String get staffEntryInvalidTitle => 'INVALID';

  @override
  String get staffEntryInvalidSubtitle => 'QR already used';

  @override
  String get staffEntryInvalidReasonLabel => 'Reason';

  @override
  String get staffEntryInvalidReasonTitle => 'QR already used';

  @override
  String get staffEntryInvalidReasonMessage =>
      'This code was already scanned previously';

  @override
  String get staffEntryInvalidLastAccessLabel => 'Last access';

  @override
  String staffEntryInvalidLastAccessDate(String date) {
    return 'Today, $date';
  }

  @override
  String get staffEntryInvalidUserLabel => 'User';

  @override
  String get staffEntryInvalidWarning =>
      'This QR cannot be used. If you think this is an error, contact the supervisor.';

  @override
  String get staffEntryInvalidResolveDuplicateButton => 'RESOLVE DUPLICATE';

  @override
  String get staffScanErrorQrNotFound => 'QR code not recognised.';

  @override
  String get staffScanErrorQrInvalid =>
      'This QR code is not valid for scanning.';

  @override
  String get staffScanErrorPermissionDenied =>
      'You do not have permission to perform this scan.';

  @override
  String get staffScanErrorSessionExpired =>
      'Your session expired. Please sign in again.';

  @override
  String staffScanResultUnitCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count units',
      one: '1 unit',
    );
    return '$_temp0';
  }
}
