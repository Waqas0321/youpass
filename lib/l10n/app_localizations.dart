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
