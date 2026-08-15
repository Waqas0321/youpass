import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @welcomeBackTitle.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK'**
  String get welcomeBackTitle;

  /// No description provided for @phoneLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your number and receive your code via WhatsApp'**
  String get phoneLoginSubtitle;

  /// No description provided for @codeSentWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Code sent to your WhatsApp'**
  String get codeSentWhatsApp;

  /// No description provided for @codeSentSms.
  ///
  /// In en, this message translates to:
  /// **'Code sent via SMS'**
  String get codeSentSms;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'PHONE NUMBER'**
  String get phoneNumberLabel;

  /// No description provided for @sendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'SEND CODE'**
  String get sendCodeButton;

  /// No description provided for @createAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountLink;

  /// No description provided for @verificationCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'VERIFICATION CODE'**
  String get verificationCodeTitle;

  /// No description provided for @verificationCodeSentPrefix.
  ///
  /// In en, this message translates to:
  /// **'We sent a code to '**
  String get verificationCodeSentPrefix;

  /// No description provided for @verificationCodeSentViaSms.
  ///
  /// In en, this message translates to:
  /// **' via SMS '**
  String get verificationCodeSentViaSms;

  /// No description provided for @verificationCodeSentViaWhatsApp.
  ///
  /// In en, this message translates to:
  /// **' via WhatsApp '**
  String get verificationCodeSentViaWhatsApp;

  /// No description provided for @validateCodeButton.
  ///
  /// In en, this message translates to:
  /// **'VALIDATE CODE'**
  String get validateCodeButton;

  /// No description provided for @resendCodePrefix.
  ///
  /// In en, this message translates to:
  /// **'Resend code in '**
  String get resendCodePrefix;

  /// No description provided for @resendCodeAction.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCodeAction;

  /// No description provided for @incorrectNumberQuestion.
  ///
  /// In en, this message translates to:
  /// **'INCORRECT NUMBER?'**
  String get incorrectNumberQuestion;

  /// No description provided for @changeNumberLink.
  ///
  /// In en, this message translates to:
  /// **'CHANGE NUMBER'**
  String get changeNumberLink;

  /// No description provided for @otpWhatsAppHelp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the code? Make sure WhatsApp is installed on your phone. YouPass uses WhatsApp to send security codes. If you have problems, contact support: soporte@youpass.app'**
  String get otpWhatsAppHelp;

  /// No description provided for @selectCountryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select your country'**
  String get selectCountryTitle;

  /// No description provided for @searchCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Search country or code'**
  String get searchCountryHint;

  /// No description provided for @searchCountryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No countries found'**
  String get searchCountryEmpty;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}!'**
  String homeGreeting(String name);

  /// No description provided for @homeDiscoverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the best events for you'**
  String get homeDiscoverSubtitle;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryChile.
  ///
  /// In en, this message translates to:
  /// **'Chile'**
  String get categoryChile;

  /// No description provided for @categoryParties.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get categoryParties;

  /// No description provided for @categoryConcerts.
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get categoryConcerts;

  /// No description provided for @categorySports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get categorySports;

  /// No description provided for @featuredEventTitle.
  ///
  /// In en, this message translates to:
  /// **'FESTIVAL PRIMAVERA — 2026 —'**
  String get featuredEventTitle;

  /// No description provided for @featuredEventDate.
  ///
  /// In en, this message translates to:
  /// **'NOVEMBER 21, 2026 • 5:00 PM'**
  String get featuredEventDate;

  /// No description provided for @featuredEventLocation.
  ///
  /// In en, this message translates to:
  /// **'BICENTENNIAL PARK, SANTIAGO'**
  String get featuredEventLocation;

  /// No description provided for @eventsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured events'**
  String get eventsSectionTitle;

  /// No description provided for @homeNoEventsFound.
  ///
  /// In en, this message translates to:
  /// **'No events found for this filter'**
  String get homeNoEventsFound;

  /// No description provided for @homeEventsEndOfList.
  ///
  /// In en, this message translates to:
  /// **'You\'ve seen all available events.'**
  String get homeEventsEndOfList;

  /// No description provided for @homeNearMeButton.
  ///
  /// In en, this message translates to:
  /// **'See events near my location'**
  String get homeNearMeButton;

  /// No description provided for @homeNearMeHeaderLink.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get homeNearMeHeaderLink;

  /// No description provided for @homeEventDistanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String homeEventDistanceKm(String distance);

  /// No description provided for @homeEventTravelMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String homeEventTravelMinutes(int minutes);

  /// No description provided for @homeNearMePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to show nearby events.'**
  String get homeNearMePermissionDenied;

  /// No description provided for @homeNearMeLocationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services to find events near you.'**
  String get homeNearMeLocationDisabled;

  /// No description provided for @homeLocationSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose location'**
  String get homeLocationSheetTitle;

  /// No description provided for @homeLocationSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your current location or type a city to update events.'**
  String get homeLocationSheetSubtitle;

  /// No description provided for @homeLocationUseCurrent.
  ///
  /// In en, this message translates to:
  /// **'Use my current location'**
  String get homeLocationUseCurrent;

  /// No description provided for @homeLocationTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Type a city or venue area'**
  String get homeLocationTypeHint;

  /// No description provided for @homeLocationApply.
  ///
  /// In en, this message translates to:
  /// **'Apply location'**
  String get homeLocationApply;

  /// No description provided for @homeLocationClear.
  ///
  /// In en, this message translates to:
  /// **'Clear location'**
  String get homeLocationClear;

  /// No description provided for @homeLocationActiveNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get homeLocationActiveNearby;

  /// No description provided for @homeSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search events by name'**
  String get homeSearchPlaceholder;

  /// No description provided for @homeSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any events with that term.'**
  String get homeSearchEmpty;

  /// No description provided for @homeSearchRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get homeSearchRecentTitle;

  /// No description provided for @homeSearchClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get homeSearchClearHistory;

  /// No description provided for @homeSearchSuggestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get homeSearchSuggestionsTitle;

  /// No description provided for @homeFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get homeFiltersTitle;

  /// No description provided for @homeFiltersDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get homeFiltersDate;

  /// No description provided for @homeFiltersPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get homeFiltersPrice;

  /// No description provided for @homeFiltersCityZone.
  ///
  /// In en, this message translates to:
  /// **'City / Zone'**
  String get homeFiltersCityZone;

  /// No description provided for @homeFiltersVenueType.
  ///
  /// In en, this message translates to:
  /// **'Venue type'**
  String get homeFiltersVenueType;

  /// No description provided for @homeFiltersFreeOnly.
  ///
  /// In en, this message translates to:
  /// **'Free events only'**
  String get homeFiltersFreeOnly;

  /// No description provided for @homeFiltersCityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get homeFiltersCityLabel;

  /// No description provided for @homeFiltersZoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Neighbourhood'**
  String get homeFiltersZoneLabel;

  /// No description provided for @homeFiltersClear.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get homeFiltersClear;

  /// No description provided for @homeFiltersApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get homeFiltersApply;

  /// No description provided for @homeFiltersApplyCount.
  ///
  /// In en, this message translates to:
  /// **'Apply ({count})'**
  String homeFiltersApplyCount(int count);

  /// No description provided for @homeFiltersCustomRange.
  ///
  /// In en, this message translates to:
  /// **'Custom range'**
  String get homeFiltersCustomRange;

  /// No description provided for @homeFiltersDateFrom.
  ///
  /// In en, this message translates to:
  /// **'From {date}'**
  String homeFiltersDateFrom(String date);

  /// No description provided for @homeFiltersDateUntil.
  ///
  /// In en, this message translates to:
  /// **'Until {date}'**
  String homeFiltersDateUntil(String date);

  /// No description provided for @homeFiltersDateRange.
  ///
  /// In en, this message translates to:
  /// **'{from} – {to}'**
  String homeFiltersDateRange(String from, String to);

  /// No description provided for @homeFiltersAllCities.
  ///
  /// In en, this message translates to:
  /// **'All cities'**
  String get homeFiltersAllCities;

  /// No description provided for @allEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'All events'**
  String get allEventsTitle;

  /// No description provided for @allEventsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse every published event on YouPass'**
  String get allEventsSubtitle;

  /// No description provided for @allEventsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search event'**
  String get allEventsSearchHint;

  /// No description provided for @allEventsAvailableCount.
  ///
  /// In en, this message translates to:
  /// **'{count} events available'**
  String allEventsAvailableCount(int count);

  /// No description provided for @favoritesEventsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your favorite producers appear here'**
  String get favoritesEventsSubtitle;

  /// No description provided for @favoritesEventsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search producer'**
  String get favoritesEventsSearchHint;

  /// No description provided for @favoritesEventsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No followed promoters yet. Follow a promoter from an event to see them here.'**
  String get favoritesEventsEmpty;

  /// No description provided for @favoritesSavedEventsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} saved events'**
  String favoritesSavedEventsCount(int count);

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @buyTickets.
  ///
  /// In en, this message translates to:
  /// **'BUY TICKETS'**
  String get buyTickets;

  /// No description provided for @eventDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Event details'**
  String get eventDetailTitle;

  /// No description provided for @eventDetailAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About this event'**
  String get eventDetailAboutSection;

  /// No description provided for @eventDetailAboutHeading.
  ///
  /// In en, this message translates to:
  /// **'ABOUT THE EVENT'**
  String get eventDetailAboutHeading;

  /// No description provided for @eventDetailReadMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get eventDetailReadMore;

  /// No description provided for @eventDetailReadLess.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get eventDetailReadLess;

  /// No description provided for @eventDetailBuyTicketsLabel.
  ///
  /// In en, this message translates to:
  /// **'Buy tickets'**
  String get eventDetailBuyTicketsLabel;

  /// No description provided for @eventDetailSoldOut.
  ///
  /// In en, this message translates to:
  /// **'Sold Out'**
  String get eventDetailSoldOut;

  /// No description provided for @eventDetailPromoterLabel.
  ///
  /// In en, this message translates to:
  /// **'Promoter'**
  String get eventDetailPromoterLabel;

  /// No description provided for @eventDetailFollowPromoter.
  ///
  /// In en, this message translates to:
  /// **'You are now following {name}'**
  String eventDetailFollowPromoter(String name);

  /// No description provided for @eventDetailUnfollowPromoter.
  ///
  /// In en, this message translates to:
  /// **'You unfollowed {name}'**
  String eventDetailUnfollowPromoter(String name);

  /// No description provided for @eventCaribeDate.
  ///
  /// In en, this message translates to:
  /// **'Saturday, January 31, 2026'**
  String get eventCaribeDate;

  /// No description provided for @eventCaribeLocation.
  ///
  /// In en, this message translates to:
  /// **'Club Océano, Viña del Mar'**
  String get eventCaribeLocation;

  /// No description provided for @eventRockDate.
  ///
  /// In en, this message translates to:
  /// **'Sunday, February 15, 2026'**
  String get eventRockDate;

  /// No description provided for @eventRockLocation.
  ///
  /// In en, this message translates to:
  /// **'Simón Bolívar Park, Bogotá'**
  String get eventRockLocation;

  /// No description provided for @defaultGuestName.
  ///
  /// In en, this message translates to:
  /// **'Christian'**
  String get defaultGuestName;

  /// No description provided for @brandBadgeOff.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get brandBadgeOff;

  /// No description provided for @brandBadgeOn.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get brandBadgeOn;

  /// No description provided for @brandModeProduction.
  ///
  /// In en, this message translates to:
  /// **'PRODUCTION'**
  String get brandModeProduction;

  /// No description provided for @brandModeFiesta.
  ///
  /// In en, this message translates to:
  /// **'PARTY MODE'**
  String get brandModeFiesta;

  /// No description provided for @featuredEventSummerTitle.
  ///
  /// In en, this message translates to:
  /// **'SUMMER BEATS 2026'**
  String get featuredEventSummerTitle;

  /// No description provided for @featuredEventUrbanTitle.
  ///
  /// In en, this message translates to:
  /// **'URBAN NIGHT LIVE'**
  String get featuredEventUrbanTitle;

  /// No description provided for @eventCaribeTitle.
  ///
  /// In en, this message translates to:
  /// **'Caribe Night'**
  String get eventCaribeTitle;

  /// No description provided for @eventRockTitle.
  ///
  /// In en, this message translates to:
  /// **'Rock al Parque'**
  String get eventRockTitle;

  /// No description provided for @helloUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String helloUser(String name);

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @phoneInvalidLength.
  ///
  /// In en, this message translates to:
  /// **'Enter a 9-digit number'**
  String get phoneInvalidLength;

  /// No description provided for @phoneMustStartWithNine.
  ///
  /// In en, this message translates to:
  /// **'Number must start with 9'**
  String get phoneMustStartWithNine;

  /// No description provided for @phoneInvalidGeneric.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get phoneInvalidGeneric;

  /// No description provided for @otpRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get otpRequired;

  /// No description provided for @otpInvalidLength.
  ///
  /// In en, this message translates to:
  /// **'The code must be 6 digits'**
  String get otpInvalidLength;

  /// No description provided for @registerFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get registerFullNameRequired;

  /// No description provided for @registerIdDocumentRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your ID or passport'**
  String get registerIdDocumentRequired;

  /// No description provided for @registerBirthDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get registerBirthDateRequired;

  /// No description provided for @registerGenderRequired.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get registerGenderRequired;

  /// No description provided for @registerEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get registerEmailRequired;

  /// No description provided for @registerTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms and conditions'**
  String get registerTermsRequired;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get errorInvalidPhone;

  /// No description provided for @errorUnsupportedCountry.
  ///
  /// In en, this message translates to:
  /// **'This country is not supported'**
  String get errorUnsupportedCountry;

  /// No description provided for @errorOtpDeliveryFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not send the code. Try again later.'**
  String get errorOtpDeliveryFailed;

  /// No description provided for @errorWhatsAppRequired.
  ///
  /// In en, this message translates to:
  /// **'This number cannot receive WhatsApp. YouPass uses WhatsApp Business only for verification.'**
  String get errorWhatsAppRequired;

  /// No description provided for @otpCodeExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Code expires in {seconds}s'**
  String otpCodeExpiresIn(int seconds);

  /// No description provided for @phoneChangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Phone number updated successfully.'**
  String get phoneChangeSuccess;

  /// No description provided for @errorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code. Request a new one.'**
  String get errorInvalidCode;

  /// No description provided for @errorIncorrectCode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code'**
  String get errorIncorrectCode;

  /// No description provided for @errorIncorrectCodeRemaining.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code. {attempts} attempt(s) remaining.'**
  String errorIncorrectCodeRemaining(int attempts);

  /// No description provided for @errorBlockedCountdown.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Try again in {seconds} seconds.'**
  String errorBlockedCountdown(int seconds);

  /// No description provided for @errorMaxResendsCountdown.
  ///
  /// In en, this message translates to:
  /// **'Too many resend attempts. Try again in {seconds} seconds.'**
  String errorMaxResendsCountdown(int seconds);

  /// No description provided for @errorRecaptchaFailed.
  ///
  /// In en, this message translates to:
  /// **'Security verification failed. Please try again.'**
  String get errorRecaptchaFailed;

  /// No description provided for @errorCardTokenizationRequired.
  ///
  /// In en, this message translates to:
  /// **'Card details must be tokenized. Please use the secure payment form.'**
  String get errorCardTokenizationRequired;

  /// No description provided for @changePhoneOtpMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to your NEW WhatsApp number {phone}.'**
  String changePhoneOtpMessage(String phone);

  /// No description provided for @errorCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'The code expired. Request a new one.'**
  String get errorCodeExpired;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found for this number'**
  String get errorUserNotFound;

  /// No description provided for @errorUserExists.
  ///
  /// In en, this message translates to:
  /// **'This number is already registered'**
  String get errorUserExists;

  /// No description provided for @errorResendCooldown.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds} seconds'**
  String errorResendCooldown(int seconds);

  /// No description provided for @errorMaxResends.
  ///
  /// In en, this message translates to:
  /// **'Too many resend attempts. Try again later.'**
  String get errorMaxResends;

  /// No description provided for @errorBlocked.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Try again later.'**
  String get errorBlocked;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Please check the information entered'**
  String get errorValidation;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Route not found'**
  String get routeNotFound;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get backButton;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get createAccountTitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete the following details to create your account'**
  String get createAccountSubtitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @idDocumentLabel.
  ///
  /// In en, this message translates to:
  /// **'ID OR PASSPORT'**
  String get idDocumentLabel;

  /// No description provided for @idDocumentHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your ID or passport'**
  String get idDocumentHint;

  /// No description provided for @birthDateLabel.
  ///
  /// In en, this message translates to:
  /// **'DATE OF BIRTH'**
  String get birthDateLabel;

  /// No description provided for @birthDateHint.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get birthDateHint;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'GENDER'**
  String get genderLabel;

  /// No description provided for @genderHint.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get genderHint;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @genderPreferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get genderPreferNotToSay;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'EMAIL'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'example@email.com'**
  String get emailHint;

  /// No description provided for @instagramLabel.
  ///
  /// In en, this message translates to:
  /// **'INSTAGRAM USERNAME'**
  String get instagramLabel;

  /// No description provided for @instagramHint.
  ///
  /// In en, this message translates to:
  /// **'@instagramuser'**
  String get instagramHint;

  /// No description provided for @termsPrefix.
  ///
  /// In en, this message translates to:
  /// **'I accept the '**
  String get termsPrefix;

  /// No description provided for @termsLink.
  ///
  /// In en, this message translates to:
  /// **'terms and conditions'**
  String get termsLink;

  /// No description provided for @termsAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get termsAnd;

  /// No description provided for @privacyLink.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacyLink;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get createAccountButton;

  /// No description provided for @alreadyHaveAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'ALREADY HAVE AN ACCOUNT?'**
  String get alreadyHaveAccountQuestion;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signInLink;

  /// No description provided for @drawerMyProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get drawerMyProfile;

  /// No description provided for @drawerHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get drawerHome;

  /// No description provided for @drawerMyTickets.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get drawerMyTickets;

  /// No description provided for @drawerMyFavorites.
  ///
  /// In en, this message translates to:
  /// **'My Favourites'**
  String get drawerMyFavorites;

  /// No description provided for @drawerInvitations.
  ///
  /// In en, this message translates to:
  /// **'INVITATIONS'**
  String get drawerInvitations;

  /// No description provided for @drawerDrinkMenu.
  ///
  /// In en, this message translates to:
  /// **'Drink Menu'**
  String get drawerDrinkMenu;

  /// No description provided for @drawerMyPurchases.
  ///
  /// In en, this message translates to:
  /// **'My Purchases'**
  String get drawerMyPurchases;

  /// No description provided for @partyModeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Party Mode opens when you have a scanned ticket at a live event.'**
  String get partyModeUnavailable;

  /// No description provided for @partyDrinkMenuEmpty.
  ///
  /// In en, this message translates to:
  /// **'The drink menu for this event will appear here soon.'**
  String get partyDrinkMenuEmpty;

  /// No description provided for @partyDrinkMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a category to explore'**
  String get partyDrinkMenuSubtitle;

  /// No description provided for @partyDrinkEventChooserTitle.
  ///
  /// In en, this message translates to:
  /// **'Which drink menu?'**
  String get partyDrinkEventChooserTitle;

  /// No description provided for @partyDrinkEventChooserSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have tickets for more than one event. Choose which menu to open.'**
  String get partyDrinkEventChooserSubtitle;

  /// No description provided for @partyDrinkEventChooserRecommended.
  ///
  /// In en, this message translates to:
  /// **'Suggested now'**
  String get partyDrinkEventChooserRecommended;

  /// No description provided for @partyDrinkCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get partyDrinkCategoryAll;

  /// No description provided for @partyDrinkCategoryPiscos.
  ///
  /// In en, this message translates to:
  /// **'Piscos'**
  String get partyDrinkCategoryPiscos;

  /// No description provided for @partyDrinkCategoryBeers.
  ///
  /// In en, this message translates to:
  /// **'Beers'**
  String get partyDrinkCategoryBeers;

  /// No description provided for @partyDrinkCategorySparkling.
  ///
  /// In en, this message translates to:
  /// **'Sparkling wines'**
  String get partyDrinkCategorySparkling;

  /// No description provided for @partyDrinkCategoryEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy drinks'**
  String get partyDrinkCategoryEnergy;

  /// No description provided for @partyDrinkQuickRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Quick recommendations'**
  String get partyDrinkQuickRecommendations;

  /// No description provided for @partyDrinkQuickRecommendationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Most ordered at YouFest'**
  String get partyDrinkQuickRecommendationsSubtitle;

  /// No description provided for @partyDrinkMockPiscola.
  ///
  /// In en, this message translates to:
  /// **'Piscola'**
  String get partyDrinkMockPiscola;

  /// No description provided for @partyDrinkMockPiscolaDesc.
  ///
  /// In en, this message translates to:
  /// **'Pisco + cola drink'**
  String get partyDrinkMockPiscolaDesc;

  /// No description provided for @partyDrinkMockJagerBomb.
  ///
  /// In en, this message translates to:
  /// **'Jager Bomb'**
  String get partyDrinkMockJagerBomb;

  /// No description provided for @partyDrinkMockJagerBombDesc.
  ///
  /// In en, this message translates to:
  /// **'Jägermeister + Red Bull'**
  String get partyDrinkMockJagerBombDesc;

  /// No description provided for @partyDrinkMockTropicalGin.
  ///
  /// In en, this message translates to:
  /// **'Tropical Gin'**
  String get partyDrinkMockTropicalGin;

  /// No description provided for @partyDrinkMockTropicalGinDesc.
  ///
  /// In en, this message translates to:
  /// **'Gin + tonic + fruits'**
  String get partyDrinkMockTropicalGinDesc;

  /// No description provided for @partyDrinkMockCubaLibre.
  ///
  /// In en, this message translates to:
  /// **'Cuba Libre'**
  String get partyDrinkMockCubaLibre;

  /// No description provided for @partyDrinkMockCubaLibreDesc.
  ///
  /// In en, this message translates to:
  /// **'Rum + cola + lime'**
  String get partyDrinkMockCubaLibreDesc;

  /// No description provided for @partyDrinkMockCorona.
  ///
  /// In en, this message translates to:
  /// **'Corona'**
  String get partyDrinkMockCorona;

  /// No description provided for @partyDrinkMockCoronaDesc.
  ///
  /// In en, this message translates to:
  /// **'Mexican lager beer'**
  String get partyDrinkMockCoronaDesc;

  /// No description provided for @partyDrinkMockChandon.
  ///
  /// In en, this message translates to:
  /// **'Chandon'**
  String get partyDrinkMockChandon;

  /// No description provided for @partyDrinkMockChandonDesc.
  ///
  /// In en, this message translates to:
  /// **'Sparkling wine bottle'**
  String get partyDrinkMockChandonDesc;

  /// No description provided for @partyDrinkVolumeMl.
  ///
  /// In en, this message translates to:
  /// **'{volume} ml'**
  String partyDrinkVolumeMl(int volume);

  /// No description provided for @partyDrinkCheckoutPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get partyDrinkCheckoutPaymentMethod;

  /// No description provided for @partyDrinkCheckoutCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get partyDrinkCheckoutCreditCard;

  /// No description provided for @partyDrinkCheckoutCardMask.
  ///
  /// In en, this message translates to:
  /// **'**** {last4}'**
  String partyDrinkCheckoutCardMask(String last4);

  /// No description provided for @partyDrinkCheckoutProducts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 product} other{{count} products}}'**
  String partyDrinkCheckoutProducts(int count);

  /// No description provided for @partyDrinkCheckoutBuy.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get partyDrinkCheckoutBuy;

  /// No description provided for @partyDrinkCheckoutSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase summary'**
  String get partyDrinkCheckoutSummaryTitle;

  /// No description provided for @partyDrinkCheckoutSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your products before continuing.'**
  String get partyDrinkCheckoutSummarySubtitle;

  /// No description provided for @partyDrinkCheckoutSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get partyDrinkCheckoutSubtotal;

  /// No description provided for @partyDrinkCheckoutServiceCharge.
  ///
  /// In en, this message translates to:
  /// **'Service charge'**
  String get partyDrinkCheckoutServiceCharge;

  /// No description provided for @partyDrinkCheckoutTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get partyDrinkCheckoutTotal;

  /// No description provided for @partyDrinkCheckoutChangePayment.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get partyDrinkCheckoutChangePayment;

  /// No description provided for @partyDrinkCheckoutCompletePurchase.
  ///
  /// In en, this message translates to:
  /// **'Complete purchase'**
  String get partyDrinkCheckoutCompletePurchase;

  /// No description provided for @partyDrinkCheckoutSecurePayment.
  ///
  /// In en, this message translates to:
  /// **'100% secure payment'**
  String get partyDrinkCheckoutSecurePayment;

  /// No description provided for @partyDrinkPurchaseSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase complete!'**
  String get partyDrinkPurchaseSuccessTitle;

  /// No description provided for @partyDrinkPurchaseSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show this code at the bar to receive your drink.'**
  String get partyDrinkPurchaseSuccessSubtitle;

  /// No description provided for @partyDrinkPurchaseValidity.
  ///
  /// In en, this message translates to:
  /// **'This code is valid for {target}.'**
  String partyDrinkPurchaseValidity(String target);

  /// No description provided for @partyDrinkPurchaseShowBartender.
  ///
  /// In en, this message translates to:
  /// **'Show it to the bartender to receive your order.'**
  String get partyDrinkPurchaseShowBartender;

  /// No description provided for @partyDrinkPurchasesTitle.
  ///
  /// In en, this message translates to:
  /// **'MY PURCHASES'**
  String get partyDrinkPurchasesTitle;

  /// No description provided for @partyDrinkPurchasesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review and redeem your orders inside the event.'**
  String get partyDrinkPurchasesSubtitle;

  /// No description provided for @partyDrinkPurchasesTabPending.
  ///
  /// In en, this message translates to:
  /// **'To redeem'**
  String get partyDrinkPurchasesTabPending;

  /// No description provided for @partyDrinkPurchasesTabUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get partyDrinkPurchasesTabUsed;

  /// No description provided for @partyDrinkPurchasesOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Order {id}'**
  String partyDrinkPurchasesOrderLabel(String id);

  /// No description provided for @partyDrinkPurchasesQuantityLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} x {name}'**
  String partyDrinkPurchasesQuantityLabel(int count, String name);

  /// No description provided for @partyDrinkPurchasesBoughtAgo.
  ///
  /// In en, this message translates to:
  /// **'Purchased {timeAgo}'**
  String partyDrinkPurchasesBoughtAgo(String timeAgo);

  /// No description provided for @partyDrinkPurchasesRedeemedAgo.
  ///
  /// In en, this message translates to:
  /// **'Redeemed {timeAgo}'**
  String partyDrinkPurchasesRedeemedAgo(String timeAgo);

  /// No description provided for @partyDrinkPurchasesViewQr.
  ///
  /// In en, this message translates to:
  /// **'VIEW QR'**
  String get partyDrinkPurchasesViewQr;

  /// No description provided for @partyDrinkPurchasesRedeemedBadge.
  ///
  /// In en, this message translates to:
  /// **'REDEEMED'**
  String get partyDrinkPurchasesRedeemedBadge;

  /// No description provided for @partyDrinkPurchasesEmptyPending.
  ///
  /// In en, this message translates to:
  /// **'You have no drinks waiting to be redeemed.'**
  String get partyDrinkPurchasesEmptyPending;

  /// No description provided for @partyDrinkPurchasesEmptyUsed.
  ///
  /// In en, this message translates to:
  /// **'You have no redeemed drink orders yet.'**
  String get partyDrinkPurchasesEmptyUsed;

  /// No description provided for @partyDrinkPurchasesQrUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This order QR is no longer available.'**
  String get partyDrinkPurchasesQrUnavailable;

  /// No description provided for @partyDrinkPurchasesJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get partyDrinkPurchasesJustNow;

  /// No description provided for @partyDrinkPurchasesMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String partyDrinkPurchasesMinutesAgo(int count);

  /// No description provided for @partyDrinkPurchasesHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} h'**
  String partyDrinkPurchasesHoursAgo(int count);

  /// No description provided for @partyDrinkPurchasesDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} d'**
  String partyDrinkPurchasesDaysAgo(int count);

  /// No description provided for @partyDrinkCourtesiesTitle.
  ///
  /// In en, this message translates to:
  /// **'MY COURTESIES'**
  String get partyDrinkCourtesiesTitle;

  /// No description provided for @partyDrinkCourtesiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review and redeem your complimentary drinks inside the event.'**
  String get partyDrinkCourtesiesSubtitle;

  /// No description provided for @partyDrinkCourtesiesReceivedAgo.
  ///
  /// In en, this message translates to:
  /// **'Received {timeAgo}'**
  String partyDrinkCourtesiesReceivedAgo(String timeAgo);

  /// No description provided for @partyDrinkCourtesiesEmptyPending.
  ///
  /// In en, this message translates to:
  /// **'You have no complimentary drinks waiting to be redeemed.'**
  String get partyDrinkCourtesiesEmptyPending;

  /// No description provided for @partyDrinkCourtesiesEmptyUsed.
  ///
  /// In en, this message translates to:
  /// **'You have no redeemed courtesies yet.'**
  String get partyDrinkCourtesiesEmptyUsed;

  /// No description provided for @drawerInvitationsNewBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} new'**
  String drawerInvitationsNewBadge(int count);

  /// No description provided for @drawerTierBronze.
  ///
  /// In en, this message translates to:
  /// **'BRONZE'**
  String get drawerTierBronze;

  /// No description provided for @drawerTierSilver.
  ///
  /// In en, this message translates to:
  /// **'SILVER'**
  String get drawerTierSilver;

  /// No description provided for @drawerTierGold.
  ///
  /// In en, this message translates to:
  /// **'GOLD'**
  String get drawerTierGold;

  /// No description provided for @drawerTierPlatinum.
  ///
  /// In en, this message translates to:
  /// **'PLATINUM'**
  String get drawerTierPlatinum;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @profileViewBenefits.
  ///
  /// In en, this message translates to:
  /// **'View my benefits'**
  String get profileViewBenefits;

  /// No description provided for @profilePersonalData.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL DATA'**
  String get profilePersonalData;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileFullName;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get profileBirthDate;

  /// No description provided for @profileGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileGender;

  /// No description provided for @profileGenderMaleValue.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get profileGenderMaleValue;

  /// No description provided for @profileInstagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram username'**
  String get profileInstagram;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'PHONE'**
  String get profilePhone;

  /// No description provided for @profileChangePhone.
  ///
  /// In en, this message translates to:
  /// **'Change phone number'**
  String get profileChangePhone;

  /// No description provided for @changePhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Change phone'**
  String get changePhoneTitle;

  /// No description provided for @changePhoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your new number. We will send a verification code to your NEW WhatsApp number.'**
  String get changePhoneSubtitle;

  /// No description provided for @changePhoneCurrentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current number'**
  String get changePhoneCurrentLabel;

  /// No description provided for @changePhoneNewLabel.
  ///
  /// In en, this message translates to:
  /// **'New number'**
  String get changePhoneNewLabel;

  /// No description provided for @changePhoneContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get changePhoneContinueButton;

  /// No description provided for @changePhoneSameNumber.
  ///
  /// In en, this message translates to:
  /// **'That is already your current number.'**
  String get changePhoneSameNumber;

  /// No description provided for @profileEditData.
  ///
  /// In en, this message translates to:
  /// **'Edit details'**
  String get profileEditData;

  /// No description provided for @profileWalletSection.
  ///
  /// In en, this message translates to:
  /// **'YOUPASS WALLET'**
  String get profileWalletSection;

  /// No description provided for @profilePaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'My payment methods'**
  String get profilePaymentMethods;

  /// No description provided for @profileCardVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa ••••4205'**
  String get profileCardVisa;

  /// No description provided for @profileCardMastercard.
  ///
  /// In en, this message translates to:
  /// **'Mastercard ••••9988'**
  String get profileCardMastercard;

  /// No description provided for @profileDefaultCard.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get profileDefaultCard;

  /// No description provided for @profileSetDefaultCard.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get profileSetDefaultCard;

  /// No description provided for @profileDeleteCard.
  ///
  /// In en, this message translates to:
  /// **'Delete card'**
  String get profileDeleteCard;

  /// No description provided for @profileDefaultCardUpdated.
  ///
  /// In en, this message translates to:
  /// **'Default payment method updated'**
  String get profileDefaultCardUpdated;

  /// No description provided for @profileViewFullWallet.
  ///
  /// In en, this message translates to:
  /// **'View full wallet'**
  String get profileViewFullWallet;

  /// No description provided for @profileWalletAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get profileWalletAvailableBalance;

  /// No description provided for @profileWalletCredits.
  ///
  /// In en, this message translates to:
  /// **'{amount} credits'**
  String profileWalletCredits(String amount);

  /// No description provided for @profileWalletTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction history'**
  String get profileWalletTransactionHistory;

  /// No description provided for @profileWalletNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get profileWalletNoTransactions;

  /// No description provided for @profileWalletDefaultDeleteRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a new default card before deleting this one'**
  String get profileWalletDefaultDeleteRequired;

  /// No description provided for @profileWalletSelectNewDefault.
  ///
  /// In en, this message translates to:
  /// **'Select new default card'**
  String get profileWalletSelectNewDefault;

  /// No description provided for @profileWalletAddCard.
  ///
  /// In en, this message translates to:
  /// **'Add new card'**
  String get profileWalletAddCard;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get profileNotifications;

  /// No description provided for @profileReceiveNotifications.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications'**
  String get profileReceiveNotifications;

  /// No description provided for @profileNotificationChannels.
  ///
  /// In en, this message translates to:
  /// **'Email · Push · WhatsApp'**
  String get profileNotificationChannels;

  /// No description provided for @profileNotificationChannelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileNotificationChannelEmail;

  /// No description provided for @profileNotificationChannelEmailDesc.
  ///
  /// In en, this message translates to:
  /// **'Formal communications, order confirmations, receipts, and long reminders'**
  String get profileNotificationChannelEmailDesc;

  /// No description provided for @profileNotificationChannelPush.
  ///
  /// In en, this message translates to:
  /// **'Push notification'**
  String get profileNotificationChannelPush;

  /// No description provided for @profileNotificationChannelPushDesc.
  ///
  /// In en, this message translates to:
  /// **'Real-time alerts, invitations, short reminders, and urgent updates'**
  String get profileNotificationChannelPushDesc;

  /// No description provided for @profileNotificationChannelWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get profileNotificationChannelWhatsApp;

  /// No description provided for @profileNotificationChannelWhatsAppDesc.
  ///
  /// In en, this message translates to:
  /// **'Interactive bot messages, invitations, payment links, and conversational updates'**
  String get profileNotificationChannelWhatsAppDesc;

  /// No description provided for @profileNotificationAdvancedSettings.
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get profileNotificationAdvancedSettings;

  /// No description provided for @profileNotificationCriticalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'These notifications cannot be disabled as they are essential to your experience.'**
  String get profileNotificationCriticalDisclaimer;

  /// No description provided for @profileNotificationAdvancedTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced notification settings'**
  String get profileNotificationAdvancedTitle;

  /// No description provided for @profileNotificationByType.
  ///
  /// In en, this message translates to:
  /// **'By type'**
  String get profileNotificationByType;

  /// No description provided for @profileNotificationTypePurchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get profileNotificationTypePurchases;

  /// No description provided for @profileNotificationTypeReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get profileNotificationTypeReminders;

  /// No description provided for @profileNotificationTypePromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get profileNotificationTypePromotions;

  /// No description provided for @profileNotificationTypeSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get profileNotificationTypeSocial;

  /// No description provided for @profileNotificationByChannel.
  ///
  /// In en, this message translates to:
  /// **'By channel'**
  String get profileNotificationByChannel;

  /// No description provided for @profileNotificationNightSilence.
  ///
  /// In en, this message translates to:
  /// **'Night silence'**
  String get profileNotificationNightSilence;

  /// No description provided for @profileNotificationNightSilenceDesc.
  ///
  /// In en, this message translates to:
  /// **'No push notifications after the selected time (your local timezone)'**
  String get profileNotificationNightSilenceDesc;

  /// No description provided for @profileNotificationNightSilenceFrom.
  ///
  /// In en, this message translates to:
  /// **'Silence push from'**
  String get profileNotificationNightSilenceFrom;

  /// No description provided for @profileNotificationCriticalTitle.
  ///
  /// In en, this message translates to:
  /// **'Critical notifications'**
  String get profileNotificationCriticalTitle;

  /// No description provided for @profileNotificationCriticalEventCancellation.
  ///
  /// In en, this message translates to:
  /// **'Event cancellation'**
  String get profileNotificationCriticalEventCancellation;

  /// No description provided for @profileNotificationCriticalEventDatetime.
  ///
  /// In en, this message translates to:
  /// **'Event date or time change'**
  String get profileNotificationCriticalEventDatetime;

  /// No description provided for @profileNotificationCriticalEventVenue.
  ///
  /// In en, this message translates to:
  /// **'Event venue or location change'**
  String get profileNotificationCriticalEventVenue;

  /// No description provided for @profileNotificationCriticalSecurity.
  ///
  /// In en, this message translates to:
  /// **'Critical security alerts'**
  String get profileNotificationCriticalSecurity;

  /// No description provided for @profileNotificationCriticalPaymentReceipts.
  ///
  /// In en, this message translates to:
  /// **'Payment receipts / purchase confirmations'**
  String get profileNotificationCriticalPaymentReceipts;

  /// No description provided for @profileNotificationCriticalRefunds.
  ///
  /// In en, this message translates to:
  /// **'Processed refunds'**
  String get profileNotificationCriticalRefunds;

  /// No description provided for @profileNotificationUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update notification settings. Please try again.'**
  String get profileNotificationUpdateFailed;

  /// No description provided for @profileSupport.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get profileSupport;

  /// No description provided for @profileWhatsAppSupport.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp support'**
  String get profileWhatsAppSupport;

  /// No description provided for @profileWriteEmail.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get profileWriteEmail;

  /// No description provided for @profileFaq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get profileFaq;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileLogout;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteInfoIntro.
  ///
  /// In en, this message translates to:
  /// **'The following will be permanently deleted:'**
  String get profileDeleteInfoIntro;

  /// No description provided for @profileDeleteItemPersonalData.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get profileDeleteItemPersonalData;

  /// No description provided for @profileDeleteItemTickets.
  ///
  /// In en, this message translates to:
  /// **'Active and future tickets'**
  String get profileDeleteItemTickets;

  /// No description provided for @profileDeleteItemPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get profileDeleteItemPaymentMethods;

  /// No description provided for @profileDeleteItemPoints.
  ///
  /// In en, this message translates to:
  /// **'Accumulated points'**
  String get profileDeleteItemPoints;

  /// No description provided for @profileDeleteItemHistory.
  ///
  /// In en, this message translates to:
  /// **'Complete history'**
  String get profileDeleteItemHistory;

  /// No description provided for @profileDeleteIrreversibleWarning.
  ///
  /// In en, this message translates to:
  /// **'This action is IRREVERSIBLE after 7 days.'**
  String get profileDeleteIrreversibleWarning;

  /// No description provided for @accountDeletionBiometricReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm your identity to continue with account deletion'**
  String get accountDeletionBiometricReason;

  /// No description provided for @accountDeletionBiometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Account deletion was not started.'**
  String get accountDeletionBiometricFailed;

  /// No description provided for @accountDeletionPendingBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Account pending deletion'**
  String get accountDeletionPendingBannerTitle;

  /// No description provided for @accountDeletionPendingBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account will be deleted on {date} ({days} days remaining). Tap to cancel.'**
  String accountDeletionPendingBannerSubtitle(String date, int days);

  /// No description provided for @accountDeletionCancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel deletion'**
  String get accountDeletionCancelAction;

  /// No description provided for @accountDeletionCancelled.
  ///
  /// In en, this message translates to:
  /// **'Your YOUPASS account is still active.'**
  String get accountDeletionCancelled;

  /// No description provided for @profilePhotoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated'**
  String get profilePhotoUpdated;

  /// No description provided for @profileCompleteBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get profileCompleteBannerTitle;

  /// No description provided for @profileCompleteBannerSubtitleBoth.
  ///
  /// In en, this message translates to:
  /// **'Add your photo and Instagram to personalise your experience'**
  String get profileCompleteBannerSubtitleBoth;

  /// No description provided for @profileCompleteBannerSubtitlePhoto.
  ///
  /// In en, this message translates to:
  /// **'Add your profile photo to be better identified'**
  String get profileCompleteBannerSubtitlePhoto;

  /// No description provided for @profileCompleteBannerSubtitleInstagram.
  ///
  /// In en, this message translates to:
  /// **'Add your Instagram to connect with other attendees'**
  String get profileCompleteBannerSubtitleInstagram;

  /// No description provided for @profileCompleteBannerButton.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE'**
  String get profileCompleteBannerButton;

  /// No description provided for @profilePhotoChooseSource.
  ///
  /// In en, this message translates to:
  /// **'Change profile photo'**
  String get profilePhotoChooseSource;

  /// No description provided for @profilePhotoTake.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get profilePhotoTake;

  /// No description provided for @profilePhotoGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get profilePhotoGallery;

  /// No description provided for @profileNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Not added'**
  String get profileNotAdded;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit details'**
  String get profileEditTitle;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileSave;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileSaved;

  /// No description provided for @profileGenderFemaleValue.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get profileGenderFemaleValue;

  /// No description provided for @profileGenderOtherValue.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get profileGenderOtherValue;

  /// No description provided for @profileGenderPreferNotSayValue.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get profileGenderPreferNotSayValue;

  /// No description provided for @profileCategoryBenefits.
  ///
  /// In en, this message translates to:
  /// **'My benefits'**
  String get profileCategoryBenefits;

  /// No description provided for @profileFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get profileFaqTitle;

  /// No description provided for @profileFaqSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get profileFaqSearch;

  /// No description provided for @profileFaqHelpful.
  ///
  /// In en, this message translates to:
  /// **'Was this helpful?'**
  String get profileFaqHelpful;

  /// No description provided for @profileFaqYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get profileFaqYes;

  /// No description provided for @profileFaqNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get profileFaqNo;

  /// No description provided for @profileFaqNoResults.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find an answer. Contact us directly.'**
  String get profileFaqNoResults;

  /// No description provided for @profileFaqContactWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Contact via WhatsApp'**
  String get profileFaqContactWhatsApp;

  /// No description provided for @profileFaqContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Send email'**
  String get profileFaqContactEmail;

  /// No description provided for @profileWhatsAppNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp is not installed on this device. Please contact us by email instead.'**
  String get profileWhatsAppNotInstalled;

  /// No description provided for @profileDeleteInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDeleteInfoTitle;

  /// No description provided for @profileDeleteInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Your personal data, active and future tickets, payment methods, accumulated points, and full history will be deleted. This action is IRREVERSIBLE after 7 days.'**
  String get profileDeleteInfoMessage;

  /// No description provided for @profileDeleteContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue with deletion'**
  String get profileDeleteContinue;

  /// No description provided for @profileDeletePendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account will be deleted in {days} days. Cancel deletion?'**
  String profileDeletePendingMessage(int days);

  /// No description provided for @profileEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'YouPass support request'**
  String get profileEmailSubject;

  /// No description provided for @profileAdvancedNotifications.
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get profileAdvancedNotifications;

  /// No description provided for @confirmDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get confirmDialogCancel;

  /// No description provided for @confirmLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get confirmLogoutTitle;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account, tickets, wallet, and points will be saved. You can sign back in anytime with your phone number and OTP code.'**
  String get confirmLogoutMessage;

  /// No description provided for @confirmLogoutAction.
  ///
  /// In en, this message translates to:
  /// **'Yes, sign out'**
  String get confirmLogoutAction;

  /// No description provided for @confirmDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get confirmDeleteAccountTitle;

  /// No description provided for @confirmDeleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes your account, tickets, and profile data. We will send a verification code to confirm.'**
  String get confirmDeleteAccountMessage;

  /// No description provided for @confirmDeleteAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get confirmDeleteAccountAction;

  /// No description provided for @ticketsTabUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Active / Upcoming'**
  String get ticketsTabUpcoming;

  /// No description provided for @ticketsTabPast.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get ticketsTabPast;

  /// No description provided for @ticketsStatusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get ticketsStatusActive;

  /// No description provided for @ticketsStatusValidated.
  ///
  /// In en, this message translates to:
  /// **'VALIDATED'**
  String get ticketsStatusValidated;

  /// No description provided for @ticketsStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'EXPIRED'**
  String get ticketsStatusExpired;

  /// No description provided for @ticketsStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'CANCELLED'**
  String get ticketsStatusCancelled;

  /// No description provided for @ticketsStatusRefunded.
  ///
  /// In en, this message translates to:
  /// **'REFUNDED'**
  String get ticketsStatusRefunded;

  /// No description provided for @ticketsInvitationPending.
  ///
  /// In en, this message translates to:
  /// **'INVITATION'**
  String get ticketsInvitationPending;

  /// No description provided for @ticketsInvitationExpires.
  ///
  /// In en, this message translates to:
  /// **'Respond before {deadline}'**
  String ticketsInvitationExpires(String deadline);

  /// No description provided for @ticketsQrCountdown.
  ///
  /// In en, this message translates to:
  /// **'Your QR will be available on {eventDate}'**
  String ticketsQrCountdown(String eventDate);

  /// No description provided for @ticketsQrUnavailable.
  ///
  /// In en, this message translates to:
  /// **'QR LOCKED'**
  String get ticketsQrUnavailable;

  /// No description provided for @ticketsCancelTicket.
  ///
  /// In en, this message translates to:
  /// **'Cancel ticket'**
  String get ticketsCancelTicket;

  /// No description provided for @ticketsCancelTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this ticket?'**
  String get ticketsCancelTicketTitle;

  /// No description provided for @ticketsCancelTicketMessage.
  ///
  /// In en, this message translates to:
  /// **'Your ticket will be cancelled and an automatic refund will be processed when applicable.'**
  String get ticketsCancelTicketMessage;

  /// No description provided for @ticketsCancelTicketConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get ticketsCancelTicketConfirm;

  /// No description provided for @ticketsCancelTicketSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ticket cancelled. Refund is being processed.'**
  String get ticketsCancelTicketSuccess;

  /// No description provided for @bottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// No description provided for @bottomNavInvitations.
  ///
  /// In en, this message translates to:
  /// **'Invites'**
  String get bottomNavInvitations;

  /// No description provided for @bottomNavTickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get bottomNavTickets;

  /// No description provided for @ticketsViewQr.
  ///
  /// In en, this message translates to:
  /// **'VIEW QR'**
  String get ticketsViewQr;

  /// No description provided for @ticketsAssignEntries.
  ///
  /// In en, this message translates to:
  /// **'ASSIGN TICKETS'**
  String get ticketsAssignEntries;

  /// No description provided for @ticketsAssignVip.
  ///
  /// In en, this message translates to:
  /// **'ASSIGN VIP TICKETS'**
  String get ticketsAssignVip;

  /// No description provided for @ticketsViewAssigned.
  ///
  /// In en, this message translates to:
  /// **'VIEW ASSIGNED TICKETS'**
  String get ticketsViewAssigned;

  /// No description provided for @ticketsAttendedSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'ATTENDED EVENTS'**
  String get ticketsAttendedSectionTitle;

  /// No description provided for @ticketsAttendedSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your past events and your personal statistics.'**
  String get ticketsAttendedSectionSubtitle;

  /// No description provided for @ticketsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search event / Event name / promoter'**
  String get ticketsSearchHint;

  /// No description provided for @ticketsFiltersLabel.
  ///
  /// In en, this message translates to:
  /// **'FILTERS'**
  String get ticketsFiltersLabel;

  /// No description provided for @ticketsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get ticketsFilterAll;

  /// No description provided for @ticketsFilterParties.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get ticketsFilterParties;

  /// No description provided for @ticketsFilterConcerts.
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get ticketsFilterConcerts;

  /// No description provided for @ticketsFilterBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get ticketsFilterBar;

  /// No description provided for @ticketsYearlySummaryAttended.
  ///
  /// In en, this message translates to:
  /// **'{count} events attended in {year}'**
  String ticketsYearlySummaryAttended(int count, int year);

  /// No description provided for @ticketsYearlySummaryProducer.
  ///
  /// In en, this message translates to:
  /// **'Favorite producer: {name} ({count} events)'**
  String ticketsYearlySummaryProducer(String name, int count);

  /// No description provided for @ticketsEmptyUpcoming.
  ///
  /// In en, this message translates to:
  /// **'No upcoming tickets yet.'**
  String get ticketsEmptyUpcoming;

  /// No description provided for @ticketsEmptyPast.
  ///
  /// In en, this message translates to:
  /// **'No past events found.'**
  String get ticketsEmptyPast;

  /// No description provided for @ticketsRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get ticketsRetry;

  /// No description provided for @ticketsStatistics.
  ///
  /// In en, this message translates to:
  /// **'STATISTICS'**
  String get ticketsStatistics;

  /// No description provided for @ticketsStatEntry.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get ticketsStatEntry;

  /// No description provided for @ticketsStatConsumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption'**
  String get ticketsStatConsumption;

  /// No description provided for @ticketsStatStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get ticketsStatStay;

  /// No description provided for @ticketsFavoritesTip.
  ///
  /// In en, this message translates to:
  /// **'You can mark events to add them to favorites.'**
  String get ticketsFavoritesTip;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your favorite producers and events will appear here'**
  String get favoritesSubtitle;

  /// No description provided for @favoritesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search producer or event'**
  String get favoritesSearchHint;

  /// No description provided for @favoritesFiltersLabel.
  ///
  /// In en, this message translates to:
  /// **'FILTERS'**
  String get favoritesFiltersLabel;

  /// No description provided for @favoritesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get favoritesFilterAll;

  /// No description provided for @favoritesFilterUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get favoritesFilterUpcoming;

  /// No description provided for @favoritesFilterParties.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get favoritesFilterParties;

  /// No description provided for @favoritesFilterVip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get favoritesFilterVip;

  /// No description provided for @favoritesProducerType.
  ///
  /// In en, this message translates to:
  /// **'Event producer'**
  String get favoritesProducerType;

  /// No description provided for @favoritesProducerCoverage.
  ///
  /// In en, this message translates to:
  /// **'Events across Chile'**
  String get favoritesProducerCoverage;

  /// No description provided for @favoritesViewEvents.
  ///
  /// In en, this message translates to:
  /// **'VIEW EVENTS'**
  String get favoritesViewEvents;

  /// No description provided for @favoritesSavedProducersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 saved producer} other{{count} saved producers}}'**
  String favoritesSavedProducersCount(int count);

  /// No description provided for @favoritesYoufestDescription.
  ///
  /// In en, this message translates to:
  /// **'The best festivals and live experiences.'**
  String get favoritesYoufestDescription;

  /// No description provided for @favoritesIguanaDescription.
  ///
  /// In en, this message translates to:
  /// **'Electronic music, parties and unique experiences.'**
  String get favoritesIguanaDescription;

  /// No description provided for @favoritesFollowerCount.
  ///
  /// In en, this message translates to:
  /// **'{count} followers'**
  String favoritesFollowerCount(String count);

  /// No description provided for @favoritesNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No promoters found matching your search'**
  String get favoritesNoSearchResults;

  /// No description provided for @favoritesExploreCta.
  ///
  /// In en, this message translates to:
  /// **'Explore events'**
  String get favoritesExploreCta;

  /// No description provided for @favoritesSectionFollowedPromoters.
  ///
  /// In en, this message translates to:
  /// **'FOLLOWED PROMOTERS'**
  String get favoritesSectionFollowedPromoters;

  /// No description provided for @favoritesSectionSavedEvents.
  ///
  /// In en, this message translates to:
  /// **'SAVED EVENTS'**
  String get favoritesSectionSavedEvents;

  /// No description provided for @producerEventPresale.
  ///
  /// In en, this message translates to:
  /// **'PRE-SALE'**
  String get producerEventPresale;

  /// No description provided for @producerEventPrepay.
  ///
  /// In en, this message translates to:
  /// **'PRE-PAY'**
  String get producerEventPrepay;

  /// No description provided for @producerEventsUpcomingTitle.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING EVENTS'**
  String get producerEventsUpcomingTitle;

  /// No description provided for @producerEventsUpcomingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover upcoming events from {producerName}'**
  String producerEventsUpcomingSubtitle(String producerName);

  /// No description provided for @producerEventsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search event'**
  String get producerEventsSearchHint;

  /// No description provided for @producerEventsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No upcoming events from this promoter yet.'**
  String get producerEventsEmpty;

  /// No description provided for @producerEventCategoryParties.
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get producerEventCategoryParties;

  /// No description provided for @producerEventCategoryFestivals.
  ///
  /// In en, this message translates to:
  /// **'Festivals'**
  String get producerEventCategoryFestivals;

  /// No description provided for @producerEventCategoryConcerts.
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get producerEventCategoryConcerts;

  /// No description provided for @producerEventFromPrice.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get producerEventFromPrice;

  /// No description provided for @producerEventBuyTicket.
  ///
  /// In en, this message translates to:
  /// **'BUY TICKET'**
  String get producerEventBuyTicket;

  /// No description provided for @producerEventsAvailableCount.
  ///
  /// In en, this message translates to:
  /// **'{count} events available'**
  String producerEventsAvailableCount(int count);

  /// No description provided for @drawerMyInvitations.
  ///
  /// In en, this message translates to:
  /// **'My Invitations'**
  String get drawerMyInvitations;

  /// No description provided for @invitationsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'MY INVITATIONS'**
  String get invitationsScreenTitle;

  /// No description provided for @invitationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your event accesses and invitations'**
  String get invitationsSubtitle;

  /// No description provided for @invitationsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search invitation · Event / promoter'**
  String get invitationsSearchHint;

  /// No description provided for @invitationsFiltersLabel.
  ///
  /// In en, this message translates to:
  /// **'FILTERS'**
  String get invitationsFiltersLabel;

  /// No description provided for @invitationsFilterCourtesy.
  ///
  /// In en, this message translates to:
  /// **'Courtesies'**
  String get invitationsFilterCourtesy;

  /// No description provided for @invitationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get invitationsFilterAll;

  /// No description provided for @invitationsFilterFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get invitationsFilterFree;

  /// No description provided for @invitationsFilterGuaranteedPass.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed Pass'**
  String get invitationsFilterGuaranteedPass;

  /// No description provided for @invitationsFilterDiscounted.
  ///
  /// In en, this message translates to:
  /// **'Discounted'**
  String get invitationsFilterDiscounted;

  /// No description provided for @invitationsTypeFree.
  ///
  /// In en, this message translates to:
  /// **'Free Invitation'**
  String get invitationsTypeFree;

  /// No description provided for @invitationsTypeAssigned.
  ///
  /// In en, this message translates to:
  /// **'Invitation'**
  String get invitationsTypeAssigned;

  /// No description provided for @invitationsTypeVip.
  ///
  /// In en, this message translates to:
  /// **'VIP Invitation'**
  String get invitationsTypeVip;

  /// No description provided for @invitationsTypeGuaranteedPass.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed Pass'**
  String get invitationsTypeGuaranteedPass;

  /// No description provided for @invitationsTypeDiscounted.
  ///
  /// In en, this message translates to:
  /// **'Discounted Invitation'**
  String get invitationsTypeDiscounted;

  /// No description provided for @invitationsGuaranteedPassTitle.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed Pass'**
  String get invitationsGuaranteedPassTitle;

  /// No description provided for @invitationsGuaranteedPassMessage.
  ///
  /// In en, this message translates to:
  /// **'This pass is FREE if you attend. If you do not attend and do not cancel by {deadline}, {amount} will be charged to your card.'**
  String invitationsGuaranteedPassMessage(String deadline, String amount);

  /// No description provided for @invitationsGuaranteedPassTerms.
  ///
  /// In en, this message translates to:
  /// **'I understand the attendance commitment and possible charge'**
  String get invitationsGuaranteedPassTerms;

  /// No description provided for @invitationsGpTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms to continue'**
  String get invitationsGpTermsRequired;

  /// No description provided for @invitationsPreauthNotice.
  ///
  /// In en, this message translates to:
  /// **'Your card will be pre-authorised for {amount}. You will only be charged if you no-show.'**
  String invitationsPreauthNotice(String amount);

  /// No description provided for @invitationsDiscountedPayTitle.
  ///
  /// In en, this message translates to:
  /// **'Discounted Invitation'**
  String get invitationsDiscountedPayTitle;

  /// No description provided for @invitationsDiscountedPayMessage.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount} now to accept this invitation.'**
  String invitationsDiscountedPayMessage(String amount);

  /// No description provided for @invitationsDiscountPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% discount'**
  String invitationsDiscountPercent(int percent);

  /// No description provided for @invitationsCancelBy.
  ///
  /// In en, this message translates to:
  /// **'Cancel by {deadline}'**
  String invitationsCancelBy(String deadline);

  /// No description provided for @invitationsAcceptGuaranteed.
  ///
  /// In en, this message translates to:
  /// **'ACCEPT AND RESERVE'**
  String get invitationsAcceptGuaranteed;

  /// No description provided for @invitationsAcceptAndReserve.
  ///
  /// In en, this message translates to:
  /// **'ACCEPT AND RESERVE'**
  String get invitationsAcceptAndReserve;

  /// No description provided for @invitationsGuaranteedPassDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed Pass'**
  String get invitationsGuaranteedPassDetailTitle;

  /// No description provided for @invitationsDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Invitation details'**
  String get invitationsDetailTitle;

  /// No description provided for @invitationsGuaranteedBadge.
  ///
  /// In en, this message translates to:
  /// **'GUARANTEED'**
  String get invitationsGuaranteedBadge;

  /// No description provided for @invitationsAssignedSlot.
  ///
  /// In en, this message translates to:
  /// **'Slot: {slot}'**
  String invitationsAssignedSlot(String slot);

  /// No description provided for @invitationsPassStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String invitationsPassStatus(String status);

  /// No description provided for @invitationsGpWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'⚠ IMPORTANT'**
  String get invitationsGpWarningTitle;

  /// No description provided for @invitationsGpWarningBody.
  ///
  /// In en, this message translates to:
  /// **'If you attend: 100% FREE\nIf you don\'t attend: {amount} will be charged to your card\n\nCANCELLATION DEADLINE\nUntil {deadline} without charge\n\nBy accepting, you authorise the charge to your card if you do not attend the event.'**
  String invitationsGpWarningBody(String amount, String deadline);

  /// No description provided for @invitationsBiometricReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm your Guaranteed Pass acceptance'**
  String get invitationsBiometricReason;

  /// No description provided for @invitationsGpPaymentRequired.
  ///
  /// In en, this message translates to:
  /// **'You need to add a payment method to accept a Guaranteed Pass'**
  String get invitationsGpPaymentRequired;

  /// No description provided for @invitationsGpActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed Pass active'**
  String get invitationsGpActiveTitle;

  /// No description provided for @invitationsGpActiveMessage.
  ///
  /// In en, this message translates to:
  /// **'Your pass to {event} is reserved. Cancel before {deadline} without charge.'**
  String invitationsGpActiveMessage(String event, String deadline);

  /// No description provided for @invitationsGpActiveCta.
  ///
  /// In en, this message translates to:
  /// **'Go to My Tickets'**
  String get invitationsGpActiveCta;

  /// No description provided for @invitationsCancelInvitation.
  ///
  /// In en, this message translates to:
  /// **'Cancel invitation'**
  String get invitationsCancelInvitation;

  /// No description provided for @invitationsGpCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel your Guaranteed Pass?'**
  String get invitationsGpCancelTitle;

  /// No description provided for @invitationsGpCancelMessage.
  ///
  /// In en, this message translates to:
  /// **'Your card hold will be released immediately. This cannot be undone.'**
  String get invitationsGpCancelMessage;

  /// No description provided for @invitationsGpCancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get invitationsGpCancelConfirm;

  /// No description provided for @invitationsGpCancelSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your Guaranteed Pass was cancelled without charge.'**
  String get invitationsGpCancelSuccess;

  /// No description provided for @invitationsAcceptDiscounted.
  ///
  /// In en, this message translates to:
  /// **'PAY & ACCEPT'**
  String get invitationsAcceptDiscounted;

  /// No description provided for @invitationsFilterGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get invitationsFilterGeneral;

  /// No description provided for @invitationsFilterVip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get invitationsFilterVip;

  /// No description provided for @invitationsFilterTables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get invitationsFilterTables;

  /// No description provided for @invitationsTierVipDj.
  ///
  /// In en, this message translates to:
  /// **'VIP DJ'**
  String get invitationsTierVipDj;

  /// No description provided for @invitationsTierVip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get invitationsTierVip;

  /// No description provided for @invitationsTierVipMesa.
  ///
  /// In en, this message translates to:
  /// **'VIP Table'**
  String get invitationsTierVipMesa;

  /// No description provided for @invitationsTierGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get invitationsTierGeneral;

  /// No description provided for @invitationsTierFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get invitationsTierFree;

  /// No description provided for @invitationsInvitedBy.
  ///
  /// In en, this message translates to:
  /// **'Invited by {name}'**
  String invitationsInvitedBy(String name);

  /// No description provided for @invitationsAcceptBy.
  ///
  /// In en, this message translates to:
  /// **'Accept by {deadline}'**
  String invitationsAcceptBy(String deadline);

  /// No description provided for @invitationsStatusLine.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String invitationsStatusLine(String status);

  /// No description provided for @invitationsStatusPrefix.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get invitationsStatusPrefix;

  /// No description provided for @invitationsStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get invitationsStatusPending;

  /// No description provided for @invitationsStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get invitationsStatusConfirmed;

  /// No description provided for @invitationsStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get invitationsStatusRejected;

  /// No description provided for @invitationsConfirmAttendance.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM ATTENDANCE'**
  String get invitationsConfirmAttendance;

  /// No description provided for @invitationsTabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get invitationsTabPending;

  /// No description provided for @invitationsTabConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get invitationsTabConfirmed;

  /// No description provided for @invitationsEmptyNone.
  ///
  /// In en, this message translates to:
  /// **'You have no invitations yet.'**
  String get invitationsEmptyNone;

  /// No description provided for @invitationsEmptySearch.
  ///
  /// In en, this message translates to:
  /// **'No invitations found for that search.'**
  String get invitationsEmptySearch;

  /// No description provided for @invitationsEmptyPending.
  ///
  /// In en, this message translates to:
  /// **'You have no pending invitations.'**
  String get invitationsEmptyPending;

  /// No description provided for @invitationsEmptyConfirmed.
  ///
  /// In en, this message translates to:
  /// **'You have no confirmed invitations yet.'**
  String get invitationsEmptyConfirmed;

  /// No description provided for @invitationsRejectConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject invitation?'**
  String get invitationsRejectConfirmTitle;

  /// No description provided for @invitationsRejectConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this invitation?'**
  String get invitationsRejectConfirmMessage;

  /// No description provided for @invitationsRejectConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'REJECT'**
  String get invitationsRejectConfirmAction;

  /// No description provided for @invitationsCancellationDeadlinePassed.
  ///
  /// In en, this message translates to:
  /// **'Cancellation deadline has passed'**
  String get invitationsCancellationDeadlinePassed;

  /// No description provided for @invitationsWaitingConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Waiting for confirmation…'**
  String get invitationsWaitingConfirmation;

  /// No description provided for @invitationsQrAvailableOn.
  ///
  /// In en, this message translates to:
  /// **'Your QR will be available on {date}'**
  String invitationsQrAvailableOn(String date);

  /// No description provided for @invitationsReject.
  ///
  /// In en, this message translates to:
  /// **'REJECT'**
  String get invitationsReject;

  /// No description provided for @invitationsCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get invitationsCancel;

  /// No description provided for @invitationsAttendanceConfirmed.
  ///
  /// In en, this message translates to:
  /// **'ATTENDANCE CONFIRMED'**
  String get invitationsAttendanceConfirmed;

  /// No description provided for @invitationsViewQr.
  ///
  /// In en, this message translates to:
  /// **'VIEW QR'**
  String get invitationsViewQr;

  /// No description provided for @invitationsQrPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm attendance first'**
  String get invitationsQrPendingTitle;

  /// No description provided for @invitationsQrPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your QR code will be available after you confirm this invitation.'**
  String get invitationsQrPendingMessage;

  /// No description provided for @invitationsQrLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'QR not available yet'**
  String get invitationsQrLockedTitle;

  /// No description provided for @invitationsQrLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your QR will be available from 00:00 on the day of the event.'**
  String get invitationsQrLockedMessage;

  /// No description provided for @invitationsQrExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'QR expired'**
  String get invitationsQrExpiredTitle;

  /// No description provided for @invitationsQrExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This event QR is no longer available.'**
  String get invitationsQrExpiredMessage;

  /// No description provided for @invitationsQrUnlockAt.
  ///
  /// In en, this message translates to:
  /// **'Available from {date}'**
  String invitationsQrUnlockAt(String date);

  /// No description provided for @invitationsQrGotIt.
  ///
  /// In en, this message translates to:
  /// **'GOT IT'**
  String get invitationsQrGotIt;

  /// No description provided for @invitationsFooterNote.
  ///
  /// In en, this message translates to:
  /// **'Confirmed invitations generate a unique and non-transferable QR code.'**
  String get invitationsFooterNote;

  /// No description provided for @invitationsImportantTitle.
  ///
  /// In en, this message translates to:
  /// **'Important ⚠'**
  String get invitationsImportantTitle;

  /// No description provided for @invitationsImportantMessage.
  ///
  /// In en, this message translates to:
  /// **'By confirming your attendance, your ticket will be reserved exclusively for you. If you do not attend the event, you may be charged the full ticket price when this condition applies.'**
  String get invitationsImportantMessage;

  /// No description provided for @invitationsAddPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'ADD PAYMENT METHOD'**
  String get invitationsAddPaymentMethod;

  /// No description provided for @invitationsDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get invitationsDialogCancel;

  /// No description provided for @invitationsPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add payment method'**
  String get invitationsPaymentTitle;

  /// No description provided for @invitationsPaymentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your card details'**
  String get invitationsPaymentSubtitle;

  /// No description provided for @invitationsCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get invitationsCardNumber;

  /// No description provided for @invitationsCardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'1234 5678 9012 3456'**
  String get invitationsCardNumberHint;

  /// No description provided for @invitationsCardExpiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get invitationsCardExpiry;

  /// No description provided for @invitationsCardExpiryHint.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get invitationsCardExpiryHint;

  /// No description provided for @invitationsCardCvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get invitationsCardCvv;

  /// No description provided for @invitationsCardCvvHint.
  ///
  /// In en, this message translates to:
  /// **'123'**
  String get invitationsCardCvvHint;

  /// No description provided for @invitationsCardholderName.
  ///
  /// In en, this message translates to:
  /// **'Name on card'**
  String get invitationsCardholderName;

  /// No description provided for @invitationsCardholderNameHint.
  ///
  /// In en, this message translates to:
  /// **'As shown on the card'**
  String get invitationsCardholderNameHint;

  /// No description provided for @invitationsPaymentSecureNote.
  ///
  /// In en, this message translates to:
  /// **'Your information is protected and will be used securely.'**
  String get invitationsPaymentSecureNote;

  /// No description provided for @invitationsSaveCard.
  ///
  /// In en, this message translates to:
  /// **'SAVE CARD'**
  String get invitationsSaveCard;

  /// No description provided for @invitationsCardSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Card saved successfully!'**
  String get invitationsCardSavedTitle;

  /// No description provided for @invitationsCardSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your payment method has been registered correctly. Remember the following:'**
  String get invitationsCardSavedMessage;

  /// No description provided for @invitationsCardSavedReminderCharge.
  ///
  /// In en, this message translates to:
  /// **'If you confirm attendance and do not show up, you will be charged the full ticket price.'**
  String get invitationsCardSavedReminderCharge;

  /// No description provided for @invitationsCardSavedReminderCancel.
  ///
  /// In en, this message translates to:
  /// **'If you wish to cancel your attendance, you must do so at least 48 hours in advance to avoid being charged.'**
  String get invitationsCardSavedReminderCancel;

  /// No description provided for @eventTicketScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Event ticket'**
  String get eventTicketScreenTitle;

  /// No description provided for @eventTicketReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your ticket is ready!'**
  String get eventTicketReadyTitle;

  /// No description provided for @eventTicketReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show this code at the entrance to enter the event.'**
  String get eventTicketReadySubtitle;

  /// No description provided for @eventTicketManualIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Manual entry ID'**
  String get eventTicketManualIdLabel;

  /// No description provided for @welcomeFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to YouPass'**
  String get welcomeFallbackTitle;

  /// No description provided for @welcomeFallbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your access to the best events starts here'**
  String get welcomeFallbackSubtitle;

  /// No description provided for @paymentBrandVisa.
  ///
  /// In en, this message translates to:
  /// **'VISA'**
  String get paymentBrandVisa;

  /// No description provided for @paymentBrandMastercard.
  ///
  /// In en, this message translates to:
  /// **'MC'**
  String get paymentBrandMastercard;

  /// No description provided for @errorMissingAccessToken.
  ///
  /// In en, this message translates to:
  /// **'Could not complete sign in. Please try again.'**
  String get errorMissingAccessToken;

  /// No description provided for @errorAuthenticationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to continue.'**
  String get errorAuthenticationRequired;

  /// No description provided for @errorTicketOrderNotFound.
  ///
  /// In en, this message translates to:
  /// **'This ticket order could not be found.'**
  String get errorTicketOrderNotFound;

  /// No description provided for @errorTicketSlotNotFound.
  ///
  /// In en, this message translates to:
  /// **'This ticket slot could not be found.'**
  String get errorTicketSlotNotFound;

  /// No description provided for @errorTicketSlotNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'This ticket is no longer available to assign.'**
  String get errorTicketSlotNotAvailable;

  /// No description provided for @errorWhatsAppSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not send the WhatsApp invitation. Try again.'**
  String get errorWhatsAppSendFailed;

  /// No description provided for @errorCannotAssignToSelf.
  ///
  /// In en, this message translates to:
  /// **'You cannot assign a ticket to your own phone number.'**
  String get errorCannotAssignToSelf;

  /// No description provided for @errorClaimNotFound.
  ///
  /// In en, this message translates to:
  /// **'This invitation link is invalid or has expired.'**
  String get errorClaimNotFound;

  /// No description provided for @errorInvitationForbidden.
  ///
  /// In en, this message translates to:
  /// **'You are not allowed to manage this invitation.'**
  String get errorInvitationForbidden;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @phoneHintChile.
  ///
  /// In en, this message translates to:
  /// **'9 1234 5678'**
  String get phoneHintChile;

  /// No description provided for @phoneHintGeneric.
  ///
  /// In en, this message translates to:
  /// **'123 456 7890'**
  String get phoneHintGeneric;

  /// No description provided for @phoneHintPakistan.
  ///
  /// In en, this message translates to:
  /// **'321 6548001'**
  String get phoneHintPakistan;

  /// No description provided for @mockEventFestivalVerano2026.
  ///
  /// In en, this message translates to:
  /// **'Summer Festival 2026'**
  String get mockEventFestivalVerano2026;

  /// No description provided for @mockEventConciertoX.
  ///
  /// In en, this message translates to:
  /// **'Concert X'**
  String get mockEventConciertoX;

  /// No description provided for @mockEventYoufest2026.
  ///
  /// In en, this message translates to:
  /// **'YouFest 2026'**
  String get mockEventYoufest2026;

  /// No description provided for @mockEventIguanaSummer.
  ///
  /// In en, this message translates to:
  /// **'IGUANA SUMMER'**
  String get mockEventIguanaSummer;

  /// No description provided for @mockEventYoufestWinter2026.
  ///
  /// In en, this message translates to:
  /// **'YouFest Winter 2026'**
  String get mockEventYoufestWinter2026;

  /// No description provided for @mockEventNeonRooftopSessions.
  ///
  /// In en, this message translates to:
  /// **'Neon Rooftop Sessions'**
  String get mockEventNeonRooftopSessions;

  /// No description provided for @mockEventSummerClosingParty.
  ///
  /// In en, this message translates to:
  /// **'Summer Closing Party'**
  String get mockEventSummerClosingParty;

  /// No description provided for @mockDateSaturdayMay15.
  ///
  /// In en, this message translates to:
  /// **'Saturday, May 15 · 10:00 PM'**
  String get mockDateSaturdayMay15;

  /// No description provided for @mockDateSaturdayMay15Long.
  ///
  /// In en, this message translates to:
  /// **'Saturday, May 15, 2026 - 10:00 PM'**
  String get mockDateSaturdayMay15Long;

  /// No description provided for @mockDateSaturdayJuly4.
  ///
  /// In en, this message translates to:
  /// **'Sat, Jul 4 · 10:00 PM'**
  String get mockDateSaturdayJuly4;

  /// No description provided for @mockLocationClubAmanda.
  ///
  /// In en, this message translates to:
  /// **'Club Amanda, Santiago'**
  String get mockLocationClubAmanda;

  /// No description provided for @mockLocationClubAmandaShort.
  ///
  /// In en, this message translates to:
  /// **'Club Amanda'**
  String get mockLocationClubAmandaShort;

  /// No description provided for @mockLocationMovistarArena.
  ///
  /// In en, this message translates to:
  /// **'Movistar Arena'**
  String get mockLocationMovistarArena;

  /// No description provided for @mockLocationCentroEventosHilaria.
  ///
  /// In en, this message translates to:
  /// **'Centro Eventos Hilaria'**
  String get mockLocationCentroEventosHilaria;

  /// No description provided for @mockTicketGeneralOne.
  ///
  /// In en, this message translates to:
  /// **'General · 1 ticket'**
  String get mockTicketGeneralOne;

  /// No description provided for @mockTicketVipTwo.
  ///
  /// In en, this message translates to:
  /// **'VIP · 2 tickets'**
  String get mockTicketVipTwo;

  /// No description provided for @mockStayDuration5h14m.
  ///
  /// In en, this message translates to:
  /// **'5h 14m'**
  String get mockStayDuration5h14m;

  /// No description provided for @mockSeatVipTable.
  ///
  /// In en, this message translates to:
  /// **'Table 1 - VIP 1 | 10 guests'**
  String get mockSeatVipTable;

  /// No description provided for @mockProducerYoufest.
  ///
  /// In en, this message translates to:
  /// **'YouFest'**
  String get mockProducerYoufest;

  /// No description provided for @mockProducerIguana.
  ///
  /// In en, this message translates to:
  /// **'IGUANA'**
  String get mockProducerIguana;

  /// No description provided for @mockPriceFrom35000.
  ///
  /// In en, this message translates to:
  /// **'From \$35,000 CLP'**
  String get mockPriceFrom35000;

  /// No description provided for @mockPriceFrom28000.
  ///
  /// In en, this message translates to:
  /// **'From \$28,000 CLP'**
  String get mockPriceFrom28000;

  /// No description provided for @mockPriceFrom42000.
  ///
  /// In en, this message translates to:
  /// **'From \$42,000 CLP'**
  String get mockPriceFrom42000;

  /// No description provided for @mockPriceFrom55000.
  ///
  /// In en, this message translates to:
  /// **'From \$55,000 CLP'**
  String get mockPriceFrom55000;

  /// No description provided for @mockPriceFrom32000.
  ///
  /// In en, this message translates to:
  /// **'From \$32,000 CLP'**
  String get mockPriceFrom32000;

  /// No description provided for @mockDateSaturdayJuly18.
  ///
  /// In en, this message translates to:
  /// **'Sat, Jul 18, 2026'**
  String get mockDateSaturdayJuly18;

  /// No description provided for @mockDateFridayAugust7.
  ///
  /// In en, this message translates to:
  /// **'Fri, Aug 7, 2026'**
  String get mockDateFridayAugust7;

  /// No description provided for @mockDateSaturdaySeptember12.
  ///
  /// In en, this message translates to:
  /// **'Sat, Sep 12, 2026'**
  String get mockDateSaturdaySeptember12;

  /// No description provided for @mockDateSaturdayAugust22.
  ///
  /// In en, this message translates to:
  /// **'Sat, Aug 22, 2026'**
  String get mockDateSaturdayAugust22;

  /// No description provided for @mockLocationParqueBicentenario.
  ///
  /// In en, this message translates to:
  /// **'Bicentennial Park, Santiago'**
  String get mockLocationParqueBicentenario;

  /// No description provided for @mockLocationTerrazaNeon.
  ///
  /// In en, this message translates to:
  /// **'Neon Rooftop, Santiago'**
  String get mockLocationTerrazaNeon;

  /// No description provided for @mockLocationClubAmandaValparaiso.
  ///
  /// In en, this message translates to:
  /// **'Club Amanda, Valparaiso'**
  String get mockLocationClubAmandaValparaiso;

  /// No description provided for @mockLocationMovistarArenaShort.
  ///
  /// In en, this message translates to:
  /// **'Movistar Arena, Santiago'**
  String get mockLocationMovistarArenaShort;

  /// No description provided for @mockTime2200Hrs.
  ///
  /// In en, this message translates to:
  /// **'10:00 PM'**
  String get mockTime2200Hrs;

  /// No description provided for @mockTime2300Hrs.
  ///
  /// In en, this message translates to:
  /// **'11:00 PM'**
  String get mockTime2300Hrs;

  /// No description provided for @mockTime2130Hrs.
  ///
  /// In en, this message translates to:
  /// **'9:30 PM'**
  String get mockTime2130Hrs;

  /// No description provided for @mockPriceFrom50000.
  ///
  /// In en, this message translates to:
  /// **'From \$50,000 CLP'**
  String get mockPriceFrom50000;

  /// No description provided for @mockLocationSkyCostanera.
  ///
  /// In en, this message translates to:
  /// **'Sky Costanera'**
  String get mockLocationSkyCostanera;

  /// No description provided for @mockLocationClubOceano.
  ///
  /// In en, this message translates to:
  /// **'Club Océano'**
  String get mockLocationClubOceano;

  /// No description provided for @mockDateSaturdayJuly4Short.
  ///
  /// In en, this message translates to:
  /// **'Sat, Jul 4, 2026'**
  String get mockDateSaturdayJuly4Short;

  /// No description provided for @mockDateFridayAugust7Short.
  ///
  /// In en, this message translates to:
  /// **'Fri, Aug 7, 2026'**
  String get mockDateFridayAugust7Short;

  /// No description provided for @mockDateSaturdaySeptember12Short.
  ///
  /// In en, this message translates to:
  /// **'Sat, Sep 12, 2026'**
  String get mockDateSaturdaySeptember12Short;

  /// No description provided for @ticketAssignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign tickets'**
  String get ticketAssignmentTitle;

  /// No description provided for @ticketAssignmentHeading.
  ///
  /// In en, this message translates to:
  /// **'Assign tickets'**
  String get ticketAssignmentHeading;

  /// No description provided for @ticketAssignmentSlotLabel.
  ///
  /// In en, this message translates to:
  /// **'Ticket {number}'**
  String ticketAssignmentSlotLabel(int number);

  /// No description provided for @ticketAssignmentSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ticket available • You can do it in parts} other{{count} tickets available • You can do it in parts}}'**
  String ticketAssignmentSummarySubtitle(int count);

  /// No description provided for @ticketAssignmentAvailableCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ticket available to assign} other{{count} tickets available to assign}}'**
  String ticketAssignmentAvailableCount(int count);

  /// No description provided for @ticketAssignmentPendingCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 pending} other{{count} pending}}'**
  String ticketAssignmentPendingCount(int count);

  /// No description provided for @ticketAssignmentClaimedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 accepted} other{{count} accepted}}'**
  String ticketAssignmentClaimedCount(int count);

  /// No description provided for @ticketAssignmentSentSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Sent invitations'**
  String get ticketAssignmentSentSectionTitle;

  /// No description provided for @ticketAssignmentSendNewSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Send new tickets'**
  String get ticketAssignmentSendNewSectionTitle;

  /// No description provided for @ticketAssignmentSendNewSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You have 1 ticket ready to assign to a new guest.} other{You have {count} tickets ready to assign to new guests.}}'**
  String ticketAssignmentSendNewSectionSubtitle(int count);

  /// No description provided for @ticketAssignmentAcceptedBadge.
  ///
  /// In en, this message translates to:
  /// **'ACCEPTED'**
  String get ticketAssignmentAcceptedBadge;

  /// No description provided for @ticketAssignmentOwnerTicket.
  ///
  /// In en, this message translates to:
  /// **'Your ticket'**
  String get ticketAssignmentOwnerTicket;

  /// No description provided for @ticketAssignmentClaimedTicket.
  ///
  /// In en, this message translates to:
  /// **'Ticket claimed'**
  String get ticketAssignmentClaimedTicket;

  /// No description provided for @ticketAssignmentPendingBadge.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get ticketAssignmentPendingBadge;

  /// No description provided for @ticketAssignmentAvailableBadge.
  ///
  /// In en, this message translates to:
  /// **'AVAILABLE'**
  String get ticketAssignmentAvailableBadge;

  /// No description provided for @ticketAssignmentGuestNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest name'**
  String get ticketAssignmentGuestNameLabel;

  /// No description provided for @ticketAssignmentGuestNameHint.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get ticketAssignmentGuestNameHint;

  /// No description provided for @ticketAssignmentGuestPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest phone'**
  String get ticketAssignmentGuestPhoneLabel;

  /// No description provided for @ticketAssignmentGuestPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone (e.g. +56 9 1234 5678)'**
  String get ticketAssignmentGuestPhoneHint;

  /// No description provided for @ticketAssignmentPickContact.
  ///
  /// In en, this message translates to:
  /// **'Search from contacts'**
  String get ticketAssignmentPickContact;

  /// No description provided for @ticketAssignmentSearchGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Find guest'**
  String get ticketAssignmentSearchGuestTitle;

  /// No description provided for @ticketAssignmentSearchGuestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search registered YouPass users by name or phone. If they are not registered, enter their details manually on the card.'**
  String get ticketAssignmentSearchGuestSubtitle;

  /// No description provided for @ticketAssignmentSearchGuestHint.
  ///
  /// In en, this message translates to:
  /// **'Name or phone number'**
  String get ticketAssignmentSearchGuestHint;

  /// No description provided for @ticketAssignmentSearchGuestEmpty.
  ///
  /// In en, this message translates to:
  /// **'No registered user found. You can type their name and phone manually, then send the WhatsApp invitation.'**
  String get ticketAssignmentSearchGuestEmpty;

  /// No description provided for @ticketAssignmentSearchGuestManualHint.
  ///
  /// In en, this message translates to:
  /// **'Close this sheet to type guest details manually on the ticket card.'**
  String get ticketAssignmentSearchGuestManualHint;

  /// No description provided for @ticketAssignmentRegisteredBadge.
  ///
  /// In en, this message translates to:
  /// **'YouPass'**
  String get ticketAssignmentRegisteredBadge;

  /// No description provided for @ticketAssignmentSendTicket.
  ///
  /// In en, this message translates to:
  /// **'Send ticket'**
  String get ticketAssignmentSendTicket;

  /// No description provided for @ticketAssignmentCancelTicket.
  ///
  /// In en, this message translates to:
  /// **'Cancel ticket'**
  String get ticketAssignmentCancelTicket;

  /// No description provided for @ticketAssignmentResendWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Resend WhatsApp'**
  String get ticketAssignmentResendWhatsApp;

  /// No description provided for @ticketAssignmentSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp opened — tap Send to deliver the invitation'**
  String get ticketAssignmentSentSuccess;

  /// No description provided for @ticketAssignmentContactsPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Contacts permission is required to pick a guest'**
  String get ticketAssignmentContactsPermissionDenied;

  /// No description provided for @ticketAssignmentMissingOrder.
  ///
  /// In en, this message translates to:
  /// **'This ticket cannot be assigned yet'**
  String get ticketAssignmentMissingOrder;

  /// No description provided for @ticketAssignmentNoAssignableTickets.
  ///
  /// In en, this message translates to:
  /// **'No tickets available to assign right now'**
  String get ticketAssignmentNoAssignableTickets;

  /// No description provided for @ticketAssignmentRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get ticketAssignmentRetry;

  /// No description provided for @ticketAssignmentWhatsAppInfo.
  ///
  /// In en, this message translates to:
  /// **'When you send the ticket, WhatsApp opens with your guest\'s number and a pre-filled message. Tap Send in WhatsApp to deliver the invitation link.'**
  String get ticketAssignmentWhatsAppInfo;

  /// No description provided for @ticketAssignmentPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Your data and your guests\' data are protected'**
  String get ticketAssignmentPrivacyNote;

  /// No description provided for @invitationClaimTitle.
  ///
  /// In en, this message translates to:
  /// **'You have a ticket invitation'**
  String get invitationClaimTitle;

  /// No description provided for @invitationClaimGuestLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get invitationClaimGuestLabel;

  /// No description provided for @invitationClaimInvitedByLabel.
  ///
  /// In en, this message translates to:
  /// **'Invited by'**
  String get invitationClaimInvitedByLabel;

  /// No description provided for @invitationClaimStepsTitle.
  ///
  /// In en, this message translates to:
  /// **'How to claim your ticket'**
  String get invitationClaimStepsTitle;

  /// No description provided for @invitationClaimOpenInvitations.
  ///
  /// In en, this message translates to:
  /// **'Open Invitations'**
  String get invitationClaimOpenInvitations;

  /// No description provided for @invitationClaimLoginRegister.
  ///
  /// In en, this message translates to:
  /// **'Log in or register'**
  String get invitationClaimLoginRegister;

  /// No description provided for @vipTicketSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy tickets'**
  String get vipTicketSelectionTitle;

  /// No description provided for @vipTicketSelectionHeading.
  ///
  /// In en, this message translates to:
  /// **'Choose your ticket'**
  String get vipTicketSelectionHeading;

  /// No description provided for @vipSectionGeneralTickets.
  ///
  /// In en, this message translates to:
  /// **'GENERAL TICKETS'**
  String get vipSectionGeneralTickets;

  /// No description provided for @vipSectionVipTables.
  ///
  /// In en, this message translates to:
  /// **'VIP TABLES'**
  String get vipSectionVipTables;

  /// No description provided for @vipSectionVipTickets.
  ///
  /// In en, this message translates to:
  /// **'VIP ADMISSION'**
  String get vipSectionVipTickets;

  /// No description provided for @vipOfferingPreventa1.
  ///
  /// In en, this message translates to:
  /// **'PRE-SALE 1'**
  String get vipOfferingPreventa1;

  /// No description provided for @vipOfferingPreventa2.
  ///
  /// In en, this message translates to:
  /// **'PRE-SALE 2'**
  String get vipOfferingPreventa2;

  /// No description provided for @vipOfferingGeneralCover.
  ///
  /// In en, this message translates to:
  /// **'GENERAL + COVER'**
  String get vipOfferingGeneralCover;

  /// No description provided for @vipOfferingVipGeneral.
  ///
  /// In en, this message translates to:
  /// **'VIP GENERAL'**
  String get vipOfferingVipGeneral;

  /// No description provided for @vipOfferingWithoutTable.
  ///
  /// In en, this message translates to:
  /// **'Without table'**
  String get vipOfferingWithoutTable;

  /// No description provided for @vipOfferingGeneralAccessDescription.
  ///
  /// In en, this message translates to:
  /// **'General event access'**
  String get vipOfferingGeneralAccessDescription;

  /// No description provided for @vipTicketCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ticket} other{{count} tickets}}'**
  String vipTicketCount(int count);

  /// No description provided for @vipTicketSelectionSummaryLine.
  ///
  /// In en, this message translates to:
  /// **'{ticketCount} • {amount}'**
  String vipTicketSelectionSummaryLine(String ticketCount, String amount);

  /// No description provided for @vipBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get vipBackButton;

  /// No description provided for @vipContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get vipContinueButton;

  /// No description provided for @vipContinueWithTickets.
  ///
  /// In en, this message translates to:
  /// **'Continue - {ticketCount}'**
  String vipContinueWithTickets(String ticketCount);

  /// No description provided for @vipContinueWithAmount.
  ///
  /// In en, this message translates to:
  /// **'Continue · {amount}'**
  String vipContinueWithAmount(String amount);

  /// No description provided for @vipTicketSoldOutBadge.
  ///
  /// In en, this message translates to:
  /// **'Sold out'**
  String get vipTicketSoldOutBadge;

  /// No description provided for @vipTicketsNoneAvailable.
  ///
  /// In en, this message translates to:
  /// **'No tickets available for this event.'**
  String get vipTicketsNoneAvailable;

  /// No description provided for @vipTicketsAllSoldOut.
  ///
  /// In en, this message translates to:
  /// **'All tickets for this event are sold out.'**
  String get vipTicketsAllSoldOut;

  /// No description provided for @errorCheckoutInsufficientStock.
  ///
  /// In en, this message translates to:
  /// **'Not enough tickets available. Lower the quantity or choose another option.'**
  String get errorCheckoutInsufficientStock;

  /// No description provided for @errorCheckoutOfferingSoldOut.
  ///
  /// In en, this message translates to:
  /// **'This ticket option just sold out. Please choose another.'**
  String get errorCheckoutOfferingSoldOut;

  /// No description provided for @errorCheckoutTableLockRequired.
  ///
  /// In en, this message translates to:
  /// **'Your table reservation expired. Please reserve the table again.'**
  String get errorCheckoutTableLockRequired;

  /// No description provided for @errorCheckoutTableNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'This table is no longer available.'**
  String get errorCheckoutTableNotAvailable;

  /// No description provided for @errorCheckoutTableLocked.
  ///
  /// In en, this message translates to:
  /// **'This table is held by another guest.'**
  String get errorCheckoutTableLocked;

  /// No description provided for @errorCheckoutOfferingNotFound.
  ///
  /// In en, this message translates to:
  /// **'This ticket option is no longer available.'**
  String get errorCheckoutOfferingNotFound;

  /// No description provided for @vipSecurePayment.
  ///
  /// In en, this message translates to:
  /// **'100% secure payment'**
  String get vipSecurePayment;

  /// No description provided for @vipOfferingGeneral.
  ///
  /// In en, this message translates to:
  /// **'GENERAL - STANDARD'**
  String get vipOfferingGeneral;

  /// No description provided for @vipMesasVipTitle.
  ///
  /// In en, this message translates to:
  /// **'VIP Tables'**
  String get vipMesasVipTitle;

  /// No description provided for @vipMesasVipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your table →'**
  String get vipMesasVipSubtitle;

  /// No description provided for @vipFloorPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Venue floor plan'**
  String get vipFloorPlanTitle;

  /// No description provided for @vipFloorPlanHeading.
  ///
  /// In en, this message translates to:
  /// **'Venue floor plan'**
  String get vipFloorPlanHeading;

  /// No description provided for @vipFloorPlanVenueName.
  ///
  /// In en, this message translates to:
  /// **'Main hall'**
  String get vipFloorPlanVenueName;

  /// No description provided for @vipFloorPlanSize.
  ///
  /// In en, this message translates to:
  /// **'36 x 18 m'**
  String get vipFloorPlanSize;

  /// No description provided for @vipFloorPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{venue} • {size}'**
  String vipFloorPlanSubtitle(String venue, String size);

  /// No description provided for @vipFloorPlanDimensions.
  ///
  /// In en, this message translates to:
  /// **'Main hall - 36 x 18 m'**
  String get vipFloorPlanDimensions;

  /// No description provided for @vipTapVipZoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Tap a VIP zone'**
  String get vipTapVipZoneTitle;

  /// No description provided for @vipTapVipZoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select a zone to see available tables'**
  String get vipTapVipZoneSubtitle;

  /// No description provided for @vipYouFestBrand.
  ///
  /// In en, this message translates to:
  /// **'YouFest'**
  String get vipYouFestBrand;

  /// No description provided for @vipLegendAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get vipLegendAvailable;

  /// No description provided for @vipLegendPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get vipLegendPremium;

  /// No description provided for @vipLegendSold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get vipLegendSold;

  /// No description provided for @vipZone1Name.
  ///
  /// In en, this message translates to:
  /// **'VIP 1'**
  String get vipZone1Name;

  /// No description provided for @vipZone2Name.
  ///
  /// In en, this message translates to:
  /// **'VIP 2'**
  String get vipZone2Name;

  /// No description provided for @vipZoneDj.
  ///
  /// In en, this message translates to:
  /// **'VIP DJ'**
  String get vipZoneDj;

  /// No description provided for @vipZoneStage.
  ///
  /// In en, this message translates to:
  /// **'DJ STAGE'**
  String get vipZoneStage;

  /// No description provided for @vipZoneDanceFloor.
  ///
  /// In en, this message translates to:
  /// **'DANCE FLOOR'**
  String get vipZoneDanceFloor;

  /// No description provided for @vipZoneLabel.
  ///
  /// In en, this message translates to:
  /// **'ZONE'**
  String get vipZoneLabel;

  /// No description provided for @vipZoneCapacity.
  ///
  /// In en, this message translates to:
  /// **'{count} spots/table'**
  String vipZoneCapacity(int count);

  /// No description provided for @vipEmergencyExit.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY EXIT'**
  String get vipEmergencyExit;

  /// No description provided for @vipLegendAvailableShort.
  ///
  /// In en, this message translates to:
  /// **'Avail'**
  String get vipLegendAvailableShort;

  /// No description provided for @vipLegendUnselected.
  ///
  /// In en, this message translates to:
  /// **'Unselected'**
  String get vipLegendUnselected;

  /// No description provided for @vipDanceFloorGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get vipDanceFloorGeneral;

  /// No description provided for @vipTableDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'{zone} DISTRIBUTION'**
  String vipTableDistributionTitle(String zone);

  /// No description provided for @vipTableDistributionStage.
  ///
  /// In en, this message translates to:
  /// **'DJ Stage'**
  String get vipTableDistributionStage;

  /// No description provided for @vipLegendTableAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get vipLegendTableAvailable;

  /// No description provided for @vipLegendTablePremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get vipLegendTablePremium;

  /// No description provided for @vipLegendTableSelection.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get vipLegendTableSelection;

  /// No description provided for @vipLegendTableSold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get vipLegendTableSold;

  /// No description provided for @vipZoneTablesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Tables {zone}'**
  String vipZoneTablesScreenTitle(String zone);

  /// No description provided for @vipTablesZoneSoldOut.
  ///
  /// In en, this message translates to:
  /// **'All tables in this zone are sold out.'**
  String get vipTablesZoneSoldOut;

  /// No description provided for @vipTablePremiumBadge.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get vipTablePremiumBadge;

  /// No description provided for @vipTablesZoneTitle.
  ///
  /// In en, this message translates to:
  /// **'VIP Tables 1'**
  String get vipTablesZoneTitle;

  /// No description provided for @vipTablesCapacitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} people per table'**
  String vipTablesCapacitySubtitle(int count);

  /// No description provided for @vipPurchaseOfferingLine.
  ///
  /// In en, this message translates to:
  /// **'{label} x{quantity}'**
  String vipPurchaseOfferingLine(String label, int quantity);

  /// No description provided for @vipTableReserve.
  ///
  /// In en, this message translates to:
  /// **'Reserve Table {table}'**
  String vipTableReserve(String table);

  /// No description provided for @vipTableDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Table {table} — {zone}'**
  String vipTableDetailTitle(String table, String zone);

  /// No description provided for @vipTableCapacity.
  ///
  /// In en, this message translates to:
  /// **'{count} guests'**
  String vipTableCapacity(int count);

  /// No description provided for @vipTableIncludes.
  ///
  /// In en, this message translates to:
  /// **'{bottles} bottles · {vouchers} vouchers'**
  String vipTableIncludes(int bottles, int vouchers);

  /// No description provided for @vipTableBottles.
  ///
  /// In en, this message translates to:
  /// **'{count} bottles'**
  String vipTableBottles(int count);

  /// No description provided for @vipTableVouchers.
  ///
  /// In en, this message translates to:
  /// **'{count} vouchers'**
  String vipTableVouchers(int count);

  /// No description provided for @vipTableIncludesShort.
  ///
  /// In en, this message translates to:
  /// **'{people} • {bottles} • {vouchers}'**
  String vipTableIncludesShort(String people, String bottles, String vouchers);

  /// No description provided for @vipPurchaseSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase summary'**
  String get vipPurchaseSummaryTitle;

  /// No description provided for @vipPurchaseSummaryItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Table {table} - {zone} | {event}'**
  String vipPurchaseSummaryItemTitle(String table, String zone, String event);

  /// No description provided for @vipServiceFee.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get vipServiceFee;

  /// No description provided for @vipPurchaseSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get vipPurchaseSubtotal;

  /// No description provided for @vipPurchaseServiceCharge.
  ///
  /// In en, this message translates to:
  /// **'Service charge'**
  String get vipPurchaseServiceCharge;

  /// No description provided for @vipGeneralAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'General access'**
  String get vipGeneralAccessLabel;

  /// No description provided for @vipVoucherCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 voucher} other{{count} vouchers}}'**
  String vipVoucherCount(int count);

  /// No description provided for @vipPurchaseTicketDetailsLine.
  ///
  /// In en, this message translates to:
  /// **'{entries} • {access} • {vouchers}'**
  String vipPurchaseTicketDetailsLine(
    String entries,
    String access,
    String vouchers,
  );

  /// No description provided for @vipPurchaseTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get vipPurchaseTotal;

  /// No description provided for @vipPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT METHOD'**
  String get vipPaymentMethod;

  /// No description provided for @vipSavedCard.
  ///
  /// In en, this message translates to:
  /// **'Visa ending in 4205'**
  String get vipSavedCard;

  /// No description provided for @vipAddPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add payment method'**
  String get vipAddPaymentMethod;

  /// No description provided for @vipPurchaseAssignTicketsInfo.
  ///
  /// In en, this message translates to:
  /// **'After payment, you can assign tickets to your guests or do it later from {myTickets}.'**
  String vipPurchaseAssignTicketsInfo(String myTickets);

  /// No description provided for @vipPayButton.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String vipPayButton(String amount);

  /// No description provided for @vipPurchaseSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase successful!'**
  String get vipPurchaseSuccessTitle;

  /// No description provided for @vipPurchaseSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your tickets are ready in My Tickets.'**
  String get vipPurchaseSuccessMessage;

  /// No description provided for @vipTableLockCountdown.
  ///
  /// In en, this message translates to:
  /// **'Complete payment in {time}'**
  String vipTableLockCountdown(String time);

  /// No description provided for @vipTableLockReservedCountdown.
  ///
  /// In en, this message translates to:
  /// **'Your table is reserved for {time}'**
  String vipTableLockReservedCountdown(String time);

  /// No description provided for @vipTableLockExpired.
  ///
  /// In en, this message translates to:
  /// **'Your table reservation expired. Please select a table again.'**
  String get vipTableLockExpired;

  /// No description provided for @vipTableLockExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Your reservation has expired'**
  String get vipTableLockExpiredTitle;

  /// No description provided for @vipTableLockExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'The table has been released. Please return to the floor plan to select again.'**
  String get vipTableLockExpiredMessage;

  /// No description provided for @vipTableLockExpiredReturnFloorPlan.
  ///
  /// In en, this message translates to:
  /// **'Return to floor plan'**
  String get vipTableLockExpiredReturnFloorPlan;

  /// No description provided for @vipTableBlockedMessage.
  ///
  /// In en, this message translates to:
  /// **'This table is being reserved. Try again in a few minutes or choose another table.'**
  String get vipTableBlockedMessage;

  /// No description provided for @vipTableBlockedReserve.
  ///
  /// In en, this message translates to:
  /// **'This table is being reserved. Try again in a few minutes or choose another table.'**
  String get vipTableBlockedReserve;

  /// No description provided for @vipLegendTableBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get vipLegendTableBlocked;

  /// No description provided for @eventDetailTicketsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Tickets are not available for this event yet.'**
  String get eventDetailTicketsUnavailable;

  /// No description provided for @vipViewQr.
  ///
  /// In en, this message translates to:
  /// **'View QR'**
  String get vipViewQr;

  /// No description provided for @waitlistJoinButton.
  ///
  /// In en, this message translates to:
  /// **'Join waiting list'**
  String get waitlistJoinButton;

  /// No description provided for @waitlistLeaveButton.
  ///
  /// In en, this message translates to:
  /// **'Leave waiting list'**
  String get waitlistLeaveButton;

  /// No description provided for @waitlistJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join waiting list'**
  String get waitlistJoinTitle;

  /// No description provided for @waitlistJoinConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm join'**
  String get waitlistJoinConfirm;

  /// No description provided for @waitlistJoinSuccess.
  ///
  /// In en, this message translates to:
  /// **'You are on the waiting list for {eventName}. We will notify you immediately if a slot opens up.'**
  String waitlistJoinSuccess(String eventName);

  /// No description provided for @waitlistEstimatedPosition.
  ///
  /// In en, this message translates to:
  /// **'You are #{position} on the waiting list'**
  String waitlistEstimatedPosition(String position);

  /// No description provided for @waitlistLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave waiting list?'**
  String get waitlistLeaveTitle;

  /// No description provided for @waitlistLeaveMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? You will lose your position in the queue.'**
  String get waitlistLeaveMessage;

  /// No description provided for @waitlistLeaveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave list'**
  String get waitlistLeaveConfirm;

  /// No description provided for @waitlistClaimSlot.
  ///
  /// In en, this message translates to:
  /// **'CLAIM MY SLOT'**
  String get waitlistClaimSlot;

  /// No description provided for @waitlistOfferBanner.
  ///
  /// In en, this message translates to:
  /// **'A slot is waiting for you! Confirm before {time}'**
  String waitlistOfferBanner(String time);

  /// No description provided for @errorStaffNotFound.
  ///
  /// In en, this message translates to:
  /// **'No staff account found for this number. Ask your admin to register you.'**
  String get errorStaffNotFound;

  /// No description provided for @errorNetworkConnection.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your connection and try again.'**
  String get errorNetworkConnection;

  /// No description provided for @staffScanQrTitle.
  ///
  /// In en, this message translates to:
  /// **'SCAN QR'**
  String get staffScanQrTitle;

  /// No description provided for @staffScanQrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to start scanning'**
  String get staffScanQrSubtitle;

  /// No description provided for @staffScanQrAreaLabel.
  ///
  /// In en, this message translates to:
  /// **'AREA QR'**
  String get staffScanQrAreaLabel;

  /// No description provided for @staffScanQrInstruction.
  ///
  /// In en, this message translates to:
  /// **'Keep the code\ninside the frame'**
  String get staffScanQrInstruction;

  /// No description provided for @staffScanFlashLabel.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get staffScanFlashLabel;

  /// No description provided for @staffScanCameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera is not available on this device.'**
  String get staffScanCameraUnavailable;

  /// No description provided for @staffScanPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required to scan QR codes.'**
  String get staffScanPermissionDenied;

  /// No description provided for @staffManualEntryButton.
  ///
  /// In en, this message translates to:
  /// **'MANUAL ENTRY'**
  String get staffManualEntryButton;

  /// No description provided for @staffRecentScansTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent scans'**
  String get staffRecentScansTitle;

  /// No description provided for @staffRecentScanActionAuthorizeConsumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption authorized'**
  String get staffRecentScanActionAuthorizeConsumption;

  /// No description provided for @staffRecentScanActionRejectConsumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption rejected'**
  String get staffRecentScanActionRejectConsumption;

  /// No description provided for @staffRecentScansEmpty.
  ///
  /// In en, this message translates to:
  /// **'No product scans yet. Scan a drink QR to see it here.'**
  String get staffRecentScansEmpty;

  /// No description provided for @staffViewAllScans.
  ///
  /// In en, this message translates to:
  /// **'View all >'**
  String get staffViewAllScans;

  /// No description provided for @staffScanDuplicateLabel.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get staffScanDuplicateLabel;

  /// No description provided for @staffConnectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get staffConnectedLabel;

  /// No description provided for @staffDisconnectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get staffDisconnectedLabel;

  /// No description provided for @staffOnlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get staffOnlineStatus;

  /// No description provided for @staffAwayStatus.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get staffAwayStatus;

  /// No description provided for @staffDrawerTitle.
  ///
  /// In en, this message translates to:
  /// **'Staff menu'**
  String get staffDrawerTitle;

  /// No description provided for @staffApiEnvironmentLabel.
  ///
  /// In en, this message translates to:
  /// **'API environment'**
  String get staffApiEnvironmentLabel;

  /// No description provided for @staffApiEnvDevLocal.
  ///
  /// In en, this message translates to:
  /// **'Dev (local)'**
  String get staffApiEnvDevLocal;

  /// No description provided for @staffApiEnvDevNgrok.
  ///
  /// In en, this message translates to:
  /// **'Dev (ngrok)'**
  String get staffApiEnvDevNgrok;

  /// No description provided for @staffApiEnvProduction.
  ///
  /// In en, this message translates to:
  /// **'Production'**
  String get staffApiEnvProduction;

  /// No description provided for @staffApiEnvCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom API'**
  String get staffApiEnvCustom;

  /// No description provided for @staffNgrokTunnelLabel.
  ///
  /// In en, this message translates to:
  /// **'Ngrok tunnel (physical device)'**
  String get staffNgrokTunnelLabel;

  /// No description provided for @staffLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get staffLanguageLabel;

  /// No description provided for @staffLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get staffLanguageEnglish;

  /// No description provided for @staffLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get staffLanguageSpanish;

  /// No description provided for @staffLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get staffLogout;

  /// No description provided for @staffSupervisorMode.
  ///
  /// In en, this message translates to:
  /// **'Supervisor mode'**
  String get staffSupervisorMode;

  /// No description provided for @staffBarSupervisorMode.
  ///
  /// In en, this message translates to:
  /// **'Bar supervisor'**
  String get staffBarSupervisorMode;

  /// No description provided for @staffTicketsSupervisorMode.
  ///
  /// In en, this message translates to:
  /// **'Tickets supervisor'**
  String get staffTicketsSupervisorMode;

  /// No description provided for @staffAccessValidatorMenu.
  ///
  /// In en, this message translates to:
  /// **'Access validator'**
  String get staffAccessValidatorMenu;

  /// No description provided for @staffSupervisorPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Supervisor access'**
  String get staffSupervisorPinTitle;

  /// No description provided for @staffSupervisorPinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN to continue and access supervisor mode.'**
  String get staffSupervisorPinSubtitle;

  /// No description provided for @staffSupervisorPinFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get staffSupervisorPinFieldLabel;

  /// No description provided for @staffSupervisorPinContinueButton.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get staffSupervisorPinContinueButton;

  /// No description provided for @staffSupervisorPinFooter.
  ///
  /// In en, this message translates to:
  /// **'Only authorized staff can access.'**
  String get staffSupervisorPinFooter;

  /// No description provided for @staffSupervisorPinInvalid.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. Try again.'**
  String get staffSupervisorPinInvalid;

  /// No description provided for @staffSupervisorPinNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Supervisor PIN has not been set up yet. Ask an administrator to generate one.'**
  String get staffSupervisorPinNotConfigured;

  /// No description provided for @staffSupervisorPinAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Your account is not authorized for supervisor mode.'**
  String get staffSupervisorPinAccessDenied;

  /// No description provided for @staffSupervisorDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'SUPERVISOR MODE'**
  String get staffSupervisorDashboardTitle;

  /// No description provided for @staffSupervisorDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced bar control'**
  String get staffSupervisorDashboardSubtitle;

  /// No description provided for @staffSupervisorCancellationsTitle.
  ///
  /// In en, this message translates to:
  /// **'CANCELLATIONS'**
  String get staffSupervisorCancellationsTitle;

  /// No description provided for @staffSupervisorCancelConsumption.
  ///
  /// In en, this message translates to:
  /// **'Cancel consumption'**
  String get staffSupervisorCancelConsumption;

  /// No description provided for @staffSupervisorRevertValidation.
  ///
  /// In en, this message translates to:
  /// **'Revert validation'**
  String get staffSupervisorRevertValidation;

  /// No description provided for @staffSupervisorReleaseBlockedQr.
  ///
  /// In en, this message translates to:
  /// **'Release blocked QR code'**
  String get staffSupervisorReleaseBlockedQr;

  /// No description provided for @staffSupervisorManualValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'MANUAL VALIDATION'**
  String get staffSupervisorManualValidationTitle;

  /// No description provided for @staffSupervisorManualValidationUser.
  ///
  /// In en, this message translates to:
  /// **'User: {userName}'**
  String staffSupervisorManualValidationUser(String userName);

  /// No description provided for @staffSupervisorManualValidationProduct.
  ///
  /// In en, this message translates to:
  /// **'Product: {productName}'**
  String staffSupervisorManualValidationProduct(String productName);

  /// No description provided for @staffSupervisorManualValidationCode.
  ///
  /// In en, this message translates to:
  /// **'Partial code: {code}'**
  String staffSupervisorManualValidationCode(String code);

  /// No description provided for @staffSupervisorQrOverrideTitle.
  ///
  /// In en, this message translates to:
  /// **'QR CODE OVERRIDE'**
  String get staffSupervisorQrOverrideTitle;

  /// No description provided for @staffSupervisorQrOverrideSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor: {supervisorName}'**
  String staffSupervisorQrOverrideSupervisor(String supervisorName);

  /// No description provided for @staffSupervisorGoButton.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get staffSupervisorGoButton;

  /// No description provided for @staffSupervisorRecentActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'RECENT ACTIONS'**
  String get staffSupervisorRecentActionsTitle;

  /// No description provided for @staffSupervisorViewAllActions.
  ///
  /// In en, this message translates to:
  /// **'View all >'**
  String get staffSupervisorViewAllActions;

  /// No description provided for @staffSupervisorActionQrReleased.
  ///
  /// In en, this message translates to:
  /// **'QR code released'**
  String get staffSupervisorActionQrReleased;

  /// No description provided for @staffSupervisorActionManualValidation.
  ///
  /// In en, this message translates to:
  /// **'Manual validation'**
  String get staffSupervisorActionManualValidation;

  /// No description provided for @staffSupervisorActionConsumptionCancelled.
  ///
  /// In en, this message translates to:
  /// **'Consumption cancelled'**
  String get staffSupervisorActionConsumptionCancelled;

  /// No description provided for @staffSupervisorComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get staffSupervisorComingSoon;

  /// No description provided for @staffSupervisorCancellationsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancellations'**
  String get staffSupervisorCancellationsScreenTitle;

  /// No description provided for @staffSupervisorCancellationsScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Supervisor · YouPass'**
  String get staffSupervisorCancellationsScreenSubtitle;

  /// No description provided for @staffSupervisorSearchConsumptionTitle.
  ///
  /// In en, this message translates to:
  /// **'SEARCH CONSUMPTION'**
  String get staffSupervisorSearchConsumptionTitle;

  /// No description provided for @staffSupervisorSearchConsumptionHeading.
  ///
  /// In en, this message translates to:
  /// **'Search consumption'**
  String get staffSupervisorSearchConsumptionHeading;

  /// No description provided for @staffSupervisorSearchDrinkNoResults.
  ///
  /// In en, this message translates to:
  /// **'No consumptions found for this search.'**
  String get staffSupervisorSearchDrinkNoResults;

  /// No description provided for @staffSupervisorSearchDrinkSearchError.
  ///
  /// In en, this message translates to:
  /// **'Could not search consumptions. Try again.'**
  String get staffSupervisorSearchDrinkSearchError;

  /// No description provided for @staffSupervisorSearchDrinkResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result found} other{{count} results found}}'**
  String staffSupervisorSearchDrinkResultsCount(int count);

  /// No description provided for @staffSupervisorSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'QR / user / product'**
  String get staffSupervisorSearchPlaceholder;

  /// No description provided for @staffSupervisorSearchButton.
  ///
  /// In en, this message translates to:
  /// **'SEARCH'**
  String get staffSupervisorSearchButton;

  /// No description provided for @staffSupervisorConsumptionFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'CONSUMPTION FOUND'**
  String get staffSupervisorConsumptionFoundTitle;

  /// No description provided for @staffSupervisorConsumptionUserLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get staffSupervisorConsumptionUserLabel;

  /// No description provided for @staffSupervisorConsumptionProductLabel.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get staffSupervisorConsumptionProductLabel;

  /// No description provided for @staffSupervisorConsumptionBarLabel.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get staffSupervisorConsumptionBarLabel;

  /// No description provided for @staffSupervisorConsumptionTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Validation time'**
  String get staffSupervisorConsumptionTimeLabel;

  /// No description provided for @staffSupervisorConsumptionIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Consumption ID'**
  String get staffSupervisorConsumptionIdLabel;

  /// No description provided for @staffSupervisorConsumptionStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get staffSupervisorConsumptionStatusLabel;

  /// No description provided for @staffSupervisorConsumptionStatusValidated.
  ///
  /// In en, this message translates to:
  /// **'VALIDATED'**
  String get staffSupervisorConsumptionStatusValidated;

  /// No description provided for @staffSupervisorActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIONS'**
  String get staffSupervisorActionsTitle;

  /// No description provided for @staffSupervisorReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'MANDATORY REASON'**
  String get staffSupervisorReasonTitle;

  /// No description provided for @staffSupervisorReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write the reason for the cancellation...'**
  String get staffSupervisorReasonPlaceholder;

  /// No description provided for @staffSupervisorReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Example: \'Wrong product delivered\''**
  String get staffSupervisorReasonHint;

  /// No description provided for @staffSupervisorAuthorizationTitle.
  ///
  /// In en, this message translates to:
  /// **'AUTHORIZATION'**
  String get staffSupervisorAuthorizationTitle;

  /// No description provided for @staffSupervisorAuthorizationSupervisorLabel.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get staffSupervisorAuthorizationSupervisorLabel;

  /// No description provided for @staffSupervisorAuthorizationPinLabel.
  ///
  /// In en, this message translates to:
  /// **'Supervisor PIN'**
  String get staffSupervisorAuthorizationPinLabel;

  /// No description provided for @staffSupervisorHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get staffSupervisorHistoryTitle;

  /// No description provided for @staffSupervisorHistoryValidated.
  ///
  /// In en, this message translates to:
  /// **'Validated — {time}'**
  String staffSupervisorHistoryValidated(String time);

  /// No description provided for @staffSupervisorHistoryPending.
  ///
  /// In en, this message translates to:
  /// **'Supervisor pending'**
  String get staffSupervisorHistoryPending;

  /// No description provided for @staffSupervisorExecuteCancellationButton.
  ///
  /// In en, this message translates to:
  /// **'EXECUTE CANCELLATION'**
  String get staffSupervisorExecuteCancellationButton;

  /// No description provided for @staffSupervisorCancellationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Cancellation recorded successfully.'**
  String get staffSupervisorCancellationSuccess;

  /// No description provided for @staffSupervisorManualValidationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual validation'**
  String get staffSupervisorManualValidationScreenTitle;

  /// No description provided for @staffSupervisorNoQrBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'CONSUMPTION WITHOUT QR'**
  String get staffSupervisorNoQrBannerTitle;

  /// No description provided for @staffSupervisorNoQrBannerBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the purchase QR code to validate manually.'**
  String get staffSupervisorNoQrBannerBody;

  /// No description provided for @staffSupervisorEnterQrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'ENTER QR CODE (PRIMARY OPTION)'**
  String get staffSupervisorEnterQrCodeTitle;

  /// No description provided for @staffSupervisorEnterQrCodePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter the QR code'**
  String get staffSupervisorEnterQrCodePlaceholder;

  /// No description provided for @staffSupervisorSearchQrCodeButton.
  ///
  /// In en, this message translates to:
  /// **'SEARCH CODE'**
  String get staffSupervisorSearchQrCodeButton;

  /// No description provided for @staffSupervisorOrDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get staffSupervisorOrDivider;

  /// No description provided for @staffSupervisorSearchUserHeading.
  ///
  /// In en, this message translates to:
  /// **'Search user'**
  String get staffSupervisorSearchUserHeading;

  /// No description provided for @staffSupervisorSearchUserPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Name / phone'**
  String get staffSupervisorSearchUserPlaceholder;

  /// No description provided for @staffSupervisorSearchSystemButton.
  ///
  /// In en, this message translates to:
  /// **'SEARCH SYSTEM'**
  String get staffSupervisorSearchSystemButton;

  /// No description provided for @staffSupervisorResultFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'RESULT FOUND'**
  String get staffSupervisorResultFoundTitle;

  /// No description provided for @staffSupervisorResultEventLabel.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get staffSupervisorResultEventLabel;

  /// No description provided for @staffSupervisorResultPurchaseLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get staffSupervisorResultPurchaseLabel;

  /// No description provided for @staffSupervisorQrStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'QR status'**
  String get staffSupervisorQrStatusLabel;

  /// No description provided for @staffSupervisorQrStatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'QR UNAVAILABLE'**
  String get staffSupervisorQrStatusUnavailable;

  /// No description provided for @staffSupervisorValidationReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'VALIDATION REASON'**
  String get staffSupervisorValidationReasonTitle;

  /// No description provided for @staffSupervisorReasonPhoneBattery.
  ///
  /// In en, this message translates to:
  /// **'Phone out of battery'**
  String get staffSupervisorReasonPhoneBattery;

  /// No description provided for @staffSupervisorReasonNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get staffSupervisorReasonNoConnection;

  /// No description provided for @staffSupervisorReasonDamagedQr.
  ///
  /// In en, this message translates to:
  /// **'Damaged QR'**
  String get staffSupervisorReasonDamagedQr;

  /// No description provided for @staffSupervisorReasonBrokenScreen.
  ///
  /// In en, this message translates to:
  /// **'Broken screen'**
  String get staffSupervisorReasonBrokenScreen;

  /// No description provided for @staffSupervisorReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get staffSupervisorReasonOther;

  /// No description provided for @staffSupervisorIdentityValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'IDENTITY VALIDATION'**
  String get staffSupervisorIdentityValidationTitle;

  /// No description provided for @staffSupervisorIdentityFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get staffSupervisorIdentityFullNameLabel;

  /// No description provided for @staffSupervisorIdentityLastDigitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Last 4 digits'**
  String get staffSupervisorIdentityLastDigitsLabel;

  /// No description provided for @staffSupervisorIdentityDocumentLabel.
  ///
  /// In en, this message translates to:
  /// **'Document validated'**
  String get staffSupervisorIdentityDocumentLabel;

  /// No description provided for @staffSupervisorIdentityConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get staffSupervisorIdentityConfirmed;

  /// No description provided for @staffSupervisorAuthorizeConsumptionButton.
  ///
  /// In en, this message translates to:
  /// **'AUTHORIZE CONSUMPTION'**
  String get staffSupervisorAuthorizeConsumptionButton;

  /// No description provided for @staffSupervisorGenerateTemporaryQrButton.
  ///
  /// In en, this message translates to:
  /// **'GENERATE TEMPORARY QR'**
  String get staffSupervisorGenerateTemporaryQrButton;

  /// No description provided for @staffSupervisorRejectButton.
  ///
  /// In en, this message translates to:
  /// **'REJECT'**
  String get staffSupervisorRejectButton;

  /// No description provided for @staffSupervisorValidationReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write the reason for the validation...'**
  String get staffSupervisorValidationReasonPlaceholder;

  /// No description provided for @staffSupervisorSystemRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM RECORD'**
  String get staffSupervisorSystemRecordTitle;

  /// No description provided for @staffSupervisorSystemRecordSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor: {name}'**
  String staffSupervisorSystemRecordSupervisor(String name);

  /// No description provided for @staffSupervisorSystemRecordTime.
  ///
  /// In en, this message translates to:
  /// **'Time: {time}'**
  String staffSupervisorSystemRecordTime(String time);

  /// No description provided for @staffSupervisorSystemRecordStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get staffSupervisorSystemRecordStatus;

  /// No description provided for @staffSupervisorSystemRecordStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get staffSupervisorSystemRecordStatusPending;

  /// No description provided for @staffSupervisorQrOverrideScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'QR code override'**
  String get staffSupervisorQrOverrideScreenTitle;

  /// No description provided for @staffSupervisorOverrideCriticalTitle.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL ACTION'**
  String get staffSupervisorOverrideCriticalTitle;

  /// No description provided for @staffSupervisorOverrideCriticalBody.
  ///
  /// In en, this message translates to:
  /// **'This tool modifies the QR status in the system.'**
  String get staffSupervisorOverrideCriticalBody;

  /// No description provided for @staffSupervisorOverrideSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'SEARCH QR / USER'**
  String get staffSupervisorOverrideSearchTitle;

  /// No description provided for @staffSupervisorOverrideSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'QR / name / purchase ID'**
  String get staffSupervisorOverrideSearchPlaceholder;

  /// No description provided for @staffSupervisorOverrideActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'OVERRIDE ACTIONS'**
  String get staffSupervisorOverrideActionsTitle;

  /// No description provided for @staffSupervisorOverrideReleaseQr.
  ///
  /// In en, this message translates to:
  /// **'Release QR'**
  String get staffSupervisorOverrideReleaseQr;

  /// No description provided for @staffSupervisorOverrideRevalidateQr.
  ///
  /// In en, this message translates to:
  /// **'Revalidate QR'**
  String get staffSupervisorOverrideRevalidateQr;

  /// No description provided for @staffSupervisorOverrideAuthorizeReconsumption.
  ///
  /// In en, this message translates to:
  /// **'Authorize re-consumption'**
  String get staffSupervisorOverrideAuthorizeReconsumption;

  /// No description provided for @staffSupervisorOverrideTemporaryUnlock.
  ///
  /// In en, this message translates to:
  /// **'Temporary unlock'**
  String get staffSupervisorOverrideTemporaryUnlock;

  /// No description provided for @staffSupervisorOverrideReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write the reason for the override...'**
  String get staffSupervisorOverrideReasonPlaceholder;

  /// No description provided for @staffSupervisorOverrideReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Example: \'QR marked incorrectly\''**
  String get staffSupervisorOverrideReasonHint;

  /// No description provided for @staffSupervisorOverrideQrIdLabel.
  ///
  /// In en, this message translates to:
  /// **'QR ID'**
  String get staffSupervisorOverrideQrIdLabel;

  /// No description provided for @staffSupervisorOverrideCurrentStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Current status'**
  String get staffSupervisorOverrideCurrentStatusLabel;

  /// No description provided for @staffSupervisorOverrideStatusBlocked.
  ///
  /// In en, this message translates to:
  /// **'BLOCKED'**
  String get staffSupervisorOverrideStatusBlocked;

  /// No description provided for @staffSupervisorOverrideLastUseLabel.
  ///
  /// In en, this message translates to:
  /// **'Last use'**
  String get staffSupervisorOverrideLastUseLabel;

  /// No description provided for @staffSupervisorOverrideScannerLabel.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get staffSupervisorOverrideScannerLabel;

  /// No description provided for @staffSupervisorOverrideAuthLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Authorization level:'**
  String get staffSupervisorOverrideAuthLevelLabel;

  /// No description provided for @staffSupervisorOverrideAuthLevelHigh.
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get staffSupervisorOverrideAuthLevelHigh;

  /// No description provided for @staffSupervisorOverrideExpectedResultTitle.
  ///
  /// In en, this message translates to:
  /// **'EXPECTED RESULT'**
  String get staffSupervisorOverrideExpectedResultTitle;

  /// No description provided for @staffSupervisorOverrideExpectedStatusPrefix.
  ///
  /// In en, this message translates to:
  /// **'QR status →'**
  String get staffSupervisorOverrideExpectedStatusPrefix;

  /// No description provided for @staffSupervisorOverrideExpectedStatus.
  ///
  /// In en, this message translates to:
  /// **'QR status → VALID'**
  String get staffSupervisorOverrideExpectedStatus;

  /// No description provided for @staffSupervisorOverrideExpectedSubtext.
  ///
  /// In en, this message translates to:
  /// **'New consumption allowed.'**
  String get staffSupervisorOverrideExpectedSubtext;

  /// No description provided for @staffSupervisorOverrideLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'QR LOGS'**
  String get staffSupervisorOverrideLogsTitle;

  /// No description provided for @staffSupervisorOverrideLogsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No QR activity recorded yet.'**
  String get staffSupervisorOverrideLogsEmpty;

  /// No description provided for @staffSupervisorOverrideLogQrBlocked.
  ///
  /// In en, this message translates to:
  /// **'QR blocked'**
  String get staffSupervisorOverrideLogQrBlocked;

  /// No description provided for @staffSupervisorOverrideLogPending.
  ///
  /// In en, this message translates to:
  /// **'Override pending'**
  String get staffSupervisorOverrideLogPending;

  /// No description provided for @staffSupervisorExecuteOverrideButton.
  ///
  /// In en, this message translates to:
  /// **'EXECUTE OVERRIDE'**
  String get staffSupervisorExecuteOverrideButton;

  /// No description provided for @staffSupervisorAccessDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Access advanced tools to manage entry and resolve contingencies.'**
  String get staffSupervisorAccessDashboardSubtitle;

  /// No description provided for @staffSupervisorSearchEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Search entry'**
  String get staffSupervisorSearchEntryTitle;

  /// No description provided for @staffSupervisorSearchEntryDescription.
  ///
  /// In en, this message translates to:
  /// **'Search and review entry status by name, code, phone, and more.'**
  String get staffSupervisorSearchEntryDescription;

  /// No description provided for @staffSupervisorResolveDuplicateTitle.
  ///
  /// In en, this message translates to:
  /// **'Resolve duplicate'**
  String get staffSupervisorResolveDuplicateTitle;

  /// No description provided for @staffSupervisorResolveDuplicateDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage duplicate entries or unauthorized uses.'**
  String get staffSupervisorResolveDuplicateDescription;

  /// No description provided for @staffSupervisorEntryOverrideDescription.
  ///
  /// In en, this message translates to:
  /// **'Authorize, release, or manually revalidate an entry.'**
  String get staffSupervisorEntryOverrideDescription;

  /// No description provided for @staffSupervisorEntryAuthorizationTitle.
  ///
  /// In en, this message translates to:
  /// **'SUPERVISOR AUTHORIZATION'**
  String get staffSupervisorEntryAuthorizationTitle;

  /// No description provided for @staffSupervisorEntryAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get staffSupervisorEntryAccessLabel;

  /// No description provided for @staffSupervisorEntryOverrideCriticalBody.
  ///
  /// In en, this message translates to:
  /// **'This tool directly modifies the QR status within the system.'**
  String get staffSupervisorEntryOverrideCriticalBody;

  /// No description provided for @staffSupervisorEntryOverrideReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Describe the reason for the override'**
  String get staffSupervisorEntryOverrideReasonPlaceholder;

  /// No description provided for @staffSupervisorEntryOverrideReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Example: \'QR marked as used accidentally\''**
  String get staffSupervisorEntryOverrideReasonHint;

  /// No description provided for @staffSupervisorOverrideAuthorizeReentry.
  ///
  /// In en, this message translates to:
  /// **'Authorize re-entry'**
  String get staffSupervisorOverrideAuthorizeReentry;

  /// No description provided for @staffSupervisorEntryOverrideExpectedValid.
  ///
  /// In en, this message translates to:
  /// **'VALID'**
  String get staffSupervisorEntryOverrideExpectedValid;

  /// No description provided for @staffSupervisorEntryOverrideExpectedSubtext.
  ///
  /// In en, this message translates to:
  /// **'Re-entry allowed'**
  String get staffSupervisorEntryOverrideExpectedSubtext;

  /// No description provided for @staffSupervisorEntryManualValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual validation'**
  String get staffSupervisorEntryManualValidationTitle;

  /// No description provided for @staffSupervisorEntryManualValidationDescription.
  ///
  /// In en, this message translates to:
  /// **'Validate access manually when no QR is available.'**
  String get staffSupervisorEntryManualValidationDescription;

  /// No description provided for @staffSupervisorEntryNoQrBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'NO QR ACCESS'**
  String get staffSupervisorEntryNoQrBannerTitle;

  /// No description provided for @staffSupervisorEntryNoQrBannerBody.
  ///
  /// In en, this message translates to:
  /// **'Use this option only in justified cases'**
  String get staffSupervisorEntryNoQrBannerBody;

  /// No description provided for @staffSupervisorEntryManualSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Name / phone / email'**
  String get staffSupervisorEntryManualSearchPlaceholder;

  /// No description provided for @staffSupervisorEntryManualReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual access reason'**
  String get staffSupervisorEntryManualReasonTitle;

  /// No description provided for @staffSupervisorEntryManualReasonOtherPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Specify the reason'**
  String get staffSupervisorEntryManualReasonOtherPlaceholder;

  /// No description provided for @staffSupervisorEntryManualIdentityPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Last 4 phone digits'**
  String get staffSupervisorEntryManualIdentityPhoneLabel;

  /// No description provided for @staffSupervisorEntryManualAuthorizeEntry.
  ///
  /// In en, this message translates to:
  /// **'AUTHORIZE ENTRY'**
  String get staffSupervisorEntryManualAuthorizeEntry;

  /// No description provided for @staffSupervisorEntryManualRejectAccess.
  ///
  /// In en, this message translates to:
  /// **'REJECT ACCESS'**
  String get staffSupervisorEntryManualRejectAccess;

  /// No description provided for @staffSupervisorEntryManualReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Describe the reason for manual access'**
  String get staffSupervisorEntryManualReasonPlaceholder;

  /// No description provided for @staffSupervisorEntryManualSystemStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get staffSupervisorEntryManualSystemStatusLabel;

  /// No description provided for @staffSupervisorEntryManualSystemStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending authorization'**
  String get staffSupervisorEntryManualSystemStatusPending;

  /// No description provided for @staffSupervisorEntryManualValidationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Manual validation applied successfully.'**
  String get staffSupervisorEntryManualValidationSuccess;

  /// No description provided for @staffSupervisorTemporaryQrDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Temporary QR generated'**
  String get staffSupervisorTemporaryQrDialogTitle;

  /// No description provided for @staffSupervisorTemporaryQrDialogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show this QR at the door. Valid for {minutes} minutes.'**
  String staffSupervisorTemporaryQrDialogSubtitle(int minutes);

  /// No description provided for @staffSupervisorTemporaryQrDialogGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest: {guestName}'**
  String staffSupervisorTemporaryQrDialogGuest(String guestName);

  /// No description provided for @staffSupervisorTemporaryQrDialogClose.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get staffSupervisorTemporaryQrDialogClose;

  /// No description provided for @staffSupervisorTemporaryQrGeneratedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Temporary QR ready to display.'**
  String get staffSupervisorTemporaryQrGeneratedSuccess;

  /// No description provided for @staffSupervisorVipManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'VIP management'**
  String get staffSupervisorVipManagementTitle;

  /// No description provided for @staffSupervisorVipManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Review and authorize special access for VIP guests.'**
  String get staffSupervisorVipManagementDescription;

  /// No description provided for @staffSupervisorVipSearchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search table / user (e.g. Table 12 / Daniel Rojas)'**
  String get staffSupervisorVipSearchPlaceholder;

  /// No description provided for @staffSupervisorVipSearchSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'SEARCH VIP TABLE'**
  String get staffSupervisorVipSearchSectionTitle;

  /// No description provided for @staffSupervisorVipSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No VIP tables found for this search.'**
  String get staffSupervisorVipSearchNoResults;

  /// No description provided for @staffSupervisorVipSearchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 table found} other{{count} tables found}}'**
  String staffSupervisorVipSearchResultsCount(int count);

  /// No description provided for @staffSupervisorVipStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get staffSupervisorVipStatusLabel;

  /// No description provided for @staffSupervisorVipStatusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get staffSupervisorVipStatusActive;

  /// No description provided for @staffSupervisorVipCapacityLabel.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get staffSupervisorVipCapacityLabel;

  /// No description provided for @staffSupervisorVipCapacityPeople.
  ///
  /// In en, this message translates to:
  /// **'{count} people'**
  String staffSupervisorVipCapacityPeople(int count);

  /// No description provided for @staffSupervisorVipEnteredLabel.
  ///
  /// In en, this message translates to:
  /// **'Entered'**
  String get staffSupervisorVipEnteredLabel;

  /// No description provided for @staffSupervisorVipPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get staffSupervisorVipPendingLabel;

  /// No description provided for @staffSupervisorVipPurchaseResponsibleLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase owner:'**
  String get staffSupervisorVipPurchaseResponsibleLabel;

  /// No description provided for @staffSupervisorVipGuestsTitle.
  ///
  /// In en, this message translates to:
  /// **'GUESTS'**
  String get staffSupervisorVipGuestsTitle;

  /// No description provided for @staffSupervisorVipGuestEntered.
  ///
  /// In en, this message translates to:
  /// **'Entered - {time}'**
  String staffSupervisorVipGuestEntered(String time);

  /// No description provided for @staffSupervisorVipGuestPending.
  ///
  /// In en, this message translates to:
  /// **'Entry pending'**
  String get staffSupervisorVipGuestPending;

  /// No description provided for @staffSupervisorVipActionAuthorizeExtra.
  ///
  /// In en, this message translates to:
  /// **'Authorize extra guest'**
  String get staffSupervisorVipActionAuthorizeExtra;

  /// No description provided for @staffSupervisorVipActionChangeAccess.
  ///
  /// In en, this message translates to:
  /// **'Change VIP access'**
  String get staffSupervisorVipActionChangeAccess;

  /// No description provided for @staffSupervisorVipActionMoveGuest.
  ///
  /// In en, this message translates to:
  /// **'Move guest'**
  String get staffSupervisorVipActionMoveGuest;

  /// No description provided for @staffSupervisorVipActionReleaseInvitation.
  ///
  /// In en, this message translates to:
  /// **'Release invitation'**
  String get staffSupervisorVipActionReleaseInvitation;

  /// No description provided for @staffSupervisorVipNewExtraGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'NEW EXTRA GUEST'**
  String get staffSupervisorVipNewExtraGuestTitle;

  /// No description provided for @staffSupervisorVipGuestNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get staffSupervisorVipGuestNameLabel;

  /// No description provided for @staffSupervisorVipGuestNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get staffSupervisorVipGuestNamePlaceholder;

  /// No description provided for @staffSupervisorVipGuestPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get staffSupervisorVipGuestPhoneLabel;

  /// No description provided for @staffSupervisorVipGuestPhonePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'E.g. +56 9 1234 5678'**
  String get staffSupervisorVipGuestPhonePlaceholder;

  /// No description provided for @staffSupervisorVipAuthorizationReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Authorization reason'**
  String get staffSupervisorVipAuthorizationReasonLabel;

  /// No description provided for @staffSupervisorVipAuthorizationReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Describe the reason for authorization'**
  String get staffSupervisorVipAuthorizationReasonPlaceholder;

  /// No description provided for @staffSupervisorVipHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'VIP HISTORY'**
  String get staffSupervisorVipHistoryTitle;

  /// No description provided for @staffSupervisorVipHistorySupervisorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get staffSupervisorVipHistorySupervisorPrefix;

  /// No description provided for @staffSupervisorVipHistoryExtraGuest.
  ///
  /// In en, this message translates to:
  /// **'Extra guest authorized'**
  String get staffSupervisorVipHistoryExtraGuest;

  /// No description provided for @staffSupervisorVipHistoryQrReleased.
  ///
  /// In en, this message translates to:
  /// **'VIP QR released'**
  String get staffSupervisorVipHistoryQrReleased;

  /// No description provided for @staffSupervisorVipHistoryTableModified.
  ///
  /// In en, this message translates to:
  /// **'Table modified'**
  String get staffSupervisorVipHistoryTableModified;

  /// No description provided for @staffSupervisorVipSearchResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'MATCHING TABLES'**
  String get staffSupervisorVipSearchResultsTitle;

  /// No description provided for @staffSupervisorVipActionSuccess.
  ///
  /// In en, this message translates to:
  /// **'VIP action applied successfully.'**
  String get staffSupervisorVipActionSuccess;

  /// No description provided for @staffSupervisorVipSelectGuestRelease.
  ///
  /// In en, this message translates to:
  /// **'Tap a guest to release their invitation QR.'**
  String get staffSupervisorVipSelectGuestRelease;

  /// No description provided for @staffSupervisorVipSelectGuestChangeAccess.
  ///
  /// In en, this message translates to:
  /// **'Tap a guest to change their VIP access level.'**
  String get staffSupervisorVipSelectGuestChangeAccess;

  /// No description provided for @staffSupervisorVipSelectGuestMove.
  ///
  /// In en, this message translates to:
  /// **'Tap a guest to move them to another seat.'**
  String get staffSupervisorVipSelectGuestMove;

  /// No description provided for @staffSupervisorVipSelectAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'NEW ACCESS LEVEL'**
  String get staffSupervisorVipSelectAccessTitle;

  /// No description provided for @staffSupervisorVipSelectDestinationTitle.
  ///
  /// In en, this message translates to:
  /// **'DESTINATION SEAT'**
  String get staffSupervisorVipSelectDestinationTitle;

  /// No description provided for @staffSupervisorVipNoAvailableSeats.
  ///
  /// In en, this message translates to:
  /// **'No empty seats available on this table.'**
  String get staffSupervisorVipNoAvailableSeats;

  /// No description provided for @staffSupervisorVipReleaseInvitationHint.
  ///
  /// In en, this message translates to:
  /// **'This unlocks the guest QR immediately without removing them from the table.'**
  String get staffSupervisorVipReleaseInvitationHint;

  /// No description provided for @staffSupervisorSystemStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'System status'**
  String get staffSupervisorSystemStatusTitle;

  /// No description provided for @staffSupervisorSystemStatusDescription.
  ///
  /// In en, this message translates to:
  /// **'Review connectivity, sync, and validator status.'**
  String get staffSupervisorSystemStatusDescription;

  /// No description provided for @staffSupervisorSystemGeneralStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'GENERAL STATUS'**
  String get staffSupervisorSystemGeneralStatusTitle;

  /// No description provided for @staffSupervisorSystemHealthSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get staffSupervisorSystemHealthSystem;

  /// No description provided for @staffSupervisorSystemHealthSync.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get staffSupervisorSystemHealthSync;

  /// No description provided for @staffSupervisorSystemHealthDatabase.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get staffSupervisorSystemHealthDatabase;

  /// No description provided for @staffSupervisorSystemHealthOfflineMode.
  ///
  /// In en, this message translates to:
  /// **'Offline mode'**
  String get staffSupervisorSystemHealthOfflineMode;

  /// No description provided for @staffSupervisorSystemStatusOnline.
  ///
  /// In en, this message translates to:
  /// **'ONLINE'**
  String get staffSupervisorSystemStatusOnline;

  /// No description provided for @staffSupervisorSystemStatusSlowSync.
  ///
  /// In en, this message translates to:
  /// **'SLOW'**
  String get staffSupervisorSystemStatusSlowSync;

  /// No description provided for @staffSupervisorSystemStatusSlowScanner.
  ///
  /// In en, this message translates to:
  /// **'SLOW'**
  String get staffSupervisorSystemStatusSlowScanner;

  /// No description provided for @staffSupervisorSystemStatusOperational.
  ///
  /// In en, this message translates to:
  /// **'OPERATIONAL'**
  String get staffSupervisorSystemStatusOperational;

  /// No description provided for @staffSupervisorSystemStatusDisabled.
  ///
  /// In en, this message translates to:
  /// **'DISABLED'**
  String get staffSupervisorSystemStatusDisabled;

  /// No description provided for @staffSupervisorSystemStatusDisconnected.
  ///
  /// In en, this message translates to:
  /// **'DISCONNECTED'**
  String get staffSupervisorSystemStatusDisconnected;

  /// No description provided for @staffSupervisorSystemActiveScannersTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE SCANNERS'**
  String get staffSupervisorSystemActiveScannersTitle;

  /// No description provided for @staffSupervisorSystemRestartScannerButton.
  ///
  /// In en, this message translates to:
  /// **'RESTART SCANNER'**
  String get staffSupervisorSystemRestartScannerButton;

  /// No description provided for @staffSupervisorSystemActiveAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE ALERTS'**
  String get staffSupervisorSystemActiveAlertsTitle;

  /// No description provided for @staffSupervisorSystemAlertDuplicateQr.
  ///
  /// In en, this message translates to:
  /// **'Duplicate QRs detected'**
  String get staffSupervisorSystemAlertDuplicateQr;

  /// No description provided for @staffSupervisorSystemAlertVipQueue.
  ///
  /// In en, this message translates to:
  /// **'Saturated VIP access queue'**
  String get staffSupervisorSystemAlertVipQueue;

  /// No description provided for @staffSupervisorSystemAlertScannerSlow.
  ///
  /// In en, this message translates to:
  /// **'Scanner VIP-01 slow'**
  String get staffSupervisorSystemAlertScannerSlow;

  /// No description provided for @staffSupervisorSystemEventFlowTitle.
  ///
  /// In en, this message translates to:
  /// **'EVENT FLOW'**
  String get staffSupervisorSystemEventFlowTitle;

  /// No description provided for @staffSupervisorSystemEventFlowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Entries in the last 5 min'**
  String get staffSupervisorSystemEventFlowSubtitle;

  /// No description provided for @staffSupervisorSystemFlowGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get staffSupervisorSystemFlowGeneral;

  /// No description provided for @staffSupervisorSystemFlowVip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get staffSupervisorSystemFlowVip;

  /// No description provided for @staffSupervisorSystemFlowBackstage.
  ///
  /// In en, this message translates to:
  /// **'Backstage'**
  String get staffSupervisorSystemFlowBackstage;

  /// No description provided for @staffSupervisorSystemFlowRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get staffSupervisorSystemFlowRejected;

  /// No description provided for @staffSupervisorSystemFlowDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Duplicates'**
  String get staffSupervisorSystemFlowDuplicates;

  /// No description provided for @staffSupervisorSystemQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'QUICK ACTIONS'**
  String get staffSupervisorSystemQuickActionsTitle;

  /// No description provided for @staffSupervisorSystemActionOfflineMode.
  ///
  /// In en, this message translates to:
  /// **'ACTIVATE OFFLINE MODE'**
  String get staffSupervisorSystemActionOfflineMode;

  /// No description provided for @staffSupervisorSystemActionPauseValidations.
  ///
  /// In en, this message translates to:
  /// **'PAUSE VALIDATIONS'**
  String get staffSupervisorSystemActionPauseValidations;

  /// No description provided for @staffSupervisorSystemActionManualAccess.
  ///
  /// In en, this message translates to:
  /// **'OPEN MANUAL ACCESS'**
  String get staffSupervisorSystemActionManualAccess;

  /// No description provided for @staffSupervisorSystemActionBlockVip.
  ///
  /// In en, this message translates to:
  /// **'BLOCK VIP ACCESS'**
  String get staffSupervisorSystemActionBlockVip;

  /// No description provided for @staffSupervisorSystemActionStaffAlert.
  ///
  /// In en, this message translates to:
  /// **'SEND STAFF ALERT'**
  String get staffSupervisorSystemActionStaffAlert;

  /// No description provided for @staffSupervisorSystemOperationalSemaphoreTitle.
  ///
  /// In en, this message translates to:
  /// **'OPERATIONAL SEMAPHORE'**
  String get staffSupervisorSystemOperationalSemaphoreTitle;

  /// No description provided for @staffSupervisorSystemRiskModerate.
  ///
  /// In en, this message translates to:
  /// **'MODERATE RISK'**
  String get staffSupervisorSystemRiskModerate;

  /// No description provided for @staffSupervisorSystemRiskReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason: '**
  String get staffSupervisorSystemRiskReasonLabel;

  /// No description provided for @staffSupervisorSystemRiskReasonVipFlow.
  ///
  /// In en, this message translates to:
  /// **'High VIP access flow'**
  String get staffSupervisorSystemRiskReasonVipFlow;

  /// No description provided for @staffSupervisorSystemRecentLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'RECENT LOGS'**
  String get staffSupervisorSystemRecentLogsTitle;

  /// No description provided for @staffSupervisorSystemLogOfflineActivated.
  ///
  /// In en, this message translates to:
  /// **'Offline mode activated'**
  String get staffSupervisorSystemLogOfflineActivated;

  /// No description provided for @staffSupervisorSystemLogOverrideAuthorized.
  ///
  /// In en, this message translates to:
  /// **'Override authorized'**
  String get staffSupervisorSystemLogOverrideAuthorized;

  /// No description provided for @staffSupervisorSystemLogScannerRestarted.
  ///
  /// In en, this message translates to:
  /// **'VIP scanner restarted'**
  String get staffSupervisorSystemLogScannerRestarted;

  /// No description provided for @staffSupervisorSystemLogDuplicateDetected.
  ///
  /// In en, this message translates to:
  /// **'Duplicate QR detected'**
  String get staffSupervisorSystemLogDuplicateDetected;

  /// No description provided for @staffSupervisorSystemLogOfflineDeactivated.
  ///
  /// In en, this message translates to:
  /// **'Offline mode deactivated'**
  String get staffSupervisorSystemLogOfflineDeactivated;

  /// No description provided for @staffSupervisorSystemLogValidationsPaused.
  ///
  /// In en, this message translates to:
  /// **'Validations paused'**
  String get staffSupervisorSystemLogValidationsPaused;

  /// No description provided for @staffSupervisorSystemLogValidationsResumed.
  ///
  /// In en, this message translates to:
  /// **'Validations resumed'**
  String get staffSupervisorSystemLogValidationsResumed;

  /// No description provided for @staffSupervisorSystemLogVipBlocked.
  ///
  /// In en, this message translates to:
  /// **'VIP access blocked'**
  String get staffSupervisorSystemLogVipBlocked;

  /// No description provided for @staffSupervisorSystemLogStaffAlert.
  ///
  /// In en, this message translates to:
  /// **'Staff alert sent'**
  String get staffSupervisorSystemLogStaffAlert;

  /// No description provided for @staffSupervisorSystemRiskReasonDuplicateQr.
  ///
  /// In en, this message translates to:
  /// **'Duplicate QR activity detected'**
  String get staffSupervisorSystemRiskReasonDuplicateQr;

  /// No description provided for @staffSupervisorSystemRiskReasonScannerSlow.
  ///
  /// In en, this message translates to:
  /// **'One or more scanners are slow'**
  String get staffSupervisorSystemRiskReasonScannerSlow;

  /// No description provided for @staffSupervisorSystemRiskReasonValidationsPaused.
  ///
  /// In en, this message translates to:
  /// **'Validations are paused'**
  String get staffSupervisorSystemRiskReasonValidationsPaused;

  /// No description provided for @staffSupervisorSystemActionDeactivateOfflineMode.
  ///
  /// In en, this message translates to:
  /// **'DEACTIVATE OFFLINE MODE'**
  String get staffSupervisorSystemActionDeactivateOfflineMode;

  /// No description provided for @staffSupervisorSystemActionResumeValidations.
  ///
  /// In en, this message translates to:
  /// **'RESUME VALIDATIONS'**
  String get staffSupervisorSystemActionResumeValidations;

  /// No description provided for @staffSupervisorSystemActionUnblockVip.
  ///
  /// In en, this message translates to:
  /// **'UNBLOCK VIP ACCESS'**
  String get staffSupervisorSystemActionUnblockVip;

  /// No description provided for @staffSupervisorSystemActionSuccess.
  ///
  /// In en, this message translates to:
  /// **'System action applied successfully'**
  String get staffSupervisorSystemActionSuccess;

  /// No description provided for @staffSupervisorSystemLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load system status'**
  String get staffSupervisorSystemLoadError;

  /// No description provided for @staffSupervisorSystemAlertMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Alert message'**
  String get staffSupervisorSystemAlertMessageLabel;

  /// No description provided for @staffSupervisorSystemAlertMessagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue for staff on site'**
  String get staffSupervisorSystemAlertMessagePlaceholder;

  /// No description provided for @staffSupervisorSystemPinRequired.
  ///
  /// In en, this message translates to:
  /// **'Supervisor PIN'**
  String get staffSupervisorSystemPinRequired;

  /// No description provided for @staffSupervisorSystemDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get staffSupervisorSystemDialogConfirm;

  /// No description provided for @staffSupervisorSystemRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get staffSupervisorSystemRetry;

  /// No description provided for @staffSupervisorActionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Action history'**
  String get staffSupervisorActionHistoryTitle;

  /// No description provided for @staffSupervisorActionHistoryDescription.
  ///
  /// In en, this message translates to:
  /// **'Review the latest actions performed in supervisor mode.'**
  String get staffSupervisorActionHistoryDescription;

  /// No description provided for @staffSupervisorActionHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No supervisor actions recorded for this event yet.'**
  String get staffSupervisorActionHistoryEmpty;

  /// No description provided for @staffSupervisorActionHistoryLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load action history'**
  String get staffSupervisorActionHistoryLoadError;

  /// No description provided for @staffSupervisorActionHistoryKindReleaseQr.
  ///
  /// In en, this message translates to:
  /// **'QR released'**
  String get staffSupervisorActionHistoryKindReleaseQr;

  /// No description provided for @staffSupervisorActionHistoryKindRevalidateQr.
  ///
  /// In en, this message translates to:
  /// **'QR revalidated'**
  String get staffSupervisorActionHistoryKindRevalidateQr;

  /// No description provided for @staffSupervisorActionHistoryKindRevertValidation.
  ///
  /// In en, this message translates to:
  /// **'Validation reverted'**
  String get staffSupervisorActionHistoryKindRevertValidation;

  /// No description provided for @staffSupervisorActionHistoryKindAuthorizeReentry.
  ///
  /// In en, this message translates to:
  /// **'Re-entry authorized'**
  String get staffSupervisorActionHistoryKindAuthorizeReentry;

  /// No description provided for @staffSupervisorActionHistoryKindTemporaryUnlock.
  ///
  /// In en, this message translates to:
  /// **'Temporary unlock applied'**
  String get staffSupervisorActionHistoryKindTemporaryUnlock;

  /// No description provided for @staffSupervisorActionHistoryKindReleaseReentry.
  ///
  /// In en, this message translates to:
  /// **'Re-entry released'**
  String get staffSupervisorActionHistoryKindReleaseReentry;

  /// No description provided for @staffSupervisorActionHistoryKindBlockQr.
  ///
  /// In en, this message translates to:
  /// **'QR blocked'**
  String get staffSupervisorActionHistoryKindBlockQr;

  /// No description provided for @staffSupervisorActionHistoryKindEscalateAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert escalated'**
  String get staffSupervisorActionHistoryKindEscalateAlert;

  /// No description provided for @staffSupervisorActionHistoryKindAuthorizeEntry.
  ///
  /// In en, this message translates to:
  /// **'Manual entry authorized'**
  String get staffSupervisorActionHistoryKindAuthorizeEntry;

  /// No description provided for @staffSupervisorActionHistoryKindGenerateTemporaryQr.
  ///
  /// In en, this message translates to:
  /// **'Temporary QR generated'**
  String get staffSupervisorActionHistoryKindGenerateTemporaryQr;

  /// No description provided for @staffSupervisorActionHistoryKindRejectAccess.
  ///
  /// In en, this message translates to:
  /// **'Access rejected'**
  String get staffSupervisorActionHistoryKindRejectAccess;

  /// No description provided for @staffSupervisorActionHistoryKindAuthorizeExtraGuest.
  ///
  /// In en, this message translates to:
  /// **'Extra VIP guest authorized'**
  String get staffSupervisorActionHistoryKindAuthorizeExtraGuest;

  /// No description provided for @staffSupervisorActionHistoryKindChangeAccess.
  ///
  /// In en, this message translates to:
  /// **'VIP access changed'**
  String get staffSupervisorActionHistoryKindChangeAccess;

  /// No description provided for @staffSupervisorActionHistoryKindMoveGuest.
  ///
  /// In en, this message translates to:
  /// **'VIP guest moved'**
  String get staffSupervisorActionHistoryKindMoveGuest;

  /// No description provided for @staffSupervisorActionHistoryKindReleaseInvitation.
  ///
  /// In en, this message translates to:
  /// **'VIP invitation released'**
  String get staffSupervisorActionHistoryKindReleaseInvitation;

  /// No description provided for @staffSupervisorActionHistoryKindOfflineModeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Offline mode activated'**
  String get staffSupervisorActionHistoryKindOfflineModeEnabled;

  /// No description provided for @staffSupervisorActionHistoryKindOfflineModeDisabled.
  ///
  /// In en, this message translates to:
  /// **'Offline mode deactivated'**
  String get staffSupervisorActionHistoryKindOfflineModeDisabled;

  /// No description provided for @staffSupervisorActionHistoryKindValidationsPaused.
  ///
  /// In en, this message translates to:
  /// **'Validations paused'**
  String get staffSupervisorActionHistoryKindValidationsPaused;

  /// No description provided for @staffSupervisorActionHistoryKindValidationsResumed.
  ///
  /// In en, this message translates to:
  /// **'Validations resumed'**
  String get staffSupervisorActionHistoryKindValidationsResumed;

  /// No description provided for @staffSupervisorActionHistoryKindVipAccessBlocked.
  ///
  /// In en, this message translates to:
  /// **'VIP access blocked'**
  String get staffSupervisorActionHistoryKindVipAccessBlocked;

  /// No description provided for @staffSupervisorActionHistoryKindVipAccessUnblocked.
  ///
  /// In en, this message translates to:
  /// **'VIP access unblocked'**
  String get staffSupervisorActionHistoryKindVipAccessUnblocked;

  /// No description provided for @staffSupervisorActionHistoryKindScannerRestarted.
  ///
  /// In en, this message translates to:
  /// **'Scanner restarted'**
  String get staffSupervisorActionHistoryKindScannerRestarted;

  /// No description provided for @staffSupervisorActionHistoryKindStaffAlert.
  ///
  /// In en, this message translates to:
  /// **'Staff alert sent'**
  String get staffSupervisorActionHistoryKindStaffAlert;

  /// No description provided for @staffSupervisorExitModeButton.
  ///
  /// In en, this message translates to:
  /// **'Exit supervisor mode'**
  String get staffSupervisorExitModeButton;

  /// No description provided for @staffSupervisorValidatorLabel.
  ///
  /// In en, this message translates to:
  /// **'Validator: {validatorId}'**
  String staffSupervisorValidatorLabel(String validatorId);

  /// No description provided for @staffSupervisorSearchEntryScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Search entry'**
  String get staffSupervisorSearchEntryScreenTitle;

  /// No description provided for @staffSupervisorSearchEntrySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'SEARCH ENTRY'**
  String get staffSupervisorSearchEntrySectionTitle;

  /// No description provided for @staffSupervisorSearchEntryPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Name / phone / QR / purchase ID / VIP table'**
  String get staffSupervisorSearchEntryPlaceholder;

  /// No description provided for @staffSupervisorSearchEntryHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Supervisor · Supervisor mode'**
  String get staffSupervisorSearchEntryHeaderSubtitle;

  /// No description provided for @staffSupervisorSearchEntryByLabel.
  ///
  /// In en, this message translates to:
  /// **'Search by:'**
  String get staffSupervisorSearchEntryByLabel;

  /// No description provided for @staffSupervisorSearchEntryQuickFilters.
  ///
  /// In en, this message translates to:
  /// **'Quick filters'**
  String get staffSupervisorSearchEntryQuickFilters;

  /// No description provided for @staffSupervisorSearchEntryFilterVip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get staffSupervisorSearchEntryFilterVip;

  /// No description provided for @staffSupervisorSearchEntryFilterUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get staffSupervisorSearchEntryFilterUsed;

  /// No description provided for @staffSupervisorSearchEntryFilterError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get staffSupervisorSearchEntryFilterError;

  /// No description provided for @staffSupervisorSearchEntryPurchaseIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase ID'**
  String get staffSupervisorSearchEntryPurchaseIdLabel;

  /// No description provided for @staffSupervisorSearchEntryTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Entry time'**
  String get staffSupervisorSearchEntryTimeLabel;

  /// No description provided for @staffSupervisorSearchEntryValidatorLabel.
  ///
  /// In en, this message translates to:
  /// **'Validator'**
  String get staffSupervisorSearchEntryValidatorLabel;

  /// No description provided for @staffSupervisorSearchEntryVipTableLabel.
  ///
  /// In en, this message translates to:
  /// **'VIP table'**
  String get staffSupervisorSearchEntryVipTableLabel;

  /// No description provided for @staffSupervisorSearchEntryAssociatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Associated entries'**
  String get staffSupervisorSearchEntryAssociatedLabel;

  /// No description provided for @staffSupervisorSearchEntryActionHistory.
  ///
  /// In en, this message translates to:
  /// **'View history'**
  String get staffSupervisorSearchEntryActionHistory;

  /// No description provided for @staffSupervisorEntryHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Entry history'**
  String get staffSupervisorEntryHistoryTitle;

  /// No description provided for @staffSupervisorEntryHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history recorded for this entry yet.'**
  String get staffSupervisorEntryHistoryEmpty;

  /// No description provided for @staffSupervisorEntryHistoryQrLabel.
  ///
  /// In en, this message translates to:
  /// **'Entry code: {code}'**
  String staffSupervisorEntryHistoryQrLabel(String code);

  /// No description provided for @staffSupervisorSearchEntryActionOverride.
  ///
  /// In en, this message translates to:
  /// **'Manual override'**
  String get staffSupervisorSearchEntryActionOverride;

  /// No description provided for @staffSupervisorSearchEntryRecentEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'RECENT EVENTS'**
  String get staffSupervisorSearchEntryRecentEventsTitle;

  /// No description provided for @staffSupervisorEntryGateLabel.
  ///
  /// In en, this message translates to:
  /// **'Gate'**
  String get staffSupervisorEntryGateLabel;

  /// No description provided for @staffSupervisorEntryStatusValidated.
  ///
  /// In en, this message translates to:
  /// **'VALIDATED'**
  String get staffSupervisorEntryStatusValidated;

  /// No description provided for @staffSupervisorEntryStatusPending.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get staffSupervisorEntryStatusPending;

  /// No description provided for @staffSupervisorEntryStatusUsed.
  ///
  /// In en, this message translates to:
  /// **'USED'**
  String get staffSupervisorEntryStatusUsed;

  /// No description provided for @staffSupervisorEntryStatusBlocked.
  ///
  /// In en, this message translates to:
  /// **'BLOCKED'**
  String get staffSupervisorEntryStatusBlocked;

  /// No description provided for @staffSupervisorEntryStatusError.
  ///
  /// In en, this message translates to:
  /// **'ERROR'**
  String get staffSupervisorEntryStatusError;

  /// No description provided for @staffSupervisorSearchEntryNoResults.
  ///
  /// In en, this message translates to:
  /// **'No entries found for this search.'**
  String get staffSupervisorSearchEntryNoResults;

  /// No description provided for @staffSupervisorSearchEntryNoVipResults.
  ///
  /// In en, this message translates to:
  /// **'No VIP entries match this search. Turn off the VIP filter or try another term.'**
  String get staffSupervisorSearchEntryNoVipResults;

  /// No description provided for @staffSupervisorSearchEntryNoUsedResults.
  ///
  /// In en, this message translates to:
  /// **'No used entries match this search. Turn off the Used filter or try another term.'**
  String get staffSupervisorSearchEntryNoUsedResults;

  /// No description provided for @staffSupervisorSearchEntryNoErrorResults.
  ///
  /// In en, this message translates to:
  /// **'No error entries match this search. Turn off the Error filter or try another term.'**
  String get staffSupervisorSearchEntryNoErrorResults;

  /// No description provided for @staffSupervisorSearchEntrySearchError.
  ///
  /// In en, this message translates to:
  /// **'Could not search entries. Try again.'**
  String get staffSupervisorSearchEntrySearchError;

  /// No description provided for @staffSupervisorSearchEntryRecentValidated.
  ///
  /// In en, this message translates to:
  /// **'Validated'**
  String get staffSupervisorSearchEntryRecentValidated;

  /// No description provided for @staffSupervisorSearchEntryRecentReentry.
  ///
  /// In en, this message translates to:
  /// **'Re-entry authorized'**
  String get staffSupervisorSearchEntryRecentReentry;

  /// No description provided for @staffSupervisorSearchEntryRecentSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get staffSupervisorSearchEntryRecentSupervisor;

  /// No description provided for @staffSupervisorSearchEntryResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result found} other{{count} results found}}'**
  String staffSupervisorSearchEntryResultsCount(int count);

  /// No description provided for @staffSupervisorDuplicateAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'DUPLICATE ALERT'**
  String get staffSupervisorDuplicateAlertTitle;

  /// No description provided for @staffSupervisorDuplicateCurrentStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'CURRENT STATUS'**
  String get staffSupervisorDuplicateCurrentStatusTitle;

  /// No description provided for @staffSupervisorDuplicateLastValidTitle.
  ///
  /// In en, this message translates to:
  /// **'Last valid access'**
  String get staffSupervisorDuplicateLastValidTitle;

  /// No description provided for @staffSupervisorDuplicateNewAttemptTitle.
  ///
  /// In en, this message translates to:
  /// **'New attempt detected'**
  String get staffSupervisorDuplicateNewAttemptTitle;

  /// No description provided for @staffSupervisorDuplicateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get staffSupervisorDuplicateTimeLabel;

  /// No description provided for @staffSupervisorDuplicateAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get staffSupervisorDuplicateAccessLabel;

  /// No description provided for @staffSupervisorDuplicateDeviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get staffSupervisorDuplicateDeviceLabel;

  /// No description provided for @staffSupervisorDuplicatePossibleReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'POSSIBLE REASON'**
  String get staffSupervisorDuplicatePossibleReasonTitle;

  /// No description provided for @staffSupervisorDuplicateReasonScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Shared screenshot'**
  String get staffSupervisorDuplicateReasonScreenshot;

  /// No description provided for @staffSupervisorDuplicateReasonResold.
  ///
  /// In en, this message translates to:
  /// **'Resold QR'**
  String get staffSupervisorDuplicateReasonResold;

  /// No description provided for @staffSupervisorDuplicateReasonValidationError.
  ///
  /// In en, this message translates to:
  /// **'Validation error'**
  String get staffSupervisorDuplicateReasonValidationError;

  /// No description provided for @staffSupervisorDuplicateReasonAuthorizedReentry.
  ///
  /// In en, this message translates to:
  /// **'Authorized re-entry'**
  String get staffSupervisorDuplicateReasonAuthorizedReentry;

  /// No description provided for @staffSupervisorDuplicateSupervisorActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'SUPERVISOR ACTIONS'**
  String get staffSupervisorDuplicateSupervisorActionsTitle;

  /// No description provided for @staffSupervisorDuplicateReleaseReentry.
  ///
  /// In en, this message translates to:
  /// **'RELEASE RE-ENTRY'**
  String get staffSupervisorDuplicateReleaseReentry;

  /// No description provided for @staffSupervisorDuplicateBlockQr.
  ///
  /// In en, this message translates to:
  /// **'BLOCK QR'**
  String get staffSupervisorDuplicateBlockQr;

  /// No description provided for @staffSupervisorDuplicateEscalateAlert.
  ///
  /// In en, this message translates to:
  /// **'ESCALATE ALERT'**
  String get staffSupervisorDuplicateEscalateAlert;

  /// No description provided for @staffSupervisorDuplicateReasonPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write the reason...'**
  String get staffSupervisorDuplicateReasonPlaceholder;

  /// No description provided for @staffSupervisorExecuteDuplicateButton.
  ///
  /// In en, this message translates to:
  /// **'RESOLVE DUPLICATE'**
  String get staffSupervisorExecuteDuplicateButton;

  /// No description provided for @staffSupervisorDuplicateNotFound.
  ///
  /// In en, this message translates to:
  /// **'No duplicate attempts found for this entry.'**
  String get staffSupervisorDuplicateNotFound;

  /// No description provided for @staffSupervisorDuplicateResolvedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Duplicate resolved successfully.'**
  String get staffSupervisorDuplicateResolvedSuccess;

  /// No description provided for @staffSupervisorEntryOverrideSuccess.
  ///
  /// In en, this message translates to:
  /// **'Override applied successfully.'**
  String get staffSupervisorEntryOverrideSuccess;

  /// No description provided for @staffSupervisorDuplicateLogValidated.
  ///
  /// In en, this message translates to:
  /// **'Validated'**
  String get staffSupervisorDuplicateLogValidated;

  /// No description provided for @staffSupervisorDuplicateLogReentryRejected.
  ///
  /// In en, this message translates to:
  /// **'Re-entry rejected'**
  String get staffSupervisorDuplicateLogReentryRejected;

  /// No description provided for @staffSupervisorDuplicateLogSupervisorPending.
  ///
  /// In en, this message translates to:
  /// **'Supervisor pending'**
  String get staffSupervisorDuplicateLogSupervisorPending;

  /// No description provided for @staffSupervisorDuplicateLogSupervisorResolved.
  ///
  /// In en, this message translates to:
  /// **'Supervisor resolved'**
  String get staffSupervisorDuplicateLogSupervisorResolved;

  /// No description provided for @staffSupervisorDuplicateAlreadyResolved.
  ///
  /// In en, this message translates to:
  /// **'This duplicate alert has already been resolved.'**
  String get staffSupervisorDuplicateAlreadyResolved;

  /// No description provided for @staffSupervisorDuplicateSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, entry code, phone, or purchase ID'**
  String get staffSupervisorDuplicateSearchHint;

  /// No description provided for @staffBarMode.
  ///
  /// In en, this message translates to:
  /// **'Bar mode'**
  String get staffBarMode;

  /// No description provided for @staffNoScanAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'No scan access assigned'**
  String get staffNoScanAccessTitle;

  /// No description provided for @staffNoScanAccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask an administrator to assign door or bar scan permissions to your staff account.'**
  String get staffNoScanAccessSubtitle;

  /// No description provided for @staffSupervisorAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have supervisor access for this area.'**
  String get staffSupervisorAccessDenied;

  /// No description provided for @staffAccessValidatorTitle.
  ///
  /// In en, this message translates to:
  /// **'ACCESS VALIDATOR'**
  String get staffAccessValidatorTitle;

  /// No description provided for @staffAccessValidatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan the entry QR code to validate event access'**
  String get staffAccessValidatorSubtitle;

  /// No description provided for @staffScanEntryButton.
  ///
  /// In en, this message translates to:
  /// **'SCAN ENTRY'**
  String get staffScanEntryButton;

  /// No description provided for @staffActiveEventPrefix.
  ///
  /// In en, this message translates to:
  /// **'Active event:'**
  String get staffActiveEventPrefix;

  /// No description provided for @staffActiveEventLabel.
  ///
  /// In en, this message translates to:
  /// **'Active event: {eventName}'**
  String staffActiveEventLabel(String eventName);

  /// No description provided for @staffRecentAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent access'**
  String get staffRecentAccessTitle;

  /// No description provided for @staffRecentAccessEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entry scans yet. Scan a ticket QR to see it here.'**
  String get staffRecentAccessEmpty;

  /// No description provided for @staffViewAllAccess.
  ///
  /// In en, this message translates to:
  /// **'View all >'**
  String get staffViewAllAccess;

  /// No description provided for @staffAccessDuplicateLabel.
  ///
  /// In en, this message translates to:
  /// **'Duplicate QR'**
  String get staffAccessDuplicateLabel;

  /// No description provided for @staffScanResultValidTitle.
  ///
  /// In en, this message translates to:
  /// **'VALID'**
  String get staffScanResultValidTitle;

  /// No description provided for @staffScanResultValidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The QR code was validated successfully.'**
  String get staffScanResultValidSubtitle;

  /// No description provided for @staffScanResultUsedTitle.
  ///
  /// In en, this message translates to:
  /// **'QR USED'**
  String get staffScanResultUsedTitle;

  /// No description provided for @staffScanResultUsedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This code was already redeemed.'**
  String get staffScanResultUsedSubtitle;

  /// No description provided for @staffScanResultProductLabel.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get staffScanResultProductLabel;

  /// No description provided for @staffScanResultUserLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get staffScanResultUserLabel;

  /// No description provided for @staffScanResultTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get staffScanResultTimeLabel;

  /// No description provided for @staffScanResultAttemptTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Attempt time'**
  String get staffScanResultAttemptTimeLabel;

  /// No description provided for @staffScanResultBarLabel.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get staffScanResultBarLabel;

  /// No description provided for @staffScanResultTransactionIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get staffScanResultTransactionIdLabel;

  /// No description provided for @staffScanResultRememberTitle.
  ///
  /// In en, this message translates to:
  /// **'Remember'**
  String get staffScanResultRememberTitle;

  /// No description provided for @staffScanResultRememberMessage.
  ///
  /// In en, this message translates to:
  /// **'Press the button to confirm product delivery.'**
  String get staffScanResultRememberMessage;

  /// No description provided for @staffScanResultLastSuccessfulUse.
  ///
  /// In en, this message translates to:
  /// **'Last successful use'**
  String get staffScanResultLastSuccessfulUse;

  /// No description provided for @staffScanResultDeliverButton.
  ///
  /// In en, this message translates to:
  /// **'DELIVER PRODUCT'**
  String get staffScanResultDeliverButton;

  /// No description provided for @staffScanResultConfirmAccessButton.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM ACCESS'**
  String get staffScanResultConfirmAccessButton;

  /// No description provided for @staffScanResultEntryRememberMessage.
  ///
  /// In en, this message translates to:
  /// **'Press the button to confirm event access.'**
  String get staffScanResultEntryRememberMessage;

  /// No description provided for @staffScanResultTicketLabel.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get staffScanResultTicketLabel;

  /// No description provided for @staffScanResultBackButton.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get staffScanResultBackButton;

  /// No description provided for @staffEntryValidTitle.
  ///
  /// In en, this message translates to:
  /// **'VALID'**
  String get staffEntryValidTitle;

  /// No description provided for @staffEntryValidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Valid unique QR'**
  String get staffEntryValidSubtitle;

  /// No description provided for @staffEntryValidEventLabel.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get staffEntryValidEventLabel;

  /// No description provided for @staffEntryValidEntryIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Entry ID'**
  String get staffEntryValidEntryIdLabel;

  /// No description provided for @staffEntryValidTicketTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Ticket type'**
  String get staffEntryValidTicketTypeLabel;

  /// No description provided for @staffEntryValidAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'Authorized access'**
  String get staffEntryValidAccessLabel;

  /// No description provided for @staffEntryValidTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Validation time'**
  String get staffEntryValidTimeLabel;

  /// No description provided for @staffEntryValidAllowButton.
  ///
  /// In en, this message translates to:
  /// **'ALLOW ENTRY'**
  String get staffEntryValidAllowButton;

  /// No description provided for @staffEntryInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'INVALID'**
  String get staffEntryInvalidTitle;

  /// No description provided for @staffEntryInvalidSubtitle.
  ///
  /// In en, this message translates to:
  /// **'QR already used'**
  String get staffEntryInvalidSubtitle;

  /// No description provided for @staffEntryInvalidReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get staffEntryInvalidReasonLabel;

  /// No description provided for @staffEntryInvalidReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'QR already used'**
  String get staffEntryInvalidReasonTitle;

  /// No description provided for @staffEntryInvalidReasonMessage.
  ///
  /// In en, this message translates to:
  /// **'This code was already scanned previously'**
  String get staffEntryInvalidReasonMessage;

  /// No description provided for @staffEntryInvalidLastAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'Last access'**
  String get staffEntryInvalidLastAccessLabel;

  /// No description provided for @staffEntryInvalidLastAccessDate.
  ///
  /// In en, this message translates to:
  /// **'Today, {date}'**
  String staffEntryInvalidLastAccessDate(String date);

  /// No description provided for @staffEntryInvalidUserLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get staffEntryInvalidUserLabel;

  /// No description provided for @staffEntryInvalidWarning.
  ///
  /// In en, this message translates to:
  /// **'This QR cannot be used. If you think this is an error, contact the supervisor.'**
  String get staffEntryInvalidWarning;

  /// No description provided for @staffEntryInvalidResolveDuplicateButton.
  ///
  /// In en, this message translates to:
  /// **'RESOLVE DUPLICATE'**
  String get staffEntryInvalidResolveDuplicateButton;

  /// No description provided for @staffScanErrorQrNotFound.
  ///
  /// In en, this message translates to:
  /// **'QR code not recognised.'**
  String get staffScanErrorQrNotFound;

  /// No description provided for @staffScanErrorQrInvalid.
  ///
  /// In en, this message translates to:
  /// **'This QR code is not valid for scanning.'**
  String get staffScanErrorQrInvalid;

  /// No description provided for @staffScanErrorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to perform this scan.'**
  String get staffScanErrorPermissionDenied;

  /// No description provided for @staffScanErrorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Please sign in again.'**
  String get staffScanErrorSessionExpired;

  /// No description provided for @staffScanResultUnitCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 unit} other{{count} units}}'**
  String staffScanResultUnitCount(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
