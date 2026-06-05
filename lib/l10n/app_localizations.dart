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
  /// **'Hello, {name}!'**
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
  /// **'Events you saved with the heart icon'**
  String get favoritesEventsSubtitle;

  /// No description provided for @favoritesEventsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search favorite event'**
  String get favoritesEventsSearchHint;

  /// No description provided for @favoritesEventsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorite events yet. Tap the heart on an event to save it here.'**
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

  /// No description provided for @drawerMyTickets.
  ///
  /// In en, this message translates to:
  /// **'My Tickets'**
  String get drawerMyTickets;

  /// No description provided for @drawerMyFavorites.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get drawerMyFavorites;

  /// No description provided for @drawerInvitations.
  ///
  /// In en, this message translates to:
  /// **'INVITATIONS'**
  String get drawerInvitations;

  /// No description provided for @drawerInvitationsNewBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} new'**
  String drawerInvitationsNewBadge(int count);

  /// No description provided for @drawerTierGold.
  ///
  /// In en, this message translates to:
  /// **'GOLD'**
  String get drawerTierGold;

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

  /// No description provided for @profileViewFullWallet.
  ///
  /// In en, this message translates to:
  /// **'View full wallet'**
  String get profileViewFullWallet;

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
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDeleteAccount;

  /// No description provided for @profilePhotoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated'**
  String get profilePhotoUpdated;

  /// No description provided for @confirmDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get confirmDialogCancel;

  /// No description provided for @confirmLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get confirmLogoutTitle;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again with your phone number to use YouPass.'**
  String get confirmLogoutMessage;

  /// No description provided for @confirmLogoutAction.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
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
  /// **'UPCOMING'**
  String get ticketsTabUpcoming;

  /// No description provided for @ticketsTabPast.
  ///
  /// In en, this message translates to:
  /// **'PAST EVENTS'**
  String get ticketsTabPast;

  /// No description provided for @ticketsStatusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get ticketsStatusActive;

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
  /// **'{count} saved producers'**
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
  /// **'Manage your event access and invitations'**
  String get invitationsSubtitle;

  /// No description provided for @invitationsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search invitations / Events / promoters'**
  String get invitationsSearchHint;

  /// No description provided for @invitationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get invitationsFilterAll;

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
  /// **'Awaiting confirmation'**
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

  /// No description provided for @invitationsReject.
  ///
  /// In en, this message translates to:
  /// **'DECLINE'**
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
  /// **'Confirmed invitations generate a unique, non-transferable QR code.'**
  String get invitationsFooterNote;

  /// No description provided for @invitationsImportantTitle.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get invitationsImportantTitle;

  /// No description provided for @invitationsImportantMessage.
  ///
  /// In en, this message translates to:
  /// **'By confirming, the ticket is reserved exclusively for you. If you do not attend, you may be charged the full ticket price.'**
  String get invitationsImportantMessage;

  /// No description provided for @invitationsAddPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'ADD PAYMENT METHOD'**
  String get invitationsAddPaymentMethod;

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
  /// **'for secure use'**
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
  /// **'Your card has been registered. Remember:'**
  String get invitationsCardSavedMessage;

  /// No description provided for @invitationsCardSavedReminderCharge.
  ///
  /// In en, this message translates to:
  /// **'If you do not attend the event, you may be charged the full ticket price.'**
  String get invitationsCardSavedReminderCharge;

  /// No description provided for @invitationsCardSavedReminderCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancellations must be made at least 48 hours in advance to avoid charges.'**
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
  /// **'Invitation sent via WhatsApp'**
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
  /// **'A link with instructions to download and register in YouPass will be sent via WhatsApp once you send them the ticket.'**
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
