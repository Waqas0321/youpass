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
  String get homeEventsEndOfList => 'Has visto todos los eventos disponibles.';

  @override
  String get homeNearMeButton => 'Ver eventos cerca de mi ubicación';

  @override
  String get homeNearMeHeaderLink => 'Cercanos';

  @override
  String homeEventDistanceKm(String distance) {
    return '$distance km';
  }

  @override
  String homeEventTravelMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get homeNearMePermissionDenied =>
      'Se necesita permiso de ubicación para mostrar eventos cercanos.';

  @override
  String get homeNearMeLocationDisabled =>
      'Activa los servicios de ubicación para encontrar eventos cerca de ti.';

  @override
  String get homeSearchPlaceholder => 'Buscar eventos por nombre';

  @override
  String get homeSearchEmpty => 'No encontramos eventos con ese término.';

  @override
  String get homeSearchRecentTitle => 'Búsquedas recientes';

  @override
  String get homeSearchClearHistory => 'Borrar';

  @override
  String get homeSearchSuggestionsTitle => 'Sugerencias';

  @override
  String get homeFiltersTitle => 'Filtros';

  @override
  String get homeFiltersDate => 'Fecha';

  @override
  String get homeFiltersPrice => 'Precio';

  @override
  String get homeFiltersCityZone => 'Ciudad / Zona';

  @override
  String get homeFiltersVenueType => 'Tipo de venue';

  @override
  String get homeFiltersFreeOnly => 'Solo eventos gratis';

  @override
  String get homeFiltersCityLabel => 'Ciudad';

  @override
  String get homeFiltersZoneLabel => 'Barrio';

  @override
  String get homeFiltersClear => 'Limpiar filtros';

  @override
  String get homeFiltersApply => 'Aplicar';

  @override
  String homeFiltersApplyCount(int count) {
    return 'Aplicar ($count)';
  }

  @override
  String get homeFiltersCustomRange => 'Rango personalizado';

  @override
  String homeFiltersDateFrom(String date) {
    return 'Desde $date';
  }

  @override
  String homeFiltersDateUntil(String date) {
    return 'Hasta $date';
  }

  @override
  String homeFiltersDateRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get homeFiltersAllCities => 'Todas las ciudades';

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
      'Tus productoras favoritas aparecerán aquí';

  @override
  String get favoritesEventsSearchHint => 'Buscar productora';

  @override
  String get favoritesEventsEmpty =>
      'Aún no sigues ninguna productora. Síguela desde el detalle de un evento.';

  @override
  String favoritesSavedEventsCount(int count) {
    return '$count eventos guardados';
  }

  @override
  String get seeAll => 'Ver todos';

  @override
  String get buyTickets => 'COMPRAR ENTRADAS';

  @override
  String get eventDetailTitle => 'Detalle del evento';

  @override
  String get eventDetailAboutSection => 'Sobre este evento';

  @override
  String get eventDetailAboutHeading => 'SOBRE EL EVENTO';

  @override
  String get eventDetailReadMore => 'Ver más';

  @override
  String get eventDetailReadLess => 'Leer menos';

  @override
  String get eventDetailBuyTicketsLabel => 'Comprar entradas';

  @override
  String get eventDetailSoldOut => 'Agotado';

  @override
  String get eventDetailPromoterLabel => 'Promotora';

  @override
  String eventDetailFollowPromoter(String name) {
    return 'Ahora sigues a $name';
  }

  @override
  String eventDetailUnfollowPromoter(String name) {
    return 'Dejaste de seguir a $name';
  }

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
  String get errorWhatsAppRequired =>
      'Este número no puede recibir WhatsApp. YouPass usa solo WhatsApp Business para la verificación.';

  @override
  String otpCodeExpiresIn(int seconds) {
    return 'El código expira en ${seconds}s';
  }

  @override
  String get phoneChangeSuccess =>
      'Número de teléfono actualizado correctamente.';

  @override
  String get errorInvalidCode => 'Código inválido. Solicita uno nuevo.';

  @override
  String get errorIncorrectCode => 'Código incorrecto';

  @override
  String errorIncorrectCodeRemaining(int attempts) {
    return 'Código incorrecto. Te quedan $attempts intento(s).';
  }

  @override
  String errorBlockedCountdown(int seconds) {
    return 'Demasiados intentos fallidos. Inténtalo en $seconds segundos.';
  }

  @override
  String errorMaxResendsCountdown(int seconds) {
    return 'Demasiados reenvíos. Inténtalo en $seconds segundos.';
  }

  @override
  String get errorRecaptchaFailed =>
      'La verificación de seguridad falló. Inténtalo de nuevo.';

  @override
  String get errorCardTokenizationRequired =>
      'Los datos de la tarjeta deben tokenizarse. Usa el formulario de pago seguro.';

  @override
  String changePhoneOtpMessage(String phone) {
    return 'Ingresa el código que enviamos a tu NUEVO número de WhatsApp $phone.';
  }

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
  String get termsAnd => 'y la';

  @override
  String get privacyLink => 'política de privacidad';

  @override
  String get createAccountButton => 'CREAR CUENTA';

  @override
  String get alreadyHaveAccountQuestion => '¿YA TIENES CUENTA?';

  @override
  String get signInLink => 'INICIAR SESIÓN';

  @override
  String get drawerMyProfile => 'Mi Perfil';

  @override
  String get drawerHome => 'Inicio';

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
  String get drawerTierBronze => 'BRONZE';

  @override
  String get drawerTierSilver => 'SILVER';

  @override
  String get drawerTierGold => 'GOLD';

  @override
  String get drawerTierPlatinum => 'PLATINUM';

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
  String get profilePhone => 'TELÉFONO';

  @override
  String get profileChangePhone => 'Cambiar número';

  @override
  String get changePhoneTitle => 'Cambiar teléfono';

  @override
  String get changePhoneSubtitle =>
      'Ingresa tu nuevo número. Enviaremos un código de verificación a tu NUEVO WhatsApp.';

  @override
  String get changePhoneCurrentLabel => 'Número actual';

  @override
  String get changePhoneNewLabel => 'Nuevo número';

  @override
  String get changePhoneContinueButton => 'Enviar código de verificación';

  @override
  String get changePhoneSameNumber => 'Ese ya es tu número actual.';

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
  String get profileSetDefaultCard => 'Establecer como predeterminada';

  @override
  String get profileDeleteCard => 'Eliminar tarjeta';

  @override
  String get profileDefaultCardUpdated =>
      'Método de pago predeterminado actualizado';

  @override
  String get profileViewFullWallet => 'Ver billetera completa';

  @override
  String get profileWalletAvailableBalance => 'Saldo disponible';

  @override
  String profileWalletCredits(String amount) {
    return '$amount créditos';
  }

  @override
  String get profileWalletTransactionHistory => 'Historial de transacciones';

  @override
  String get profileWalletNoTransactions => 'Aún no hay transacciones';

  @override
  String get profileWalletDefaultDeleteRequired =>
      'Elige una nueva tarjeta predeterminada antes de eliminar esta';

  @override
  String get profileWalletSelectNewDefault =>
      'Seleccionar nueva predeterminada';

  @override
  String get profileWalletAddCard => 'Agregar nueva tarjeta';

  @override
  String get profileNotifications => 'NOTIFICACIONES';

  @override
  String get profileReceiveNotifications => 'Recibir notificaciones';

  @override
  String get profileNotificationChannels => 'Email · Push · WhatsApp';

  @override
  String get profileNotificationChannelEmail => 'Email';

  @override
  String get profileNotificationChannelEmailDesc =>
      'Comunicaciones formales, confirmaciones de pedido, recibos y recordatorios largos';

  @override
  String get profileNotificationChannelPush => 'Notificación push';

  @override
  String get profileNotificationChannelPushDesc =>
      'Alertas en tiempo real, invitaciones, recordatorios cortos y actualizaciones urgentes';

  @override
  String get profileNotificationChannelWhatsApp => 'WhatsApp';

  @override
  String get profileNotificationChannelWhatsAppDesc =>
      'Mensajes del bot, invitaciones, enlaces de pago y actualizaciones conversacionales';

  @override
  String get profileNotificationAdvancedSettings => 'Configuración avanzada';

  @override
  String get profileNotificationCriticalDisclaimer =>
      'Estas notificaciones no se pueden desactivar porque son esenciales para tu experiencia.';

  @override
  String get profileNotificationAdvancedTitle =>
      'Configuración avanzada de notificaciones';

  @override
  String get profileNotificationByType => 'Por tipo';

  @override
  String get profileNotificationTypePurchases => 'Compras';

  @override
  String get profileNotificationTypeReminders => 'Recordatorios';

  @override
  String get profileNotificationTypePromotions => 'Promociones';

  @override
  String get profileNotificationTypeSocial => 'Social';

  @override
  String get profileNotificationByChannel => 'Por canal';

  @override
  String get profileNotificationNightSilence => 'Silencio nocturno';

  @override
  String get profileNotificationNightSilenceDesc =>
      'Sin notificaciones push después de la hora seleccionada (tu zona horaria local)';

  @override
  String get profileNotificationNightSilenceFrom => 'Silenciar push desde';

  @override
  String get profileNotificationCriticalTitle => 'Notificaciones críticas';

  @override
  String get profileNotificationCriticalEventCancellation =>
      'Cancelación de evento';

  @override
  String get profileNotificationCriticalEventDatetime =>
      'Cambio de fecha u hora del evento';

  @override
  String get profileNotificationCriticalEventVenue =>
      'Cambio de lugar o venue del evento';

  @override
  String get profileNotificationCriticalSecurity =>
      'Alertas de seguridad críticas';

  @override
  String get profileNotificationCriticalPaymentReceipts =>
      'Recibos de pago / confirmaciones de compra';

  @override
  String get profileNotificationCriticalRefunds => 'Reembolsos procesados';

  @override
  String get profileNotificationUpdateFailed =>
      'No se pudieron actualizar las notificaciones. Inténtalo de nuevo.';

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
  String get profileDeleteInfoIntro =>
      'Se eliminará permanentemente lo siguiente:';

  @override
  String get profileDeleteItemPersonalData => 'Datos personales';

  @override
  String get profileDeleteItemTickets => 'Entradas activas y futuras';

  @override
  String get profileDeleteItemPaymentMethods => 'Métodos de pago';

  @override
  String get profileDeleteItemPoints => 'Puntos acumulados';

  @override
  String get profileDeleteItemHistory => 'Historial completo';

  @override
  String get profileDeleteIrreversibleWarning =>
      'Esta acción es IRREVERSIBLE después de 7 días.';

  @override
  String get accountDeletionBiometricReason =>
      'Confirma tu identidad para continuar con la eliminación de cuenta';

  @override
  String get accountDeletionBiometricFailed =>
      'Autenticación fallida. No se inició la eliminación de cuenta.';

  @override
  String get accountDeletionPendingBannerTitle =>
      'Cuenta pendiente de eliminación';

  @override
  String accountDeletionPendingBannerSubtitle(String date, int days) {
    return 'Tu cuenta se eliminará el $date ($days días restantes). Toca para cancelar.';
  }

  @override
  String get accountDeletionCancelAction => 'Cancelar eliminación';

  @override
  String get accountDeletionCancelled => 'Tu cuenta YOUPASS sigue activa.';

  @override
  String get profilePhotoUpdated => 'Foto de perfil actualizada';

  @override
  String get profileCompleteBannerTitle => 'Completa tu perfil';

  @override
  String get profileCompleteBannerSubtitleBoth =>
      'Agrega tu foto e Instagram para personalizar tu experiencia';

  @override
  String get profileCompleteBannerSubtitlePhoto =>
      'Agrega tu foto de perfil para ser mejor identificado';

  @override
  String get profileCompleteBannerSubtitleInstagram =>
      'Agrega tu Instagram para conectar con otros asistentes';

  @override
  String get profileCompleteBannerButton => 'COMPLETAR';

  @override
  String get profilePhotoChooseSource => 'Cambiar foto de perfil';

  @override
  String get profilePhotoTake => 'Tomar foto';

  @override
  String get profilePhotoGallery => 'Elegir de la galería';

  @override
  String get profileNotAdded => 'No agregado';

  @override
  String get profileEditTitle => 'Editar datos';

  @override
  String get profileSave => 'Guardar';

  @override
  String get profileSaved => 'Datos actualizados correctamente';

  @override
  String get profileGenderFemaleValue => 'Mujer';

  @override
  String get profileGenderOtherValue => 'Otro';

  @override
  String get profileGenderPreferNotSayValue => 'Prefiero no decir';

  @override
  String get profileCategoryBenefits => 'Mis beneficios';

  @override
  String get profileFaqTitle => 'Preguntas frecuentes';

  @override
  String get profileFaqSearch => 'Buscar';

  @override
  String get profileFaqHelpful => '¿Te fue útil?';

  @override
  String get profileFaqYes => 'Sí';

  @override
  String get profileFaqNo => 'No';

  @override
  String get profileFaqNoResults =>
      'No encontramos una respuesta. Contáctanos directamente.';

  @override
  String get profileFaqContactWhatsApp => 'Contactar por WhatsApp';

  @override
  String get profileFaqContactEmail => 'Enviar correo';

  @override
  String get profileWhatsAppNotInstalled =>
      'WhatsApp no está instalado en este dispositivo. Por favor contáctanos por correo.';

  @override
  String get profileDeleteInfoTitle => 'Eliminar cuenta';

  @override
  String get profileDeleteInfoMessage =>
      'Se eliminarán tus datos personales, entradas activas y futuras, métodos de pago, puntos acumulados e historial. Esta acción es IRREVERSIBLE después de 7 días.';

  @override
  String get profileDeleteContinue => 'Continuar con eliminación';

  @override
  String profileDeletePendingMessage(int days) {
    return 'Tu cuenta se eliminará en $days días. ¿Deseas cancelar?';
  }

  @override
  String get profileEmailSubject => 'Consulta YouPass';

  @override
  String get profileAdvancedNotifications => 'Configuración avanzada';

  @override
  String get confirmDialogCancel => 'Cancelar';

  @override
  String get confirmLogoutTitle => '¿Seguro que quieres cerrar sesión?';

  @override
  String get confirmLogoutMessage =>
      'Tu cuenta, entradas, billetera y puntos se conservarán. Puedes volver a iniciar sesión en cualquier momento con tu teléfono y código OTP.';

  @override
  String get confirmLogoutAction => 'Sí, cerrar sesión';

  @override
  String get confirmDeleteAccountTitle => '¿Eliminar tu cuenta?';

  @override
  String get confirmDeleteAccountMessage =>
      'Esto elimina permanentemente tu cuenta, entradas y datos de perfil. Enviaremos un código de verificación para confirmar.';

  @override
  String get confirmDeleteAccountAction => 'Continuar';

  @override
  String get ticketsTabUpcoming => 'Activas / Próximas';

  @override
  String get ticketsTabPast => 'Historial';

  @override
  String get ticketsStatusActive => 'ACTIVO';

  @override
  String get ticketsStatusValidated => 'VALIDADO';

  @override
  String get ticketsStatusExpired => 'EXPIRADO';

  @override
  String get ticketsStatusCancelled => 'CANCELADO';

  @override
  String get ticketsStatusRefunded => 'REEMBOLSADO';

  @override
  String get ticketsInvitationPending => 'INVITACIÓN';

  @override
  String ticketsInvitationExpires(String deadline) {
    return 'Responde antes del $deadline';
  }

  @override
  String ticketsQrCountdown(String eventDate) {
    return 'Tu QR estará disponible el $eventDate';
  }

  @override
  String get ticketsQrUnavailable => 'QR BLOQUEADO';

  @override
  String get ticketsCancelTicket => 'Cancelar entrada';

  @override
  String get ticketsCancelTicketTitle => '¿Cancelar esta entrada?';

  @override
  String get ticketsCancelTicketMessage =>
      'Tu entrada se cancelará y se procesará un reembolso automático cuando corresponda.';

  @override
  String get ticketsCancelTicketConfirm => 'Sí, cancelar';

  @override
  String get ticketsCancelTicketSuccess =>
      'Entrada cancelada. El reembolso se está procesando.';

  @override
  String get bottomNavHome => 'Inicio';

  @override
  String get bottomNavInvitations => 'Invitaciones';

  @override
  String get bottomNavTickets => 'Entradas';

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
  String favoritesFollowerCount(String count) {
    return '$count seguidores';
  }

  @override
  String get favoritesNoSearchResults =>
      'No se encontraron productoras que coincidan con tu búsqueda';

  @override
  String get favoritesExploreCta => 'Explorar eventos';

  @override
  String get favoritesSectionFollowedPromoters => 'PRODUCTORAS SEGUIDAS';

  @override
  String get favoritesSectionSavedEvents => 'EVENTOS GUARDADOS';

  @override
  String get producerEventPresale => 'PREVENTA';

  @override
  String get producerEventPrepay => 'PREPAGO';

  @override
  String get producerEventsUpcomingTitle => 'PRÓXIMOS EVENTOS';

  @override
  String producerEventsUpcomingSubtitle(String producerName) {
    return 'Descubre los próximos eventos de $producerName';
  }

  @override
  String get producerEventsSearchHint => 'Buscar evento';

  @override
  String get producerEventsEmpty =>
      'Esta productora no tiene eventos próximos por ahora.';

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
  String get invitationsSearchHint => 'Buscar invitación / Evento / productora';

  @override
  String get invitationsFiltersLabel => 'FILTROS';

  @override
  String get invitationsFilterCourtesy => 'Cortesías';

  @override
  String get invitationsFilterAll => 'Todos';

  @override
  String get invitationsFilterFree => 'Gratis';

  @override
  String get invitationsFilterGuaranteedPass => 'Pase Garantizado';

  @override
  String get invitationsFilterDiscounted => 'Con descuento';

  @override
  String get invitationsTypeFree => 'Invitación gratis';

  @override
  String get invitationsTypeGuaranteedPass => 'Pase garantizado';

  @override
  String get invitationsTypeDiscounted => 'Invitación con descuento';

  @override
  String get invitationsGuaranteedPassTitle => 'Pase garantizado';

  @override
  String invitationsGuaranteedPassMessage(String deadline, String amount) {
    return 'Este pase es GRATIS si asistes. Si no asistes y no cancelas antes del $deadline, se cobrará $amount a tu tarjeta.';
  }

  @override
  String get invitationsGuaranteedPassTerms =>
      'Entiendo el compromiso de asistencia y el posible cobro';

  @override
  String get invitationsGpTermsRequired =>
      'Debes aceptar los términos para continuar';

  @override
  String invitationsPreauthNotice(String amount) {
    return 'Se preautorizará tu tarjeta por $amount. Solo se cobrará si no asistes.';
  }

  @override
  String get invitationsDiscountedPayTitle => 'Invitación con descuento';

  @override
  String invitationsDiscountedPayMessage(String amount) {
    return 'Paga $amount ahora para aceptar esta invitación.';
  }

  @override
  String invitationsDiscountPercent(int percent) {
    return '$percent% de descuento';
  }

  @override
  String invitationsCancelBy(String deadline) {
    return 'Cancelar antes del $deadline';
  }

  @override
  String get invitationsAcceptGuaranteed => 'ACEPTAR Y RESERVAR';

  @override
  String get invitationsAcceptAndReserve => 'ACEPTAR Y RESERVAR';

  @override
  String get invitationsGuaranteedPassDetailTitle => 'Pase Garantizado';

  @override
  String get invitationsDetailTitle => 'Detalle de invitación';

  @override
  String get invitationsGuaranteedBadge => 'GARANTIZADO';

  @override
  String invitationsAssignedSlot(String slot) {
    return 'Mesa/lugar: $slot';
  }

  @override
  String invitationsPassStatus(String status) {
    return 'Estado: $status';
  }

  @override
  String get invitationsGpWarningTitle => '⚠ IMPORTANTE';

  @override
  String invitationsGpWarningBody(String amount, String deadline) {
    return 'Si asistes: 100% GRATIS\nSi no asistes: se cobrará $amount a tu tarjeta\n\nPLAZO DE CANCELACIÓN\nHasta $deadline sin cargo\n\nAl aceptar, autorizas el cobro a tu tarjeta si no asistes al evento.';
  }

  @override
  String get invitationsBiometricReason =>
      'Confirma la aceptación de tu Pase Garantizado';

  @override
  String get invitationsGpPaymentRequired =>
      'Debes agregar un método de pago para aceptar un Pase Garantizado';

  @override
  String get invitationsGpActiveTitle => 'Pase Garantizado activo';

  @override
  String invitationsGpActiveMessage(String event, String deadline) {
    return 'Tu pase a $event está reservado. Cancela antes de $deadline sin cargo.';
  }

  @override
  String get invitationsGpActiveCta => 'Ir a Mis Entradas';

  @override
  String get invitationsCancelInvitation => 'Cancelar invitación';

  @override
  String get invitationsGpCancelTitle => '¿Cancelar tu Pase Garantizado?';

  @override
  String get invitationsGpCancelMessage =>
      'La retención de tu tarjeta se liberará de inmediato. Esta acción no se puede deshacer.';

  @override
  String get invitationsGpCancelConfirm => 'Sí, cancelar';

  @override
  String get invitationsGpCancelSuccess =>
      'Tu Pase Garantizado fue cancelado sin cargo.';

  @override
  String get invitationsAcceptDiscounted => 'PAGAR Y ACEPTAR';

  @override
  String get invitationsFilterGeneral => 'General';

  @override
  String get invitationsFilterVip => 'VIP';

  @override
  String get invitationsFilterTables => 'Mesas';

  @override
  String get invitationsTierVipDj => 'VIP DJ';

  @override
  String get invitationsTierVip => 'VIP';

  @override
  String get invitationsTierVipMesa => 'VIP Mesa';

  @override
  String get invitationsTierGeneral => 'General';

  @override
  String invitationsInvitedBy(String name) {
    return 'Invitado por $name';
  }

  @override
  String invitationsAcceptBy(String deadline) {
    return 'Aceptar antes del $deadline';
  }

  @override
  String invitationsStatusLine(String status) {
    return 'Estado: $status';
  }

  @override
  String get invitationsStatusPrefix => 'Estado:';

  @override
  String get invitationsStatusPending => 'Pendiente';

  @override
  String get invitationsStatusConfirmed => 'Confirmada';

  @override
  String get invitationsStatusRejected => 'Rechazado';

  @override
  String get invitationsConfirmAttendance => 'CONFIRMAR ASISTENCIA';

  @override
  String get invitationsTabPending => 'Pendientes';

  @override
  String get invitationsTabConfirmed => 'Confirmadas';

  @override
  String get invitationsEmptyNone => 'Aún no tienes invitaciones.';

  @override
  String get invitationsEmptySearch =>
      'No se encontraron invitaciones para esa búsqueda.';

  @override
  String get invitationsEmptyPending => 'No tienes invitaciones pendientes.';

  @override
  String get invitationsEmptyConfirmed =>
      'Aún no tienes invitaciones confirmadas.';

  @override
  String get invitationsRejectConfirmTitle => '¿Rechazar invitación?';

  @override
  String get invitationsRejectConfirmMessage =>
      '¿Estás seguro de que deseas rechazar esta invitación?';

  @override
  String get invitationsRejectConfirmAction => 'RECHAZAR';

  @override
  String get invitationsCancellationDeadlinePassed =>
      'El plazo de cancelación ha vencido';

  @override
  String get invitationsWaitingConfirmation => 'Esperando confirmación…';

  @override
  String invitationsQrAvailableOn(String date) {
    return 'Tu QR estará disponible el $date';
  }

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
  String get invitationsImportantTitle => 'Importante ⚠';

  @override
  String get invitationsImportantMessage =>
      'Al confirmar tu asistencia, tu entrada quedará reservada exclusivamente para ti. En caso de no asistir al evento, podrá cobrarse el valor total de la entrada, si esta condición aplica.';

  @override
  String get invitationsAddPaymentMethod => 'AGREGAR MEDIO DE PAGO';

  @override
  String get invitationsDialogCancel => 'CANCELAR';

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
  String get invitationsPaymentSecureNote =>
      'Tu información está protegida y será utilizada de forma segura.';

  @override
  String get invitationsSaveCard => 'GUARDAR TARJETA';

  @override
  String get invitationsCardSavedTitle => '¡Tarjeta guardada con éxito!';

  @override
  String get invitationsCardSavedMessage =>
      'Tu medio de pago ha sido registrado correctamente. Recuerda lo siguiente:';

  @override
  String get invitationsCardSavedReminderCharge =>
      'Si confirmas tu asistencia y no te presentas al evento, se te cobrará el valor total de la entrada.';

  @override
  String get invitationsCardSavedReminderCancel =>
      'Si deseas anular tu asistencia, debes hacerlo con al menos 48 horas de anticipación para evitar el cobro.';

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
  String get ticketAssignmentSearchGuestTitle => 'Buscar invitado';

  @override
  String get ticketAssignmentSearchGuestSubtitle =>
      'Busca usuarios registrados en YouPass por nombre o teléfono. Si no está registrado, ingresa sus datos manualmente en la tarjeta.';

  @override
  String get ticketAssignmentSearchGuestHint => 'Nombre o teléfono';

  @override
  String get ticketAssignmentSearchGuestEmpty =>
      'No encontramos un usuario registrado. Puedes escribir nombre y teléfono manualmente y enviar la invitación por WhatsApp.';

  @override
  String get ticketAssignmentSearchGuestManualHint =>
      'Cierra este panel para escribir los datos manualmente en la tarjeta.';

  @override
  String get ticketAssignmentRegisteredBadge => 'YouPass';

  @override
  String get ticketAssignmentSendTicket => 'Enviar entrada';

  @override
  String get ticketAssignmentCancelTicket => 'Cancelar entrada';

  @override
  String get ticketAssignmentResendWhatsApp => 'Reenviar WhatsApp';

  @override
  String get ticketAssignmentSentSuccess =>
      'WhatsApp se abrió — toca Enviar para entregar la invitación';

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
      'Al enviar la entrada, WhatsApp se abrirá con el número de tu invitado y un mensaje prellenado. Toca Enviar en WhatsApp para entregar el link de invitación.';

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

  @override
  String get vipTicketSelectionTitle => 'Comprar entradas';

  @override
  String get vipTicketSelectionHeading => 'Elige tu entrada';

  @override
  String get vipSectionGeneralTickets => 'ENTRADAS GENERALES';

  @override
  String get vipSectionVipTables => 'MESAS VIP';

  @override
  String get vipSectionVipTickets => 'ENTRADAS VIP';

  @override
  String get vipOfferingPreventa1 => 'PREVENTA 1';

  @override
  String get vipOfferingPreventa2 => 'PREVENTA 2';

  @override
  String get vipOfferingGeneralCover => 'GENERAL + COVER';

  @override
  String get vipOfferingVipGeneral => 'VIP GENERAL';

  @override
  String get vipOfferingWithoutTable => 'Sin mesa';

  @override
  String get vipOfferingGeneralAccessDescription => 'Acceso general al evento';

  @override
  String vipTicketCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas',
      one: '1 entrada',
    );
    return '$_temp0';
  }

  @override
  String vipTicketSelectionSummaryLine(String ticketCount, String amount) {
    return '$ticketCount • $amount';
  }

  @override
  String get vipBackButton => 'Volver';

  @override
  String get vipContinueButton => 'Continuar';

  @override
  String vipContinueWithTickets(String ticketCount) {
    return 'Continuar - $ticketCount';
  }

  @override
  String vipContinueWithAmount(String amount) {
    return 'Continuar · $amount';
  }

  @override
  String get vipTicketSoldOutBadge => 'Agotado';

  @override
  String get vipTicketsNoneAvailable =>
      'No hay entradas disponibles para este evento.';

  @override
  String get vipTicketsAllSoldOut =>
      'Todas las entradas de este evento están agotadas.';

  @override
  String get errorCheckoutInsufficientStock =>
      'No hay suficientes entradas. Reduce la cantidad o elige otra opción.';

  @override
  String get errorCheckoutOfferingSoldOut =>
      'Esta opción se acaba de agotar. Elige otra.';

  @override
  String get errorCheckoutTableLockRequired =>
      'Tu reserva de mesa expiró. Vuelve a reservar la mesa.';

  @override
  String get errorCheckoutTableNotAvailable =>
      'Esta mesa ya no está disponible.';

  @override
  String get errorCheckoutTableLocked =>
      'Esta mesa está reservada por otro usuario.';

  @override
  String get errorCheckoutOfferingNotFound =>
      'Esta opción de entrada ya no está disponible.';

  @override
  String get vipSecurePayment => 'Pago 100% seguro';

  @override
  String get vipOfferingGeneral => 'GENERAL - COMÚN';

  @override
  String get vipMesasVipTitle => 'Mesas VIP';

  @override
  String get vipMesasVipSubtitle => 'Elige tu mesa →';

  @override
  String get vipFloorPlanTitle => 'Plano del salón';

  @override
  String get vipFloorPlanHeading => 'Plano del salón';

  @override
  String get vipFloorPlanVenueName => 'Salón principal';

  @override
  String get vipFloorPlanSize => '36 x 18 m';

  @override
  String vipFloorPlanSubtitle(String venue, String size) {
    return '$venue • $size';
  }

  @override
  String get vipFloorPlanDimensions => 'Salón principal - 36 x 18 m';

  @override
  String get vipTapVipZoneTitle => 'Toca una zona VIP';

  @override
  String get vipTapVipZoneSubtitle =>
      'Selecciona una zona para ver las mesas disponibles';

  @override
  String get vipYouFestBrand => 'YouFest';

  @override
  String get vipLegendAvailable => 'Disponible';

  @override
  String get vipLegendPremium => 'Premium';

  @override
  String get vipLegendSold => 'Vendido';

  @override
  String get vipZone1Name => 'VIP 1';

  @override
  String get vipZone2Name => 'VIP 2';

  @override
  String get vipZoneDj => 'VIP DJ';

  @override
  String get vipZoneStage => 'ESCENARIO DJ';

  @override
  String get vipZoneDanceFloor => 'PISTA DE BAILE';

  @override
  String get vipZoneLabel => 'ZONA';

  @override
  String vipZoneCapacity(int count) {
    return '$count cupos/mesa';
  }

  @override
  String get vipEmergencyExit => 'SALIDA EMERGENCIA';

  @override
  String get vipLegendAvailableShort => 'Disp.';

  @override
  String get vipLegendUnselected => 'Sin seleccionar';

  @override
  String get vipDanceFloorGeneral => 'General';

  @override
  String vipTableDistributionTitle(String zone) {
    return 'DISTRIBUCIÓN $zone';
  }

  @override
  String get vipTableDistributionStage => 'Escenario DJ';

  @override
  String get vipLegendTableAvailable => 'Disponible';

  @override
  String get vipLegendTablePremium => 'Premium';

  @override
  String get vipLegendTableSelection => 'Seleccionada';

  @override
  String get vipLegendTableSold => 'Vendida';

  @override
  String vipZoneTablesScreenTitle(String zone) {
    return 'Mesas $zone';
  }

  @override
  String get vipTablesZoneSoldOut =>
      'Todas las mesas de esta zona están agotadas.';

  @override
  String get vipTablePremiumBadge => 'Premium';

  @override
  String get vipTablesZoneTitle => 'Mesas VIP 1';

  @override
  String vipTablesCapacitySubtitle(int count) {
    return '$count personas por mesa';
  }

  @override
  String vipPurchaseOfferingLine(String label, int quantity) {
    return '$label x$quantity';
  }

  @override
  String vipTableReserve(String table) {
    return 'Reservar Mesa $table';
  }

  @override
  String vipTableDetailTitle(String table, String zone) {
    return 'Mesa $table — $zone';
  }

  @override
  String vipTableCapacity(int count) {
    return '$count personas';
  }

  @override
  String vipTableIncludes(int bottles, int vouchers) {
    return '$bottles botellas · $vouchers vouchers';
  }

  @override
  String vipTableBottles(int count) {
    return '$count botellas';
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
  String get vipPurchaseSummaryTitle => 'Resumen de compra';

  @override
  String vipPurchaseSummaryItemTitle(String table, String zone, String event) {
    return 'Mesa $table - $zone | $event';
  }

  @override
  String get vipServiceFee => 'Servicio';

  @override
  String get vipPurchaseSubtotal => 'Subtotal';

  @override
  String get vipPurchaseServiceCharge => 'Cargo por servicio';

  @override
  String get vipGeneralAccessLabel => 'Acceso general';

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
  String get vipPaymentMethod => 'MEDIO DE PAGO';

  @override
  String get vipSavedCard => 'Visa terminada en 4205';

  @override
  String get vipAddPaymentMethod => 'Agregar medio de pago';

  @override
  String vipPurchaseAssignTicketsInfo(String myTickets) {
    return 'Después del pago, podrás asignar las entradas a tus invitados o hacerlo más tarde desde $myTickets.';
  }

  @override
  String vipPayButton(String amount) {
    return 'Pagar $amount';
  }

  @override
  String get vipPurchaseSuccessTitle => '¡Compra exitosa!';

  @override
  String get vipPurchaseSuccessMessage =>
      'Tus entradas ya están en Mis entradas.';

  @override
  String vipTableLockCountdown(String time) {
    return 'Completa el pago en $time';
  }

  @override
  String vipTableLockReservedCountdown(String time) {
    return 'Tu mesa está reservada por $time';
  }

  @override
  String get vipTableLockExpired =>
      'Tu reserva de mesa expiró. Selecciona una mesa nuevamente.';

  @override
  String get vipTableLockExpiredTitle => 'Tu reserva ha expirado';

  @override
  String get vipTableLockExpiredMessage =>
      'La mesa ha sido liberada. Vuelve al plano del recinto para seleccionar nuevamente.';

  @override
  String get vipTableLockExpiredReturnFloorPlan => 'Volver al plano';

  @override
  String get vipTableBlockedMessage =>
      'Esta mesa está siendo reservada. Intenta en unos minutos o elige otra mesa.';

  @override
  String get vipTableBlockedReserve =>
      'Esta mesa está siendo reservada. Intenta en unos minutos o elige otra mesa.';

  @override
  String get vipLegendTableBlocked => 'Bloqueada';

  @override
  String get eventDetailTicketsUnavailable =>
      'Las entradas aún no están disponibles para este evento.';

  @override
  String get vipViewQr => 'Ver QR';

  @override
  String get waitlistJoinButton => 'Unirse a lista de espera';

  @override
  String get waitlistLeaveButton => 'Salir de lista de espera';

  @override
  String get waitlistJoinTitle => 'Unirse a lista de espera';

  @override
  String get waitlistJoinConfirm => 'Confirmar ingreso';

  @override
  String waitlistJoinSuccess(String eventName) {
    return 'Estás en la lista de espera para $eventName. Te avisaremos de inmediato si se libera un cupo.';
  }

  @override
  String waitlistEstimatedPosition(String position) {
    return 'Eres el #$position en la lista de espera';
  }

  @override
  String get waitlistLeaveTitle => '¿Salir de la lista de espera?';

  @override
  String get waitlistLeaveMessage =>
      '¿Estás seguro? Perderás tu posición en la fila.';

  @override
  String get waitlistLeaveConfirm => 'Salir de la lista';

  @override
  String get waitlistClaimSlot => 'RECLAMAR MI CUPO';

  @override
  String waitlistOfferBanner(String time) {
    return '¡Hay un cupo para ti! Confirma antes de $time';
  }
}
