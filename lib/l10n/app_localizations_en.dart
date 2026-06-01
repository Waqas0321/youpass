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
  String get verificationCodeSentSuffix => ' via WhatsApp ';

  @override
  String get validateCodeButton => 'VALIDATE CODE';

  @override
  String get resendCodePrefix => 'Resend code in ';

  @override
  String get incorrectNumberQuestion => 'INCORRECT NUMBER?';

  @override
  String get changeNumberLink => 'CHANGE NUMBER';

  @override
  String get selectCountryTitle => 'Select your country';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeDashboardTitle => 'Dashboard';

  @override
  String get homeDashboardSubtitle => 'Your learning journey starts here';

  @override
  String helloUser(String name) {
    return 'Hello, $name';
  }

  @override
  String get logoutButton => 'Logout';

  @override
  String get errorGeneric => 'Error';

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
