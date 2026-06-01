// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeBackTitle => 'BIENVENIDO DE VUELTA';

  @override
  String get phoneLoginSubtitle =>
      'Inicia sesión con tu número y recibe tu código por WhatsApp';

  @override
  String get phoneNumberLabel => 'NÚMERO TELEFÓNICO';

  @override
  String get sendCodeButton => 'ENVIAR CÓDIGO';

  @override
  String get createAccountLink => 'Crear cuenta';

  @override
  String get verificationCodeTitle => 'CÓDIGO DE VERIFICACIÓN';

  @override
  String get verificationCodeSentPrefix => 'Enviamos un código a ';

  @override
  String get verificationCodeSentSuffix => ' via WhatsApp ';

  @override
  String get validateCodeButton => 'VALIDAR CÓDIGO';

  @override
  String get resendCodePrefix => 'Reenviar código en ';

  @override
  String get incorrectNumberQuestion => '¿NÚMERO INCORRECTO?';

  @override
  String get changeNumberLink => 'CAMBIAR NÚMERO';

  @override
  String get selectCountryTitle => 'Selecciona tu país';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get homeDashboardTitle => 'Panel';

  @override
  String get homeDashboardSubtitle => 'Tu camino de aprendizaje comienza aquí';

  @override
  String helloUser(String name) {
    return 'Hola, $name';
  }

  @override
  String get logoutButton => 'Cerrar sesión';

  @override
  String get errorGeneric => 'Error';

  @override
  String get routeNotFound => 'Ruta no encontrada';

  @override
  String get backButton => 'VOLVER';

  @override
  String get createAccountTitle => 'CREAR CUENTA';

  @override
  String get createAccountSubtitle =>
      'Completa los siguientes datos para crear tu cuenta';

  @override
  String get fullNameLabel => 'NOMBRE COMPLETO';

  @override
  String get fullNameHint => 'Ingresa tu nombre completo';

  @override
  String get idDocumentLabel => 'RUT O PASAPORTE';

  @override
  String get idDocumentHint => 'Ingresa tu RUT o pasaporte';

  @override
  String get birthDateLabel => 'FECHA DE NACIMIENTO';

  @override
  String get birthDateHint => 'Selecciona tu fecha de nacimiento';

  @override
  String get genderLabel => 'GÉNERO';

  @override
  String get genderHint => 'Selecciona tu género';

  @override
  String get genderMale => 'Masculino';

  @override
  String get genderFemale => 'Femenino';

  @override
  String get genderOther => 'Otro';

  @override
  String get emailLabel => 'CORREO ELECTRÓNICO';

  @override
  String get emailHint => 'ejemplo@correo.com';

  @override
  String get instagramLabel => 'USUARIO DE INSTAGRAM';

  @override
  String get instagramHint => '@usuarioinstagram';

  @override
  String get termsPrefix => 'Acepto los ';

  @override
  String get termsLink => 'términos y condiciones';

  @override
  String get createAccountButton => 'CREAR CUENTA';

  @override
  String get alreadyHaveAccountQuestion => '¿YA TIENES CUENTA?';

  @override
  String get signInLink => 'INICIAR SESIÓN';
}
