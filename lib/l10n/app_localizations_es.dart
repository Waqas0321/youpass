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
  String get codeSentWhatsApp => 'Código enviado a tu WhatsApp';

  @override
  String get codeSentSms => 'Código enviado por SMS';

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
  String get verificationCodeSentViaSms => ' por SMS ';

  @override
  String get verificationCodeSentViaWhatsApp => ' por WhatsApp ';

  @override
  String get validateCodeButton => 'VALIDAR CÓDIGO';

  @override
  String get resendCodePrefix => 'Reenviar código en ';

  @override
  String get resendCodeAction => 'Reenviar código';

  @override
  String get incorrectNumberQuestion => '¿NÚMERO INCORRECTO?';

  @override
  String get changeNumberLink => 'CAMBIAR NÚMERO';

  @override
  String get selectCountryTitle => 'Selecciona tu país';

  @override
  String get searchCountryHint => 'Buscar país o código';

  @override
  String get searchCountryEmpty => 'No se encontraron países';

  @override
  String get homeTitle => 'Inicio';

  @override
  String homeGreeting(String name) {
    return '¡Hola, $name!';
  }

  @override
  String get homeDiscoverSubtitle => 'Descubre los mejores eventos para ti';

  @override
  String get categoryChile => 'Chile';

  @override
  String get categoryParties => 'Fiestas';

  @override
  String get categoryConcerts => 'Conciertos';

  @override
  String get categorySports => 'Deportes';

  @override
  String get featuredEventTitle => 'FESTIVAL PRIMAVERA — 2026 —';

  @override
  String get featuredEventDate => '21 DE NOVIEMBRE, 2026 • 17:00 HRS';

  @override
  String get featuredEventLocation => 'PARQUE BICENTENARIO, SANTIAGO';

  @override
  String get eventsSectionTitle => 'Eventos destacados';

  @override
  String get seeAll => 'Ver todos';

  @override
  String get buyTickets => 'COMPRAR ENTRADAS';

  @override
  String get eventCaribeDate => 'Sábado, 31 de enero, 2026';

  @override
  String get eventCaribeLocation => 'Club Océano, Viña del Mar';

  @override
  String get eventRockDate => 'Domingo, 15 de febrero, 2026';

  @override
  String get eventRockLocation => 'Parque Simón Bolívar, Bogotá';

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
    return 'Hola, $name';
  }

  @override
  String get logoutButton => 'Cerrar sesión';

  @override
  String get errorGeneric => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get phoneRequired => 'El número telefónico es requerido';

  @override
  String get phoneInvalidLength => 'Ingresa un número de 9 dígitos';

  @override
  String get phoneMustStartWithNine => 'El número debe comenzar con 9';

  @override
  String get phoneInvalidGeneric => 'Ingresa un número válido';

  @override
  String get otpRequired => 'Ingresa el código de verificación';

  @override
  String get otpInvalidLength => 'El código debe tener 6 dígitos';

  @override
  String get registerFullNameRequired => 'Ingresa tu nombre completo';

  @override
  String get registerIdDocumentRequired => 'Ingresa tu RUT o pasaporte';

  @override
  String get registerBirthDateRequired => 'Selecciona tu fecha de nacimiento';

  @override
  String get registerGenderRequired => 'Selecciona tu género';

  @override
  String get registerEmailRequired => 'Ingresa tu correo electrónico';

  @override
  String get registerTermsRequired =>
      'Debes aceptar los términos y condiciones';

  @override
  String get errorInvalidPhone => 'Número telefónico inválido';

  @override
  String get errorUnsupportedCountry => 'Este país no está disponible';

  @override
  String get errorOtpDeliveryFailed =>
      'No se pudo enviar el código. Inténtalo más tarde.';

  @override
  String get errorInvalidCode => 'Código inválido. Solicita uno nuevo.';

  @override
  String get errorIncorrectCode => 'Código incorrecto';

  @override
  String get errorCodeExpired => 'El código expiró. Solicita uno nuevo.';

  @override
  String get errorUserNotFound => 'No existe una cuenta con este número';

  @override
  String get errorUserExists => 'Este número ya está registrado';

  @override
  String errorResendCooldown(int seconds) {
    return 'Reenviar código en $seconds segundos';
  }

  @override
  String get errorMaxResends => 'Demasiados reenvíos. Inténtalo más tarde.';

  @override
  String get errorBlocked =>
      'Demasiados intentos fallidos. Inténtalo más tarde.';

  @override
  String get errorValidation => 'Revisa la información ingresada';

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
  String get genderPreferNotToSay => 'Prefiero no decir';

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
