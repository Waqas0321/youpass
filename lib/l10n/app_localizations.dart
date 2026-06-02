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

  /// No description provided for @invitationsReject.
  ///
  /// In en, this message translates to:
  /// **'DECLINE'**
  String get invitationsReject;

  /// No description provided for @invitationsViewQr.
  ///
  /// In en, this message translates to:
  /// **'VIEW QR'**
  String get invitationsViewQr;

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
