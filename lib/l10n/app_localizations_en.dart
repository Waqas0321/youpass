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
  String get seeAll => 'See all';

  @override
  String get buyTickets => 'BUY TICKETS';

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
}
