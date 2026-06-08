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
  String get selectCountryTitle => 'Select your country';

  @override
  String get searchCountryHint => 'Search country or code';

  @override
  String get searchCountryEmpty => 'No countries found';

  @override
  String get homeTitle => 'Home';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name!';
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
  String get favoritesEventsSubtitle => 'Events you saved with the heart icon';

  @override
  String get favoritesEventsSearchHint => 'Search favorite event';

  @override
  String get favoritesEventsEmpty =>
      'No favorite events yet. Tap the heart on an event to save it here.';

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
  String get errorInvalidCode => 'Invalid code. Request a new one.';

  @override
  String get errorIncorrectCode => 'Incorrect code';

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
  String get createAccountButton => 'CREATE ACCOUNT';

  @override
  String get alreadyHaveAccountQuestion => 'ALREADY HAVE AN ACCOUNT?';

  @override
  String get signInLink => 'SIGN IN';

  @override
  String get drawerMyProfile => 'My Profile';

  @override
  String get drawerMyTickets => 'My Tickets';

  @override
  String get drawerMyFavorites => 'My Favorites';

  @override
  String get drawerInvitations => 'INVITATIONS';

  @override
  String drawerInvitationsNewBadge(int count) {
    return '$count new';
  }

  @override
  String get drawerTierGold => 'GOLD';

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
  String get profileViewFullWallet => 'View full wallet';

  @override
  String get profileNotifications => 'NOTIFICATIONS';

  @override
  String get profileReceiveNotifications => 'Receive notifications';

  @override
  String get profileNotificationChannels => 'Email · Push · WhatsApp';

  @override
  String get profileSupport => 'SUPPORT';

  @override
  String get profileWhatsAppSupport => 'WhatsApp support';

  @override
  String get profileWriteEmail => 'Send email';

  @override
  String get profileFaq => 'Frequently asked questions';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profilePhotoUpdated => 'Profile photo updated';

  @override
  String get confirmDialogCancel => 'Cancel';

  @override
  String get confirmLogoutTitle => 'Log out?';

  @override
  String get confirmLogoutMessage =>
      'You will need to sign in again with your phone number to use YouPass.';

  @override
  String get confirmLogoutAction => 'Log out';

  @override
  String get confirmDeleteAccountTitle => 'Delete your account?';

  @override
  String get confirmDeleteAccountMessage =>
      'This permanently removes your account, tickets, and profile data. We will send a verification code to confirm.';

  @override
  String get confirmDeleteAccountAction => 'Continue';

  @override
  String get ticketsTabUpcoming => 'UPCOMING';

  @override
  String get ticketsTabPast => 'PAST EVENTS';

  @override
  String get ticketsStatusActive => 'ACTIVE';

  @override
  String get ticketsViewQr => 'VIEW QR';

  @override
  String get ticketsAssignEntries => 'ASSIGN TICKETS';

  @override
  String get ticketsAssignVip => 'ASSIGN VIP TICKETS';

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
    return '$count saved producers';
  }

  @override
  String get favoritesYoufestDescription =>
      'The best festivals and live experiences.';

  @override
  String get favoritesIguanaDescription =>
      'Electronic music, parties and unique experiences.';

  @override
  String get producerEventsUpcomingTitle => 'UPCOMING EVENTS';

  @override
  String producerEventsUpcomingSubtitle(String producerName) {
    return 'Discover upcoming events from $producerName';
  }

  @override
  String get producerEventsSearchHint => 'Search event';

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
  String get invitationsSubtitle => 'Manage your event access and invitations';

  @override
  String get invitationsSearchHint => 'Search invitations / Events / promoters';

  @override
  String get invitationsFilterAll => 'All';

  @override
  String get invitationsFilterGeneral => 'General';

  @override
  String get invitationsFilterVip => 'VIP';

  @override
  String get invitationsTierVip => 'VIP';

  @override
  String get invitationsTierVipMesa => 'VIP Table';

  @override
  String get invitationsTierGeneral => 'General';

  @override
  String invitationsStatusLine(String status) {
    return 'Status: $status';
  }

  @override
  String get invitationsStatusPrefix => 'Status:';

  @override
  String get invitationsStatusPending => 'Awaiting confirmation';

  @override
  String get invitationsStatusConfirmed => 'Confirmed';

  @override
  String get invitationsStatusRejected => 'Declined';

  @override
  String get invitationsConfirmAttendance => 'CONFIRM ATTENDANCE';

  @override
  String get invitationsReject => 'DECLINE';

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
      'Confirmed invitations generate a unique, non-transferable QR code.';

  @override
  String get invitationsImportantTitle => 'Important';

  @override
  String get invitationsImportantMessage =>
      'By confirming, the ticket is reserved exclusively for you. If you do not attend, you may be charged the full ticket price.';

  @override
  String get invitationsAddPaymentMethod => 'ADD PAYMENT METHOD';

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
  String get invitationsPaymentSecureNote => 'for secure use';

  @override
  String get invitationsSaveCard => 'SAVE CARD';

  @override
  String get invitationsCardSavedTitle => 'Card saved successfully!';

  @override
  String get invitationsCardSavedMessage =>
      'Your card has been registered. Remember:';

  @override
  String get invitationsCardSavedReminderCharge =>
      'If you do not attend the event, you may be charged the full ticket price.';

  @override
  String get invitationsCardSavedReminderCancel =>
      'Cancellations must be made at least 48 hours in advance to avoid charges.';

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
  String get ticketAssignmentSendTicket => 'Send ticket';

  @override
  String get ticketAssignmentCancelTicket => 'Cancel ticket';

  @override
  String get ticketAssignmentResendWhatsApp => 'Resend WhatsApp';

  @override
  String get ticketAssignmentSentSuccess => 'Invitation sent via WhatsApp';

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
      'A link with instructions to download and register in YouPass will be sent via WhatsApp once you send them the ticket.';

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
  String get vipSectionGeneralTickets => 'GENERAL ADMISSION';

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
  String vipContinueWithTickets(String ticketCount) {
    return 'Continue - $ticketCount';
  }

  @override
  String get vipSecurePayment => '100% secure payment';

  @override
  String get vipOfferingGeneral => 'GENERAL - STANDARD';

  @override
  String get vipMesasVipTitle => 'VIP Tables';

  @override
  String get vipMesasVipSubtitle =>
      'Reserve your table and live the full experience.';

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
  String get vipLegendAvailableShort => 'Avail.';

  @override
  String get vipDanceFloorGeneral => 'General';

  @override
  String vipTableDistributionTitle(String zone) {
    return 'ZONE $zone DISTRIBUTION';
  }

  @override
  String get vipTableDistributionStage => 'DJ Stage';

  @override
  String get vipLegendTableAvailable => 'Available';

  @override
  String get vipLegendTableSelection => 'Selected';

  @override
  String get vipLegendTableSold => 'Sold';

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
    return 'Table $table - $zone';
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
      'Your payment has been processed correctly.';

  @override
  String vipTableLockCountdown(String time) {
    return 'Complete payment in $time';
  }

  @override
  String get vipTableLockExpired =>
      'Your table reservation expired. Please select a table again.';

  @override
  String get eventDetailTicketsUnavailable =>
      'Tickets are not available for this event yet.';

  @override
  String get vipViewQr => 'View QR';
}
