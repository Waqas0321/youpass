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
  String get categoryAll => 'Todos';

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
  String get homeNoEventsFound => 'No hay eventos para este filtro';

  @override
  String get allEventsTitle => 'Todos los eventos';

  @override
  String get allEventsSubtitle =>
      'Explora todos los eventos publicados en YouPass';

  @override
  String get allEventsSearchHint => 'Buscar evento';

  @override
  String allEventsAvailableCount(int count) {
    return '$count eventos disponibles';
  }

  @override
  String get favoritesEventsSubtitle =>
      'Eventos que guardaste con el icono de corazón';

  @override
  String get favoritesEventsSearchHint => 'Buscar evento favorito';

  @override
  String get favoritesEventsEmpty =>
      'Aún no tienes eventos favoritos. Toca el corazón en un evento para guardarlo aquí.';

  @override
  String favoritesSavedEventsCount(int count) {
    return '$count eventos guardados';
  }

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
  String get brandBadgeOn => 'ON';

  @override
  String get brandModeProduction => 'PRODUCCIÓN';

  @override
  String get brandModeFiesta => 'MODO FIESTA';

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

  @override
  String get drawerMyProfile => 'Mi Perfil';

  @override
  String get drawerMyTickets => 'Mis Tickets';

  @override
  String get drawerMyFavorites => 'Mis Favoritos';

  @override
  String get drawerInvitations => 'INVITACIONES';

  @override
  String drawerInvitationsNewBadge(int count) {
    return '$count nuevas';
  }

  @override
  String get drawerTierGold => 'GOLD';

  @override
  String get profileTitle => 'Mi Perfil';

  @override
  String get profileViewBenefits => 'Ver mis beneficios';

  @override
  String get profilePersonalData => 'DATOS PERSONALES';

  @override
  String get profileFullName => 'Nombre y Apellidos';

  @override
  String get profileEmail => 'Correo electrónico';

  @override
  String get profileBirthDate => 'Fecha de nacimiento';

  @override
  String get profileGender => 'Género';

  @override
  String get profileGenderMaleValue => 'Hombre';

  @override
  String get profileInstagram => 'Nick de Instagram';

  @override
  String get profileEditData => 'Editar datos';

  @override
  String get profileWalletSection => 'BILLETERA YOUPASS';

  @override
  String get profilePaymentMethods => 'Mis métodos de pago';

  @override
  String get profileCardVisa => 'Visa ••••4205';

  @override
  String get profileCardMastercard => 'Mastercard ••••9988';

  @override
  String get profileDefaultCard => 'Predeterminada';

  @override
  String get profileViewFullWallet => 'Ver billetera completa';

  @override
  String get profileNotifications => 'NOTIFICACIONES';

  @override
  String get profileReceiveNotifications => 'Recibir notificaciones';

  @override
  String get profileNotificationChannels => 'Email · Push · WhatsApp';

  @override
  String get profileSupport => 'SOPORTE';

  @override
  String get profileWhatsAppSupport => 'WhatsApp soporte';

  @override
  String get profileWriteEmail => 'Escribir email';

  @override
  String get profileFaq => 'Preguntas frecuentes';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String get profileDeleteAccount => 'Eliminar cuenta';

  @override
  String get profilePhotoUpdated => 'Foto de perfil actualizada';

  @override
  String get confirmDialogCancel => 'Cancelar';

  @override
  String get confirmLogoutTitle => '¿Cerrar sesión?';

  @override
  String get confirmLogoutMessage =>
      'Deberás iniciar sesión nuevamente con tu número de teléfono para usar YouPass.';

  @override
  String get confirmLogoutAction => 'Cerrar sesión';

  @override
  String get confirmDeleteAccountTitle => '¿Eliminar tu cuenta?';

  @override
  String get confirmDeleteAccountMessage =>
      'Esto elimina permanentemente tu cuenta, entradas y datos de perfil. Enviaremos un código de verificación para confirmar.';

  @override
  String get confirmDeleteAccountAction => 'Continuar';

  @override
  String get ticketsTabUpcoming => 'PRÓXIMOS';

  @override
  String get ticketsTabPast => 'EVENTOS PASADOS';

  @override
  String get ticketsStatusActive => 'ACTIVO';

  @override
  String get ticketsViewQr => 'VER QR';

  @override
  String get ticketsAssignEntries => 'ASIGNAR ENTRADAS';

  @override
  String get ticketsAssignVip => 'ASIGNAR ENTRADAS VIP';

  @override
  String get ticketsAttendedSectionTitle => 'EVENTOS ASISTIDOS';

  @override
  String get ticketsAttendedSectionSubtitle =>
      'Revisa tus eventos anteriores y tus estadísticas personales.';

  @override
  String get ticketsSearchHint => 'Buscar evento / Nombre evento / productora';

  @override
  String get ticketsFiltersLabel => 'FILTROS';

  @override
  String get ticketsFilterAll => 'Todos';

  @override
  String get ticketsFilterParties => 'Fiestas';

  @override
  String get ticketsFilterConcerts => 'Conciertos';

  @override
  String get ticketsFilterBar => 'Bar';

  @override
  String ticketsYearlySummaryAttended(int count, int year) {
    return '$count eventos asistidos en $year';
  }

  @override
  String ticketsYearlySummaryProducer(String name, int count) {
    return 'Productora favorita: $name ($count eventos)';
  }

  @override
  String get ticketsEmptyUpcoming => 'Aún no tienes entradas próximas.';

  @override
  String get ticketsEmptyPast => 'No se encontraron eventos pasados.';

  @override
  String get ticketsRetry => 'Reintentar';

  @override
  String get ticketsStatistics => 'ESTADÍSTICAS';

  @override
  String get ticketsStatEntry => 'Ingreso';

  @override
  String get ticketsStatConsumption => 'Consumo';

  @override
  String get ticketsStatStay => 'Estadía';

  @override
  String get ticketsFavoritesTip =>
      'Puedes marcar eventos para agregarlos a favoritos.';

  @override
  String get favoritesSubtitle =>
      'Tus productoras y eventos favoritos aparecerán aquí';

  @override
  String get favoritesSearchHint => 'Buscar productora o evento';

  @override
  String get favoritesFiltersLabel => 'FILTROS';

  @override
  String get favoritesFilterAll => 'Todos';

  @override
  String get favoritesFilterUpcoming => 'Próximos';

  @override
  String get favoritesFilterParties => 'Fiestas';

  @override
  String get favoritesFilterVip => 'VIP';

  @override
  String get favoritesProducerType => 'Productora de eventos';

  @override
  String get favoritesProducerCoverage => 'Eventos en todo Chile';

  @override
  String get favoritesViewEvents => 'VER EVENTOS';

  @override
  String favoritesSavedProducersCount(int count) {
    return '$count productoras guardadas';
  }

  @override
  String get favoritesYoufestDescription =>
      'Los mejores festivales y experiencias en vivo.';

  @override
  String get favoritesIguanaDescription =>
      'Música electrónica, fiestas y experiencias únicas.';

  @override
  String get producerEventsUpcomingTitle => 'PRÓXIMOS EVENTOS';

  @override
  String producerEventsUpcomingSubtitle(String producerName) {
    return 'Descubre los próximos eventos de $producerName';
  }

  @override
  String get producerEventsSearchHint => 'Buscar evento';

  @override
  String get producerEventCategoryParties => 'Fiestas';

  @override
  String get producerEventCategoryFestivals => 'Festivales';

  @override
  String get producerEventCategoryConcerts => 'Conciertos';

  @override
  String get producerEventFromPrice => 'Desde';

  @override
  String get producerEventBuyTicket => 'COMPRAR ENTRADA';

  @override
  String producerEventsAvailableCount(int count) {
    return '$count eventos disponibles';
  }

  @override
  String get drawerMyInvitations => 'Mis Invitaciones';

  @override
  String get invitationsScreenTitle => 'MIS INVITACIONES';

  @override
  String get invitationsSubtitle =>
      'Gestiona tus accesos e invitaciones a eventos';

  @override
  String get invitationsSearchHint =>
      'Buscar invitaciones / Eventos / productores';

  @override
  String get invitationsFilterAll => 'Todas';

  @override
  String get invitationsFilterGeneral => 'General';

  @override
  String get invitationsFilterVip => 'VIP';

  @override
  String get invitationsTierVip => 'VIP';

  @override
  String get invitationsTierVipMesa => 'VIP Mesa';

  @override
  String get invitationsTierGeneral => 'General';

  @override
  String invitationsStatusLine(String status) {
    return 'Estado: $status';
  }

  @override
  String get invitationsStatusPrefix => 'Estado:';

  @override
  String get invitationsStatusPending => 'Esperando confirmación';

  @override
  String get invitationsStatusConfirmed => 'Confirmada';

  @override
  String get invitationsStatusRejected => 'Rechazado';

  @override
  String get invitationsConfirmAttendance => 'CONFIRMAR ASISTENCIA';

  @override
  String get invitationsReject => 'RECHAZAR';

  @override
  String get invitationsCancel => 'ANULAR';

  @override
  String get invitationsAttendanceConfirmed => 'ASISTENCIA CONFIRMADA';

  @override
  String get invitationsViewQr => 'VER QR';

  @override
  String get invitationsQrPendingTitle => 'Confirma tu asistencia';

  @override
  String get invitationsQrPendingMessage =>
      'Tu código QR estará disponible después de confirmar esta invitación.';

  @override
  String get invitationsQrLockedTitle => 'QR aún no disponible';

  @override
  String get invitationsQrLockedMessage =>
      'Tu QR estará disponible desde las 00:00 del día del evento.';

  @override
  String get invitationsQrExpiredTitle => 'QR expirado';

  @override
  String get invitationsQrExpiredMessage =>
      'El código QR de este evento ya no está disponible.';

  @override
  String invitationsQrUnlockAt(String date) {
    return 'Disponible desde $date';
  }

  @override
  String get invitationsQrGotIt => 'ENTENDIDO';

  @override
  String get invitationsFooterNote =>
      'Las invitaciones confirmadas generan un QR único e intransferible.';

  @override
  String get invitationsImportantTitle => 'Importante';

  @override
  String get invitationsImportantMessage =>
      'Al confirmar, la entrada queda reservada exclusivamente para ti. Si no asistes, podrías ser cobrado el valor total de la entrada.';

  @override
  String get invitationsAddPaymentMethod => 'AGREGAR MEDIO DE PAGO';

  @override
  String get invitationsPaymentTitle => 'Agregar medio de pago';

  @override
  String get invitationsPaymentSubtitle => 'Ingresa los datos de tu tarjeta';

  @override
  String get invitationsCardNumber => 'Número de tarjeta';

  @override
  String get invitationsCardNumberHint => '1234 5678 9012 3456';

  @override
  String get invitationsCardExpiry => 'Fecha de vencimiento';

  @override
  String get invitationsCardExpiryHint => 'MM/AA';

  @override
  String get invitationsCardCvv => 'CVV';

  @override
  String get invitationsCardCvvHint => '123';

  @override
  String get invitationsCardholderName => 'Nombre en la tarjeta';

  @override
  String get invitationsCardholderNameHint => 'Como aparece en la tarjeta';

  @override
  String get invitationsPaymentSecureNote => 'para utilizar de forma segura';

  @override
  String get invitationsSaveCard => 'GUARDAR TARJETA';

  @override
  String get invitationsCardSavedTitle => '¡Tarjeta guardada con éxito!';

  @override
  String get invitationsCardSavedMessage =>
      'Tu tarjeta quedó registrada. Recuerda:';

  @override
  String get invitationsCardSavedReminderCharge =>
      'Si no asistes al evento, podrías ser cobrado el valor total de la entrada.';

  @override
  String get invitationsCardSavedReminderCancel =>
      'Las cancelaciones deben hacerse con al menos 48 horas de anticipación para evitar cargos.';

  @override
  String get eventTicketScreenTitle => 'Entrada del evento';

  @override
  String get eventTicketReadyTitle => '¡Tu entrada está lista!';

  @override
  String get eventTicketReadySubtitle =>
      'Muestra este código en el acceso para ingresar al evento.';

  @override
  String get eventTicketManualIdLabel => 'ID de ingreso manual';

  @override
  String get welcomeFallbackTitle => 'Bienvenido a YouPass';

  @override
  String get welcomeFallbackSubtitle =>
      'Tu acceso a los mejores eventos comienza aquí';

  @override
  String get paymentBrandVisa => 'VISA';

  @override
  String get paymentBrandMastercard => 'MC';

  @override
  String get errorMissingAccessToken =>
      'No se pudo completar el inicio de sesión. Inténtalo de nuevo.';

  @override
  String get errorAuthenticationRequired => 'Inicia sesión para continuar.';

  @override
  String get errorTicketOrderNotFound => 'No se encontró la orden de entradas.';

  @override
  String get errorTicketSlotNotFound =>
      'No se encontró esta entrada para asignar.';

  @override
  String get errorTicketSlotNotAvailable =>
      'Esta entrada ya no está disponible para asignar.';

  @override
  String get errorWhatsAppSendFailed =>
      'No se pudo enviar la invitación por WhatsApp. Inténtalo de nuevo.';

  @override
  String get errorCannotAssignToSelf =>
      'No puedes asignar una entrada a tu propio número.';

  @override
  String get errorClaimNotFound =>
      'Este enlace de invitación no es válido o expiró.';

  @override
  String get errorInvitationForbidden =>
      'No tienes permiso para gestionar esta invitación.';

  @override
  String get emailRequired => 'El correo es obligatorio';

  @override
  String get emailInvalid => 'Ingresa un correo válido';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get phoneHintChile => '9 1234 5678';

  @override
  String get phoneHintGeneric => '123 456 7890';

  @override
  String get phoneHintPakistan => '321 6548001';

  @override
  String get mockEventFestivalVerano2026 => 'Festival Verano 2026';

  @override
  String get mockEventConciertoX => 'Concierto X';

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
  String get mockDateSaturdayMay15 => 'Sábado 15 May · 22:00';

  @override
  String get mockDateSaturdayMay15Long =>
      'Sábado, 15 de mayo de 2026 - 22:00 hrs';

  @override
  String get mockDateSaturdayJuly4 => 'Sáb 4 Julio · 22:00';

  @override
  String get mockLocationClubAmanda => 'Club Amanda, Santiago';

  @override
  String get mockLocationClubAmandaShort => 'Club Amanda';

  @override
  String get mockLocationMovistarArena => 'Movistar Arena';

  @override
  String get mockLocationCentroEventosHilaria => 'Centro Eventos Hilaria';

  @override
  String get mockTicketGeneralOne => 'General · 1 entrada';

  @override
  String get mockTicketVipTwo => 'VIP · 2 entradas';

  @override
  String get mockStayDuration5h14m => '5h 14m';

  @override
  String get mockSeatVipTable => 'Mesa 1 - VIP 1 | 10 personas';

  @override
  String get mockProducerYoufest => 'YouFest';

  @override
  String get mockProducerIguana => 'IGUANA';

  @override
  String get mockPriceFrom35000 => 'Desde \$35.000 CLP';

  @override
  String get mockPriceFrom28000 => 'Desde \$28.000 CLP';

  @override
  String get mockPriceFrom42000 => 'Desde \$42.000 CLP';

  @override
  String get mockPriceFrom55000 => 'Desde \$55.000 CLP';

  @override
  String get mockPriceFrom32000 => 'Desde \$32.000 CLP';

  @override
  String get mockDateSaturdayJuly18 => 'Sáb 18 Julio 2026';

  @override
  String get mockDateFridayAugust7 => 'Vie 7 Agosto 2026';

  @override
  String get mockDateSaturdaySeptember12 => 'Sáb 12 Septiembre 2026';

  @override
  String get mockDateSaturdayAugust22 => 'Sáb 22 Agosto 2026';

  @override
  String get mockLocationParqueBicentenario => 'Parque Bicentenario, Santiago';

  @override
  String get mockLocationTerrazaNeon => 'Terraza Neon, Santiago';

  @override
  String get mockLocationClubAmandaValparaiso => 'Club Amanda, Valparaíso';

  @override
  String get mockLocationMovistarArenaShort => 'Movistar Arena, Santiago';

  @override
  String get mockTime2200Hrs => '22:00 hrs';

  @override
  String get mockTime2300Hrs => '23:00 hrs';

  @override
  String get mockTime2130Hrs => '21:30 hrs';

  @override
  String get mockPriceFrom50000 => 'Desde \$50.000 CLP';

  @override
  String get mockLocationSkyCostanera => 'Sky Costanera';

  @override
  String get mockLocationClubOceano => 'Club Océano';

  @override
  String get mockDateSaturdayJuly4Short => 'Sáb 4 Julio 2026';

  @override
  String get mockDateFridayAugust7Short => 'Vie 7 Agosto 2026';

  @override
  String get mockDateSaturdaySeptember12Short => 'Sáb 12 Septiembre 2026';

  @override
  String get ticketAssignmentTitle => 'Asignar entradas';

  @override
  String get ticketAssignmentHeading => 'Asigna las entradas';

  @override
  String ticketAssignmentSlotLabel(int number) {
    return 'Entrada $number';
  }

  @override
  String ticketAssignmentSummarySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas disponibles • Puedes hacerlo en partes',
      one: '1 entrada disponible • Puedes hacerlo en partes',
    );
    return '$_temp0';
  }

  @override
  String ticketAssignmentAvailableCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas disponibles para asignar',
      one: '1 entrada disponible para asignar',
    );
    return '$_temp0';
  }

  @override
  String ticketAssignmentPendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pendientes',
      one: '1 pendiente',
    );
    return '$_temp0';
  }

  @override
  String get ticketAssignmentOwnerTicket => 'Tu entrada';

  @override
  String get ticketAssignmentClaimedTicket => 'Entrada reclamada';

  @override
  String get ticketAssignmentPendingBadge => 'PENDIENTE';

  @override
  String get ticketAssignmentAvailableBadge => 'DISPONIBLE';

  @override
  String get ticketAssignmentGuestNameLabel => 'Nombre del invitado';

  @override
  String get ticketAssignmentGuestNameHint => 'Nombre completo';

  @override
  String get ticketAssignmentGuestPhoneLabel => 'Teléfono del invitado';

  @override
  String get ticketAssignmentGuestPhoneHint => 'Teléfono (ej. +56 9 1234 5678)';

  @override
  String get ticketAssignmentPickContact => 'Buscar desde contactos';

  @override
  String get ticketAssignmentSendTicket => 'Enviar entrada';

  @override
  String get ticketAssignmentCancelTicket => 'Cancelar entrada';

  @override
  String get ticketAssignmentResendWhatsApp => 'Reenviar WhatsApp';

  @override
  String get ticketAssignmentSentSuccess => 'Invitación enviada por WhatsApp';

  @override
  String get ticketAssignmentContactsPermissionDenied =>
      'Se requiere permiso de contactos para elegir un invitado';

  @override
  String get ticketAssignmentMissingOrder =>
      'Esta entrada aún no se puede asignar';

  @override
  String get ticketAssignmentNoAssignableTickets =>
      'No hay entradas disponibles para asignar en este momento';

  @override
  String get ticketAssignmentRetry => 'Reintentar';

  @override
  String get ticketAssignmentWhatsAppInfo =>
      'Se enviará un link con instrucciones para descargar y registrarse en YouPass a través de WhatsApp, una vez les envíes la entrada.';

  @override
  String get ticketAssignmentPrivacyNote =>
      'Tus datos y los de tus invitados están protegidos';

  @override
  String get invitationClaimTitle => 'Tienes una invitación de entrada';

  @override
  String get invitationClaimGuestLabel => 'Invitado';

  @override
  String get invitationClaimInvitedByLabel => 'Invitado por';

  @override
  String get invitationClaimStepsTitle => 'Cómo reclamar tu entrada';

  @override
  String get invitationClaimOpenInvitations => 'Abrir Invitaciones';

  @override
  String get invitationClaimLoginRegister => 'Iniciar sesión o registrarse';
}
