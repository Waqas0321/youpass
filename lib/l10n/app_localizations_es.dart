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
  String get otpWhatsAppHelp =>
      '¿No recibiste el código? Asegúrate de tener WhatsApp instalado. YouPass usa WhatsApp para enviar códigos de seguridad. Si tienes problemas, contacta a soporte: soporte@youpass.app';

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
  String get homeLocationSheetTitle => 'Elige ubicación';

  @override
  String get homeLocationSheetSubtitle =>
      'Usa tu ubicación actual o escribe una ciudad para actualizar los eventos.';

  @override
  String get homeLocationUseCurrent => 'Usar mi ubicación actual';

  @override
  String get homeLocationTypeHint => 'Escribe una ciudad o zona';

  @override
  String get homeLocationApply => 'Aplicar ubicación';

  @override
  String get homeLocationClear => 'Quitar ubicación';

  @override
  String get homeLocationActiveNearby => 'Cercanos';

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
  String get drawerDrinkMenu => 'Carta de tragos';

  @override
  String get drawerMyPurchases => 'Mis compras';

  @override
  String get partyModeUnavailable =>
      'El Modo Fiesta se activa cuando tienes una entrada escaneada en un evento en curso.';

  @override
  String get partyModeNeedTicket =>
      'Compra una entrada primero para activar el Modo Fiesta.';

  @override
  String get partyModeNeedScan =>
      'Haz escanear tu entrada en la puerta para activar el Modo Fiesta.';

  @override
  String get partyModeNeedLocation =>
      'Acércate al lugar del evento para activar el Modo Fiesta.';

  @override
  String get partyDrinkMenuEmpty =>
      'La carta de tragos de este evento estará disponible pronto.';

  @override
  String get partyDrinkMenuSubtitle => 'Elige una categoría para explorar';

  @override
  String get partyDrinkEventChooserTitle => '¿Qué carta de tragos?';

  @override
  String get partyDrinkEventChooserSubtitle =>
      'Tienes entradas para más de un evento. Elige qué carta abrir.';

  @override
  String get partyDrinkEventChooserRecommended => 'Sugerido ahora';

  @override
  String get partyDrinkChangeEvent => 'Cambiar evento';

  @override
  String get partyDrinkCategoryAll => 'Todos';

  @override
  String get partyDrinkCategoryPiscos => 'Piscos';

  @override
  String get partyDrinkCategoryBeers => 'Cervezas';

  @override
  String get partyDrinkCategorySparkling => 'Espumantes';

  @override
  String get partyDrinkCategoryEnergy => 'Energético';

  @override
  String get partyDrinkQuickRecommendations => 'Recomendaciones rápidas';

  @override
  String get partyDrinkQuickRecommendationsSubtitle =>
      'Los más pedidos en YouFest';

  @override
  String get partyDrinkMockPiscola => 'Piscola';

  @override
  String get partyDrinkMockPiscolaDesc => 'Pisco + Bebida kola';

  @override
  String get partyDrinkMockJagerBomb => 'Jager Bomb';

  @override
  String get partyDrinkMockJagerBombDesc => 'Jägermeister + Red Bull';

  @override
  String get partyDrinkMockTropicalGin => 'Tropical Gin';

  @override
  String get partyDrinkMockTropicalGinDesc => 'Gin + Tónica + Frutas';

  @override
  String get partyDrinkMockCubaLibre => 'Cuba Libre';

  @override
  String get partyDrinkMockCubaLibreDesc => 'Ron + cola + limón';

  @override
  String get partyDrinkMockCorona => 'Corona';

  @override
  String get partyDrinkMockCoronaDesc => 'Cerveza lager mexicana';

  @override
  String get partyDrinkMockChandon => 'Chandon';

  @override
  String get partyDrinkMockChandonDesc => 'Botella de espumante';

  @override
  String partyDrinkVolumeMl(int volume) {
    return '$volume ml';
  }

  @override
  String get partyDrinkCheckoutPaymentMethod => 'Método de pago';

  @override
  String get partyDrinkCheckoutCreditCard => 'Tarjeta de crédito';

  @override
  String partyDrinkCheckoutCardMask(String last4) {
    return '**** $last4';
  }

  @override
  String partyDrinkCheckoutProducts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count productos',
      one: '1 producto',
    );
    return '$_temp0';
  }

  @override
  String get partyDrinkCheckoutBuy => 'COMPRAR';

  @override
  String get partyDrinkCheckoutSummaryTitle => 'Resumen de compra';

  @override
  String get partyDrinkCheckoutSummarySubtitle =>
      'Revisa tus productos antes de continuar.';

  @override
  String get partyDrinkCheckoutSubtotal => 'Subtotal';

  @override
  String get partyDrinkCheckoutServiceCharge => 'Cargo por servicio';

  @override
  String get partyDrinkCheckoutTotal => 'Total';

  @override
  String get partyDrinkCheckoutChangePayment => 'Cambiar';

  @override
  String get partyDrinkCheckoutCompletePurchase => 'Realizar compra';

  @override
  String get partyDrinkCheckoutSecurePayment => 'Pago 100% seguro';

  @override
  String get partyDrinkPurchaseSuccessTitle => '¡Compra realizada!';

  @override
  String get partyDrinkPurchaseSuccessSubtitle =>
      'Muestra este código en la barra para recibir tu trago.';

  @override
  String get partyDrinkQrAcceptedTitle => '¡QR aceptado!';

  @override
  String get partyDrinkQrAcceptedMessage =>
      'Tu código fue escaneado correctamente. ¡Disfruta!';

  @override
  String partyDrinkPurchaseValidity(String target) {
    return 'Este código es válido para $target.';
  }

  @override
  String get partyDrinkPurchaseShowBartender =>
      'Enséñalo al bartender para recibir tu pedido.';

  @override
  String get partyDrinkPurchasesTitle => 'MIS COMPRAS';

  @override
  String get partyDrinkPurchasesSubtitle =>
      'Revisa y canjea tus pedidos dentro del evento.';

  @override
  String get partyDrinkPurchasesTabPending => 'Por canjear';

  @override
  String get partyDrinkPurchasesTabUsed => 'Usados';

  @override
  String partyDrinkPurchasesOrderLabel(String id) {
    return 'Pedido $id';
  }

  @override
  String partyDrinkPurchasesQuantityLabel(int count, String name) {
    return '$count x $name';
  }

  @override
  String partyDrinkPurchasesBoughtAgo(String timeAgo) {
    return 'Comprado hace $timeAgo';
  }

  @override
  String partyDrinkPurchasesRedeemedAgo(String timeAgo) {
    return 'Canjeado hace $timeAgo';
  }

  @override
  String get partyDrinkPurchasesViewQr => 'VER QR';

  @override
  String get partyDrinkPurchasesRedeemedBadge => 'CANJEADO';

  @override
  String get partyDrinkPurchasesEmptyPending =>
      'No tienes tragos pendientes por canjear.';

  @override
  String get partyDrinkPurchasesEmptyUsed => 'Aún no tienes pedidos canjeados.';

  @override
  String get partyDrinkPurchasesQrUnavailable =>
      'El QR de este pedido ya no está disponible.';

  @override
  String get partyDrinkPurchasesJustNow => 'ahora';

  @override
  String partyDrinkPurchasesMinutesAgo(int count) {
    return '$count min';
  }

  @override
  String partyDrinkPurchasesHoursAgo(int count) {
    return '$count h';
  }

  @override
  String partyDrinkPurchasesDaysAgo(int count) {
    return '$count d';
  }

  @override
  String get partyDrinkCourtesiesTitle => 'MIS CORTESÍAS';

  @override
  String get partyDrinkCourtesiesSubtitle =>
      'Revisa y canjea tus cortesías dentro del evento.';

  @override
  String partyDrinkCourtesiesReceivedAgo(String timeAgo) {
    return 'Recibido hace $timeAgo';
  }

  @override
  String get partyDrinkCourtesiesEmptyPending =>
      'No tienes cortesías pendientes por canjear.';

  @override
  String get partyDrinkCourtesiesEmptyUsed =>
      'Aún no tienes cortesías canjeadas.';

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
  String profileSupportEmailMessage(String email) {
    return 'Escríbenos a soporte YouPass: $email';
  }

  @override
  String get profileSupportEmailCopy => 'Copiar correo';

  @override
  String get profileSupportEmailCopied => 'Correo copiado';

  @override
  String get profileSupportEmailOpen => 'Abrir app de correo';

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
  String profileUnlockTierTitle(String tier) {
    return 'Desbloquear $tier';
  }

  @override
  String profileUnlockTierButton(String tier) {
    return 'Consultar soporte sobre $tier';
  }

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
  String get confirmExitAppTitle => '¿Salir de YouPass?';

  @override
  String get confirmExitAppMessage =>
      '¿Seguro que quieres cerrar la aplicación?';

  @override
  String get confirmExitAppAction => 'Salir';

  @override
  String get confirmExitAppStay => 'Quedarme';

  @override
  String get ticketsTabUpcoming => 'PRÓXIMOS';

  @override
  String get ticketsTabPast => 'EVENTOS PASADOS';

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
  String get ticketsViewAssigned => 'VER ENTRADAS ASIGNADAS';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count productoras guardadas',
      one: '1 productora guardada',
    );
    return '$_temp0';
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
  String get invitationsTypeAssigned => 'Invitación';

  @override
  String get invitationsTypeVip => 'Invitación VIP';

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
  String get invitationsTierFree => 'Gratis';

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
  String ticketAssignmentClaimedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count aceptadas',
      one: '1 aceptada',
    );
    return '$_temp0';
  }

  @override
  String get ticketAssignmentSentSectionTitle => 'Invitaciones enviadas';

  @override
  String get ticketAssignmentSendNewSectionTitle => 'Enviar nuevas entradas';

  @override
  String ticketAssignmentSendNewSectionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tienes $count entradas listas para asignar a nuevos invitados.',
      one: 'Tienes 1 entrada lista para asignar a un nuevo invitado.',
    );
    return '$_temp0';
  }

  @override
  String get ticketAssignmentAcceptedBadge => 'ACEPTADA';

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
  String get vipPurchaseGoToMyTickets => 'Ir a mis entradas';

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

  @override
  String get waitlistAlreadyHasCourtesy =>
      'Ya tienes una invitación de cortesía';

  @override
  String get waitlistAlreadyHasCourtesyHint =>
      'No necesitas la lista de espera para este evento. Abre tus invitaciones para verla o gestionarla.';

  @override
  String get waitlistAlreadyOnWaitlist => 'Ya estás en la lista de espera';

  @override
  String get waitlistDisabled =>
      'La lista de espera no está habilitada para este evento';

  @override
  String get waitlistNotAvailable =>
      'Todavía hay cupos de cortesía disponibles. Puedes solicitar una invitación en lugar de unirte a la lista de espera.';

  @override
  String get waitlistViewInvitations => 'Ver invitaciones';

  @override
  String get waitlistStatusTitle => 'Lista de espera no disponible';

  @override
  String get errorStaffNotFound =>
      'No hay una cuenta de staff con este número. Pide a tu admin que te registre.';

  @override
  String get errorNetworkConnection =>
      'No se pudo conectar con el servidor. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get staffScanQrTitle => 'ESCANEAR QR';

  @override
  String get staffScanQrSubtitle => 'Toca para iniciar el escaneo';

  @override
  String get staffScanQrAreaLabel => 'AREA QR';

  @override
  String get staffScanQrInstruction => 'Mantén el código\ndentro del recuadro';

  @override
  String get staffScanFlashLabel => 'Flash';

  @override
  String get staffScanCameraUnavailable =>
      'La cámara no está disponible en este dispositivo.';

  @override
  String get staffScanPermissionDenied =>
      'Se necesita permiso de cámara para escanear códigos QR.';

  @override
  String get staffManualEntryButton => 'INGRESO MANUAL';

  @override
  String get staffSupervisorModeButton => 'MODO SUPERVISOR';

  @override
  String get staffManualEntryScreenTitle => 'Ingreso manual';

  @override
  String get staffManualEntryScreenSubtitle =>
      'Escribe el código de la entrada para validarla. El resultado es el mismo que al escanear el QR y no se puede anular.';

  @override
  String get staffManualConsumptionScreenTitle => 'Consumo manual';

  @override
  String get staffManualConsumptionScreenSubtitle =>
      'Escribe el código de canje para validar la compra. El resultado es el mismo que al escanear el QR y no se puede anular.';

  @override
  String get staffManualEntryCodeHint => '8F7A2B';

  @override
  String get staffManualEntryValidateButton => 'VALIDAR';

  @override
  String get staffScanConsumptionTitle => 'ESCANEAR CONSUMO';

  @override
  String get staffSupervisorSearchManageTicketTitle =>
      'Buscar / Gestionar ticket';

  @override
  String get staffSupervisorSearchManageTicketDescription =>
      'Busca un ticket por código, nombre, teléfono, ID o compra y muestra solo las acciones válidas para su estado.';

  @override
  String get staffSupervisorAccessHistoryTitle => 'Historial de acceso';

  @override
  String get staffSupervisorAccessHistoryDescription =>
      'Revisa la actividad reciente de entradas y abre cualquier registro para ver el detalle.';

  @override
  String get staffSupervisorSearchManagePurchaseTitle =>
      'Buscar / Gestionar compra';

  @override
  String get staffSupervisorSearchManagePurchaseLine1 =>
      'Busca un pedido por código, nombre, teléfono o ID de compra';

  @override
  String get staffSupervisorSearchManagePurchaseLine2 =>
      'Restaura el consumo si no se entregó el producto';

  @override
  String get staffSupervisorRedemptionHistoryTitle => 'Historial de canjes';

  @override
  String get staffSupervisorRedemptionHistoryLine1 =>
      'Canjes y restauraciones recientes de bebidas';

  @override
  String get staffSupervisorRedemptionHistoryLine2 =>
      'Abre cualquier registro para ver la auditoría completa';

  @override
  String get staffSupervisorAuthorizeReentryAction => 'Autorizar reingreso';

  @override
  String get staffSupervisorRegisterExceptionalEntryAction =>
      'Registrar ingreso excepcional';

  @override
  String get staffSupervisorNoActionForBlockedTicket =>
      'Este ticket está bloqueado o cancelado. No hay acción de autorización disponible.';

  @override
  String get staffSupervisorNoActionForActiveTicket =>
      'Este ticket está activo y sin usar. No se requiere intervención del supervisor.';

  @override
  String get staffSupervisorNoRestoreActionAvailable =>
      'No hay acción excepcional disponible para este estado de compra.';

  @override
  String get staffSupervisorRestoreConsumptionAction => 'Restaurar consumo';

  @override
  String get staffSupervisorRestoreReasonTitle => 'Motivo de restauración';

  @override
  String get staffSupervisorRestoreReasonProductNotDelivered =>
      'Producto no entregado';

  @override
  String get staffSupervisorRestoreReasonAccidentalScan => 'Escaneo accidental';

  @override
  String get staffSupervisorRestoreReasonOperationalIssue =>
      'Problema operativo';

  @override
  String get staffSupervisorRestoreReasonOther => 'Otro';

  @override
  String get staffSupervisorRestoreReasonOtherHint => 'Describe el problema';

  @override
  String get staffSupervisorRestoreExecuteButton => 'RESTAURAR CONSUMO';

  @override
  String get staffSupervisorAccessHistoryEmpty =>
      'Aún no hay actividad de acceso para este evento.';

  @override
  String get staffSupervisorAccessResultValid => 'VÁLIDO';

  @override
  String get staffSupervisorAccessResultReEntry => 'REINGRESO';

  @override
  String get staffSupervisorAccessResultRejected => 'RECHAZADO';

  @override
  String get staffSupervisorAccessResultSupervisor => 'SUPERVISOR';

  @override
  String get staffSupervisorRedemptionHistoryEmpty =>
      'Aún no hay canjes para este evento.';

  @override
  String get staffSupervisorRedemptionResultRedeemed => 'CANJEADO';

  @override
  String get staffSupervisorRedemptionResultRestored => 'RESTAURADO';

  @override
  String get staffSupervisorRedemptionResultDuplicate => 'INTENTO DUPLICADO';

  @override
  String get staffSupervisorRedemptionResultSupervisor => 'SUPERVISOR';

  @override
  String get staffSupervisorRedemptionDetailTitle => 'Detalle del canje';

  @override
  String get staffSupervisorRedemptionDetailResult => 'Resultado';

  @override
  String get staffSupervisorRedemptionDetailProduct => 'Producto';

  @override
  String get staffSupervisorRedemptionDetailCustomer => 'Cliente';

  @override
  String get staffSupervisorRedemptionDetailOrder => 'ID pedido';

  @override
  String get staffSupervisorRedemptionDetailCode => 'Código manual';

  @override
  String get staffSupervisorRedemptionDetailBar => 'Bar / ubicación';

  @override
  String get staffSupervisorRedemptionDetailStaff => 'Personal';

  @override
  String get staffSupervisorRedemptionDetailTime => 'Hora';

  @override
  String get staffSupervisorRedemptionDetailStatus => 'Estado actual';

  @override
  String get staffSupervisorSearchEntryTicketTypeLabel => 'Ticket';

  @override
  String get staffSupervisorSearchEntryPurchaseStatusLabel =>
      'Estado de compra';

  @override
  String get staffSupervisorSearchEntryAccessPointLabel => 'Punto de acceso';

  @override
  String get staffRecentScansTitle => 'Últimos escaneos';

  @override
  String get staffRecentScanActionAuthorizeConsumption => 'Consumo autorizado';

  @override
  String get staffRecentScanActionRejectConsumption => 'Consumo rechazado';

  @override
  String get staffRecentScansEmpty =>
      'Aún no hay escaneos de productos. Escanea un QR de bebida para verlo aquí.';

  @override
  String get staffViewAllScans => 'Ver todos >';

  @override
  String get staffScanDuplicateLabel => 'Duplicado';

  @override
  String get staffConnectedLabel => 'Conectado';

  @override
  String get staffDisconnectedLabel => 'Desconectado';

  @override
  String get staffOnlineStatus => 'En línea';

  @override
  String get staffAwayStatus => 'Ausente';

  @override
  String get staffDrawerTitle => 'Menú staff';

  @override
  String get staffApiEnvironmentLabel => 'Entorno API';

  @override
  String get staffApiEnvDevLocal => 'Dev (local)';

  @override
  String get staffApiEnvDevNgrok => 'Dev (ngrok)';

  @override
  String get staffApiEnvProduction => 'Producción';

  @override
  String get staffApiEnvCustom => 'API personalizada';

  @override
  String get staffNgrokTunnelLabel => 'Túnel ngrok (dispositivo físico)';

  @override
  String get staffLanguageLabel => 'Idioma';

  @override
  String get staffLanguageEnglish => 'Inglés';

  @override
  String get staffLanguageSpanish => 'Español';

  @override
  String get staffLogout => 'Cerrar sesión';

  @override
  String get staffSupervisorMode => 'Modo Supervisor';

  @override
  String get staffBarSupervisorMode => 'Supervisor barra';

  @override
  String get staffTicketsSupervisorMode => 'Supervisor entradas';

  @override
  String get staffAccessValidatorMenu => 'Validador de acceso';

  @override
  String get staffSupervisorPinTitle => 'Acceso supervisor';

  @override
  String get staffSupervisorPinSubtitle =>
      'Ingresa tu PIN para continuar y acceder al modo supervisor.';

  @override
  String get staffSupervisorPinFieldLabel => 'Ingresa PIN';

  @override
  String get staffSupervisorPinContinueButton => 'CONTINUAR';

  @override
  String get staffSupervisorPinFooter =>
      'Solo personal autorizado puede acceder.';

  @override
  String get staffSupervisorPinInvalid => 'PIN incorrecto. Intenta de nuevo.';

  @override
  String get staffSupervisorPinNotConfigured =>
      'Aún no hay PIN supervisor configurado. Pide a un administrador que genere uno.';

  @override
  String get staffSupervisorPinAccessDenied =>
      'Tu cuenta no está autorizada para el modo supervisor.';

  @override
  String get staffSupervisorDashboardTitle => 'MODO SUPERVISOR';

  @override
  String get staffSupervisorDashboardSubtitle => 'Control avanzado de barra';

  @override
  String get staffSupervisorCancellationsTitle => 'ANULACIONES';

  @override
  String get staffSupervisorCancelConsumption => 'Anular consumo';

  @override
  String get staffSupervisorRevertValidation => 'Revertir validación';

  @override
  String get staffSupervisorReleaseBlockedQr => 'Liberar código QR bloqueado';

  @override
  String get staffSupervisorManualValidationTitle => 'VALIDACIÓN MANUAL';

  @override
  String staffSupervisorManualValidationUser(String userName) {
    return 'Usuario: $userName';
  }

  @override
  String staffSupervisorManualValidationProduct(String productName) {
    return 'Producto: $productName';
  }

  @override
  String staffSupervisorManualValidationCode(String code) {
    return 'Código parcial: $code';
  }

  @override
  String get staffSupervisorQrOverrideTitle => 'OVERRIDE CÓDIGO QR';

  @override
  String staffSupervisorQrOverrideSupervisor(String supervisorName) {
    return 'Supervisor: $supervisorName';
  }

  @override
  String get staffSupervisorGoButton => 'Ir';

  @override
  String get staffSupervisorRecentActionsTitle => 'ÚLTIMAS ACCIONES';

  @override
  String get staffSupervisorViewAllActions => 'Ver todos >';

  @override
  String get staffSupervisorActionQrReleased => 'Código QR liberado';

  @override
  String get staffSupervisorActionManualValidation => 'Validación manual';

  @override
  String get staffSupervisorActionConsumptionCancelled => 'Consumo anulado';

  @override
  String get staffSupervisorComingSoon => 'Próximamente';

  @override
  String get staffSupervisorCancellationsScreenTitle => 'Anulaciones';

  @override
  String get staffSupervisorCancellationsScreenSubtitle =>
      'Supervisor · YouPass';

  @override
  String get staffSupervisorSearchConsumptionTitle => 'BUSCAR CONSUMO';

  @override
  String get staffSupervisorSearchConsumptionHeading => 'Buscar consumo';

  @override
  String get staffSupervisorSearchDrinkNoResults =>
      'No se encontraron consumos para esta búsqueda.';

  @override
  String get staffSupervisorSearchDrinkSearchError =>
      'No se pudo buscar consumos. Intenta de nuevo.';

  @override
  String staffSupervisorSearchDrinkResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados encontrados',
      one: '1 resultado encontrado',
    );
    return '$_temp0';
  }

  @override
  String get staffSupervisorSearchPlaceholder => 'QR / usuario / producto';

  @override
  String get staffSupervisorSearchButton => 'BUSCAR';

  @override
  String get staffSupervisorConsumptionFoundTitle => 'CONSUMO ENCONTRADO';

  @override
  String get staffSupervisorConsumptionUserLabel => 'Usuario';

  @override
  String get staffSupervisorConsumptionProductLabel => 'Producto';

  @override
  String get staffSupervisorConsumptionBarLabel => 'Barra';

  @override
  String get staffSupervisorConsumptionTimeLabel => 'Hora validación';

  @override
  String get staffSupervisorConsumptionPurchaseTimeLabel => 'Hora de compra';

  @override
  String get staffSupervisorConsumptionRedemptionTimeLabel => 'Hora de canje';

  @override
  String get staffSupervisorConsumptionIdLabel => 'ID consumo';

  @override
  String get staffSupervisorConsumptionStatusLabel => 'Estado';

  @override
  String get staffSupervisorConsumptionStatusValidated => 'VALIDADO';

  @override
  String get staffSupervisorActionsTitle => 'ACCIONES';

  @override
  String get staffSupervisorReasonTitle => 'MOTIVO OBLIGATORIO';

  @override
  String get staffSupervisorReasonPlaceholder =>
      'Escribe el motivo de la anulación...';

  @override
  String get staffSupervisorReasonHint =>
      'Ejemplo: \'Producto entregado incorrecto\'';

  @override
  String get staffSupervisorAuthorizationTitle => 'AUTORIZACIÓN';

  @override
  String get staffSupervisorAuthorizationSupervisorLabel => 'Supervisor';

  @override
  String get staffSupervisorAuthorizationPinLabel => 'PIN supervisor';

  @override
  String get staffSupervisorHistoryTitle => 'HISTORIAL';

  @override
  String staffSupervisorHistoryValidated(String time) {
    return 'Validado — $time';
  }

  @override
  String get staffSupervisorHistoryPending => 'Supervisor pendiente';

  @override
  String get staffSupervisorExecuteCancellationButton => 'EJECUTAR ANULACIÓN';

  @override
  String get staffSupervisorCancellationSuccess =>
      'Anulación registrada correctamente.';

  @override
  String get staffSupervisorManualValidationScreenTitle => 'Validación manual';

  @override
  String get staffSupervisorNoQrBannerTitle => 'CONSUMO SIN QR';

  @override
  String get staffSupervisorNoQrBannerBody =>
      'Ingresa el código del QR de la compra para validar manualmente.';

  @override
  String get staffSupervisorEnterQrCodeTitle =>
      'INGRESAR CÓDIGO QR (OPCIÓN PRINCIPAL)';

  @override
  String get staffSupervisorEnterQrCodePlaceholder =>
      'Ingresa el código del QR';

  @override
  String get staffSupervisorSearchQrCodeButton => 'BUSCAR CÓDIGO';

  @override
  String get staffSupervisorOrDivider => 'o bien';

  @override
  String get staffSupervisorSearchUserHeading => 'Buscar usuario';

  @override
  String get staffSupervisorSearchUserPlaceholder => 'Nombre / teléfono';

  @override
  String get staffSupervisorSearchSystemButton => 'BUSCAR EN SISTEMA';

  @override
  String get staffSupervisorResultFoundTitle => 'RESULTADO ENCONTRADO';

  @override
  String get staffSupervisorResultEventLabel => 'Evento';

  @override
  String get staffSupervisorResultPurchaseLabel => 'Compra';

  @override
  String get staffSupervisorQrStatusLabel => 'Estado QR';

  @override
  String get staffSupervisorQrStatusUnavailable => 'QR NO DISPONIBLE';

  @override
  String get staffSupervisorValidationReasonTitle => 'MOTIVO VALIDACIÓN';

  @override
  String get staffSupervisorReasonPhoneBattery => 'Celular sin batería';

  @override
  String get staffSupervisorReasonNoConnection => 'Sin conexión';

  @override
  String get staffSupervisorReasonDamagedQr => 'QR dañado';

  @override
  String get staffSupervisorReasonBrokenScreen => 'Pantalla rota';

  @override
  String get staffSupervisorReasonOther => 'Otro';

  @override
  String get staffSupervisorIdentityValidationTitle => 'VALIDACIÓN IDENTIDAD';

  @override
  String get staffSupervisorIdentityFullNameLabel => 'Nombre completo';

  @override
  String get staffSupervisorIdentityLastDigitsLabel => 'Últimos 4 dígitos';

  @override
  String get staffSupervisorIdentityDocumentLabel => 'Documento validado';

  @override
  String get staffSupervisorIdentityConfirmed => 'Confirmado';

  @override
  String get staffSupervisorAuthorizeConsumptionButton => 'AUTORIZAR CONSUMO';

  @override
  String get staffSupervisorGenerateTemporaryQrButton => 'GENERAR QR TEMPORAL';

  @override
  String get staffSupervisorRejectButton => 'RECHAZAR';

  @override
  String get staffSupervisorValidationReasonPlaceholder =>
      'Escribe el motivo de la validación...';

  @override
  String get staffSupervisorSystemRecordTitle => 'REGISTRO SISTEMA';

  @override
  String staffSupervisorSystemRecordSupervisor(String name) {
    return 'Supervisor: $name';
  }

  @override
  String staffSupervisorSystemRecordTime(String time) {
    return 'Hora: $time';
  }

  @override
  String get staffSupervisorSystemRecordStatus => 'Estado: ';

  @override
  String get staffSupervisorSystemRecordStatusPending => 'Pendiente';

  @override
  String get staffSupervisorQrOverrideScreenTitle => 'Override código QR';

  @override
  String get staffSupervisorOverrideCriticalTitle => 'ACCIÓN CRÍTICA';

  @override
  String get staffSupervisorOverrideCriticalBody =>
      'Esta herramienta modifica el estado del QR en sistema.';

  @override
  String get staffSupervisorOverrideSearchTitle => 'BUSCAR QR / USUARIO';

  @override
  String get staffSupervisorOverrideSearchPlaceholder =>
      'QR / nombre / ID compra';

  @override
  String get staffSupervisorOverrideActionsTitle => 'ACCIONES OVERRIDE';

  @override
  String get staffSupervisorOverrideReleaseQr => 'Liberar QR';

  @override
  String get staffSupervisorOverrideRevalidateQr => 'Revalidar QR';

  @override
  String get staffSupervisorOverrideAuthorizeReconsumption =>
      'Autorizar reconsumo';

  @override
  String get staffSupervisorOverrideTemporaryUnlock => 'Desbloqueo temporal';

  @override
  String get staffSupervisorOverrideReasonPlaceholder =>
      'Escribe el motivo del override...';

  @override
  String get staffSupervisorOverrideReasonHint =>
      'Ejemplo: \'QR marcado incorrectamente\'';

  @override
  String get staffSupervisorOverrideQrIdLabel => 'ID QR';

  @override
  String get staffSupervisorOverrideCurrentStatusLabel => 'Estado actual';

  @override
  String get staffSupervisorOverrideStatusBlocked => 'BLOQUEADO';

  @override
  String get staffSupervisorOverrideLastUseLabel => 'Último uso';

  @override
  String get staffSupervisorOverrideScannerLabel => 'Scanner';

  @override
  String get staffSupervisorOverrideAuthLevelLabel => 'Nivel autorización:';

  @override
  String get staffSupervisorOverrideAuthLevelHigh => 'ALTO';

  @override
  String get staffSupervisorOverrideExpectedResultTitle => 'RESULTADO ESPERADO';

  @override
  String get staffSupervisorOverrideExpectedStatusPrefix => 'Estado QR →';

  @override
  String get staffSupervisorOverrideExpectedStatus => 'Estado QR → VÁLIDO';

  @override
  String get staffSupervisorOverrideExpectedSubtext =>
      'Nuevo consumo permitido.';

  @override
  String get staffSupervisorOverrideLogsTitle => 'LOGS QR';

  @override
  String get staffSupervisorOverrideLogsEmpty =>
      'Aún no hay actividad registrada para este QR.';

  @override
  String get staffSupervisorOverrideLogQrBlocked => 'QR bloqueado';

  @override
  String get staffSupervisorOverrideLogPending => 'Override pendiente';

  @override
  String get staffSupervisorExecuteOverrideButton => 'EJECUTAR OVERRIDE';

  @override
  String get staffSupervisorAccessDashboardSubtitle =>
      'Accede a herramientas avanzadas para gestionar accesos y resolver contingencias.';

  @override
  String get staffSupervisorSearchEntryTitle => 'Buscar entrada';

  @override
  String get staffSupervisorSearchEntryDescription =>
      'Busca y revisa el estado de una entrada por nombre, código, teléfono y más.';

  @override
  String get staffSupervisorResolveDuplicateTitle => 'Resolver duplicado';

  @override
  String get staffSupervisorResolveDuplicateDescription =>
      'Gestiona entradas duplicadas o usos no autorizados.';

  @override
  String get staffSupervisorEntryOverrideDescription =>
      'Autoriza, libera o revalida manualmente una entrada.';

  @override
  String get staffSupervisorEntryAuthorizationTitle =>
      'AUTORIZACIÓN SUPERVISOR';

  @override
  String get staffSupervisorEntryAccessLabel => 'Acceso';

  @override
  String get staffSupervisorEntryOverrideCriticalBody =>
      'Esta herramienta modifica directamente el estado del QR dentro del sistema.';

  @override
  String get staffSupervisorEntryOverrideReasonPlaceholder =>
      'Describe el motivo del override';

  @override
  String get staffSupervisorEntryOverrideReasonHint =>
      'Ejemplo: \'QR marcado como usado accidentalmente\'';

  @override
  String get staffSupervisorOverrideAuthorizeReentry => 'Autorizar reingreso';

  @override
  String get staffSupervisorEntryOverrideExpectedValid => 'VÁLIDO';

  @override
  String get staffSupervisorEntryOverrideExpectedSubtext =>
      'Reingreso permitido';

  @override
  String get staffSupervisorEntryManualValidationTitle => 'Validación manual';

  @override
  String get staffSupervisorEntryManualValidationDescription =>
      'Valida el acceso manualmente cuando no hay QR disponible.';

  @override
  String get staffSupervisorEntryNoQrBannerTitle => 'ACCESO SIN QR';

  @override
  String get staffSupervisorEntryNoQrBannerBody =>
      'Use esta opción solo en casos justificados';

  @override
  String get staffSupervisorEntryManualSearchPlaceholder =>
      'Nombre / teléfono / correo';

  @override
  String get staffSupervisorEntryManualReasonTitle => 'Motivo acceso manual';

  @override
  String get staffSupervisorEntryManualReasonOtherPlaceholder =>
      'Especifica el motivo';

  @override
  String get staffSupervisorEntryManualIdentityPhoneLabel =>
      'Últimos 4 dígitos teléfono';

  @override
  String get staffSupervisorEntryManualAuthorizeEntry => 'AUTORIZAR INGRESO';

  @override
  String get staffSupervisorEntryManualRejectAccess => 'RECHAZAR ACCESO';

  @override
  String get staffSupervisorEntryManualReasonPlaceholder =>
      'Describe el motivo del acceso manual';

  @override
  String get staffSupervisorEntryManualSystemStatusLabel => 'Estado: ';

  @override
  String get staffSupervisorEntryManualSystemStatusPending =>
      'Pendiente autorización';

  @override
  String get staffSupervisorEntryManualValidationSuccess =>
      'Validación manual aplicada correctamente.';

  @override
  String get staffSupervisorTemporaryQrDialogTitle => 'QR temporal generado';

  @override
  String staffSupervisorTemporaryQrDialogSubtitle(int minutes) {
    return 'Muestra este QR en la puerta. Válido por $minutes minutos.';
  }

  @override
  String staffSupervisorTemporaryQrDialogGuest(String guestName) {
    return 'Invitado: $guestName';
  }

  @override
  String get staffSupervisorTemporaryQrDialogClose => 'Listo';

  @override
  String get staffSupervisorTemporaryQrGeneratedSuccess =>
      'QR temporal listo para mostrar.';

  @override
  String get staffSupervisorVipManagementTitle => 'Gestión VIP';

  @override
  String get staffSupervisorVipManagementDescription =>
      'Consulta y autoriza accesos especiales para invitados VIP.';

  @override
  String get staffSupervisorVipSearchPlaceholder =>
      'Buscar mesa / usuario (ej. Mesa 12 / Daniel Rojas)';

  @override
  String get staffSupervisorVipSearchSectionTitle => 'BUSCAR MESA VIP';

  @override
  String get staffSupervisorVipSearchNoResults =>
      'No se encontraron mesas VIP para esta búsqueda.';

  @override
  String staffSupervisorVipSearchResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesas encontradas',
      one: '1 mesa encontrada',
    );
    return '$_temp0';
  }

  @override
  String get staffSupervisorVipStatusLabel => 'Estado:';

  @override
  String get staffSupervisorVipStatusActive => 'ACTIVA';

  @override
  String get staffSupervisorVipCapacityLabel => 'Capacidad';

  @override
  String staffSupervisorVipCapacityPeople(int count) {
    return '$count personas';
  }

  @override
  String get staffSupervisorVipEnteredLabel => 'Ingresados';

  @override
  String get staffSupervisorVipPendingLabel => 'Pendientes';

  @override
  String get staffSupervisorVipPurchaseResponsibleLabel =>
      'Responsable compra:';

  @override
  String get staffSupervisorVipGuestsTitle => 'INVITADOS';

  @override
  String staffSupervisorVipGuestEntered(String time) {
    return 'Ingresó - $time';
  }

  @override
  String get staffSupervisorVipGuestPending => 'Entrada pendiente';

  @override
  String get staffSupervisorVipActionAuthorizeExtra =>
      'Autorizar invitado extra';

  @override
  String get staffSupervisorVipActionChangeAccess => 'Cambiar acceso VIP';

  @override
  String get staffSupervisorVipActionMoveGuest => 'Mover invitado';

  @override
  String get staffSupervisorVipActionReleaseInvitation => 'Liberar invitación';

  @override
  String get staffSupervisorVipNewExtraGuestTitle => 'NUEVO INVITADO EXTRA';

  @override
  String get staffSupervisorVipGuestNameLabel => 'Nombre';

  @override
  String get staffSupervisorVipGuestNamePlaceholder => 'Nombre completo';

  @override
  String get staffSupervisorVipGuestPhoneLabel => 'Teléfono';

  @override
  String get staffSupervisorVipGuestPhonePlaceholder => 'Ej. +56 9 1234 5678';

  @override
  String get staffSupervisorVipAuthorizationReasonLabel =>
      'Motivo autorización';

  @override
  String get staffSupervisorVipAuthorizationReasonPlaceholder =>
      'Describe el motivo de la autorización';

  @override
  String get staffSupervisorVipHistoryTitle => 'HISTORIAL VIP';

  @override
  String get staffSupervisorVipHistorySupervisorPrefix => 'Supervisor';

  @override
  String get staffSupervisorVipHistoryExtraGuest => 'Invitado extra autorizado';

  @override
  String get staffSupervisorVipHistoryQrReleased => 'QR VIP liberado';

  @override
  String get staffSupervisorVipHistoryTableModified => 'Mesa modificada';

  @override
  String get staffSupervisorVipSearchResultsTitle => 'MESAS COINCIDENTES';

  @override
  String get staffSupervisorVipActionSuccess =>
      'Acción VIP aplicada correctamente.';

  @override
  String get staffSupervisorVipSelectGuestRelease =>
      'Toca un invitado para liberar su QR de invitación.';

  @override
  String get staffSupervisorVipSelectGuestChangeAccess =>
      'Toca un invitado para cambiar su nivel de acceso VIP.';

  @override
  String get staffSupervisorVipSelectGuestMove =>
      'Toca un invitado para moverlo a otro asiento.';

  @override
  String get staffSupervisorVipSelectAccessTitle => 'NUEVO NIVEL DE ACCESO';

  @override
  String get staffSupervisorVipSelectDestinationTitle => 'ASIENTO DESTINO';

  @override
  String get staffSupervisorVipNoAvailableSeats =>
      'No hay asientos vacíos en esta mesa.';

  @override
  String get staffSupervisorVipReleaseInvitationHint =>
      'Esto desbloquea el QR del invitado de inmediato sin quitarlo de la mesa.';

  @override
  String get staffSupervisorSystemStatusTitle => 'Estado del sistema';

  @override
  String get staffSupervisorSystemStatusDescription =>
      'Revisa conectividad, sincronización y estado del validador.';

  @override
  String get staffSupervisorSystemGeneralStatusTitle => 'ESTADO GENERAL';

  @override
  String get staffSupervisorSystemHealthSystem => 'Sistema';

  @override
  String get staffSupervisorSystemHealthSync => 'Sincronización';

  @override
  String get staffSupervisorSystemHealthDatabase => 'Base datos';

  @override
  String get staffSupervisorSystemHealthOfflineMode => 'Modo offline';

  @override
  String get staffSupervisorSystemStatusOnline => 'ONLINE';

  @override
  String get staffSupervisorSystemStatusSlowSync => 'LENTA';

  @override
  String get staffSupervisorSystemStatusSlowScanner => 'LENTO';

  @override
  String get staffSupervisorSystemStatusOperational => 'OPERATIVA';

  @override
  String get staffSupervisorSystemStatusDisabled => 'DESACTIVADO';

  @override
  String get staffSupervisorSystemStatusDisconnected => 'DESCONECTADO';

  @override
  String get staffSupervisorSystemActiveScannersTitle => 'SCANNERS ACTIVOS';

  @override
  String get staffSupervisorSystemRestartScannerButton => 'REINICIAR SCANNER';

  @override
  String get staffSupervisorSystemActiveAlertsTitle => 'ALERTAS ACTIVAS';

  @override
  String get staffSupervisorSystemAlertDuplicateQr =>
      'QR duplicados detectados';

  @override
  String get staffSupervisorSystemAlertVipQueue => 'Cola saturada acceso VIP';

  @override
  String get staffSupervisorSystemAlertScannerSlow => 'Scanner VIP-01 lento';

  @override
  String get staffSupervisorSystemEventFlowTitle => 'FLUJO DEL EVENTO';

  @override
  String get staffSupervisorSystemEventFlowSubtitle => 'Ingresos últimos 5 min';

  @override
  String get staffSupervisorSystemFlowGeneral => 'General';

  @override
  String get staffSupervisorSystemFlowVip => 'VIP';

  @override
  String get staffSupervisorSystemFlowBackstage => 'Backstage';

  @override
  String get staffSupervisorSystemFlowRejected => 'Rechazados';

  @override
  String get staffSupervisorSystemFlowDuplicates => 'Duplicados';

  @override
  String get staffSupervisorSystemQuickActionsTitle => 'ACCIONES RÁPIDAS';

  @override
  String get staffSupervisorSystemActionOfflineMode => 'ACTIVAR MODO OFFLINE';

  @override
  String get staffSupervisorSystemActionPauseValidations =>
      'PAUSAR VALIDACIONES';

  @override
  String get staffSupervisorSystemActionManualAccess => 'ABRIR ACCESO MANUAL';

  @override
  String get staffSupervisorSystemActionBlockVip => 'BLOQUEAR ACCESO VIP';

  @override
  String get staffSupervisorSystemActionStaffAlert => 'ENVIAR ALERTA STAFF';

  @override
  String get staffSupervisorSystemOperationalSemaphoreTitle =>
      'SEMÁFORO OPERACIONAL';

  @override
  String get staffSupervisorSystemRiskModerate => 'RIESGO MODERADO';

  @override
  String get staffSupervisorSystemRiskReasonLabel => 'Motivo: ';

  @override
  String get staffSupervisorSystemRiskReasonVipFlow => 'Alto flujo acceso VIP';

  @override
  String get staffSupervisorSystemRecentLogsTitle => 'LOGS RECIENTES';

  @override
  String get staffSupervisorSystemLogOfflineActivated =>
      'Modo offline activado';

  @override
  String get staffSupervisorSystemLogOverrideAuthorized =>
      'Override autorizado';

  @override
  String get staffSupervisorSystemLogScannerRestarted =>
      'Scanner VIP reiniciado';

  @override
  String get staffSupervisorSystemLogDuplicateDetected =>
      'QR duplicado detectado';

  @override
  String get staffSupervisorSystemLogOfflineDeactivated =>
      'Modo offline desactivado';

  @override
  String get staffSupervisorSystemLogValidationsPaused =>
      'Validaciones pausadas';

  @override
  String get staffSupervisorSystemLogValidationsResumed =>
      'Validaciones reanudadas';

  @override
  String get staffSupervisorSystemLogVipBlocked => 'Acceso VIP bloqueado';

  @override
  String get staffSupervisorSystemLogStaffAlert => 'Alerta enviada al staff';

  @override
  String get staffSupervisorSystemRiskReasonDuplicateQr =>
      'Actividad de QR duplicados detectada';

  @override
  String get staffSupervisorSystemRiskReasonScannerSlow =>
      'Uno o más scanners están lentos';

  @override
  String get staffSupervisorSystemRiskReasonValidationsPaused =>
      'Las validaciones están pausadas';

  @override
  String get staffSupervisorSystemActionDeactivateOfflineMode =>
      'DESACTIVAR MODO OFFLINE';

  @override
  String get staffSupervisorSystemActionResumeValidations =>
      'REANUDAR VALIDACIONES';

  @override
  String get staffSupervisorSystemActionUnblockVip => 'DESBLOQUEAR ACCESO VIP';

  @override
  String get staffSupervisorSystemActionSuccess =>
      'Acción aplicada correctamente';

  @override
  String get staffSupervisorSystemLoadError =>
      'No se pudo cargar el estado del sistema';

  @override
  String get staffSupervisorSystemAlertMessageLabel => 'Mensaje de alerta';

  @override
  String get staffSupervisorSystemAlertMessagePlaceholder =>
      'Describe el problema para el staff en sitio';

  @override
  String get staffSupervisorSystemPinRequired => 'PIN de supervisor';

  @override
  String get staffSupervisorSystemDialogConfirm => 'Confirmar';

  @override
  String get staffSupervisorSystemRetry => 'Reintentar';

  @override
  String get staffSupervisorActionHistoryTitle => 'Historial de acciones';

  @override
  String get staffSupervisorActionHistoryDescription =>
      'Consulta las últimas acciones realizadas en modo supervisor.';

  @override
  String get staffSupervisorActionHistoryEmpty =>
      'Aún no hay acciones de supervisor registradas para este evento.';

  @override
  String get staffSupervisorActionHistoryLoadError =>
      'No se pudo cargar el historial de acciones';

  @override
  String get staffSupervisorActionHistoryKindReleaseQr => 'QR liberado';

  @override
  String get staffSupervisorActionHistoryKindRevalidateQr => 'QR revalidado';

  @override
  String get staffSupervisorActionHistoryKindRevertValidation =>
      'Validación revertida';

  @override
  String get staffSupervisorActionHistoryKindAuthorizeReentry =>
      'Reingreso autorizado';

  @override
  String get staffSupervisorActionHistoryKindTemporaryUnlock =>
      'Desbloqueo temporal aplicado';

  @override
  String get staffSupervisorActionHistoryKindReleaseReentry =>
      'Reingreso liberado';

  @override
  String get staffSupervisorActionHistoryKindBlockQr => 'QR bloqueado';

  @override
  String get staffSupervisorActionHistoryKindEscalateAlert => 'Alerta escalada';

  @override
  String get staffSupervisorActionHistoryKindAuthorizeEntry =>
      'Ingreso manual autorizado';

  @override
  String get staffSupervisorActionHistoryKindGenerateTemporaryQr =>
      'QR temporal generado';

  @override
  String get staffSupervisorActionHistoryKindRejectAccess => 'Acceso rechazado';

  @override
  String get staffSupervisorActionHistoryKindAuthorizeExtraGuest =>
      'Invitado VIP extra autorizado';

  @override
  String get staffSupervisorActionHistoryKindChangeAccess =>
      'Acceso VIP modificado';

  @override
  String get staffSupervisorActionHistoryKindMoveGuest => 'Invitado VIP movido';

  @override
  String get staffSupervisorActionHistoryKindReleaseInvitation =>
      'Invitación VIP liberada';

  @override
  String get staffSupervisorActionHistoryKindOfflineModeEnabled =>
      'Modo offline activado';

  @override
  String get staffSupervisorActionHistoryKindOfflineModeDisabled =>
      'Modo offline desactivado';

  @override
  String get staffSupervisorActionHistoryKindValidationsPaused =>
      'Validaciones pausadas';

  @override
  String get staffSupervisorActionHistoryKindValidationsResumed =>
      'Validaciones reanudadas';

  @override
  String get staffSupervisorActionHistoryKindVipAccessBlocked =>
      'Acceso VIP bloqueado';

  @override
  String get staffSupervisorActionHistoryKindVipAccessUnblocked =>
      'Acceso VIP desbloqueado';

  @override
  String get staffSupervisorActionHistoryKindScannerRestarted =>
      'Scanner reiniciado';

  @override
  String get staffSupervisorActionHistoryKindStaffAlert =>
      'Alerta enviada al staff';

  @override
  String get staffSupervisorExitModeButton => 'Salir del modo supervisor';

  @override
  String staffSupervisorValidatorLabel(String validatorId) {
    return 'Validador: $validatorId';
  }

  @override
  String get staffSupervisorSearchEntryScreenTitle => 'Buscar entrada';

  @override
  String get staffSupervisorSearchEntrySectionTitle => 'BUSCAR ENTRADA';

  @override
  String get staffSupervisorSearchEntryPlaceholder =>
      'Nombre / teléfono / RUT / QR / ID compra / mesa VIP';

  @override
  String get staffSupervisorSearchEntryHeaderSubtitle =>
      'Supervisor · Modo supervisor';

  @override
  String get staffSupervisorSearchEntryByLabel => 'Buscar por:';

  @override
  String get staffSupervisorSearchEntryQuickFilters => 'Filtros rápidos';

  @override
  String get staffSupervisorSearchEntryFilterVip => 'VIP';

  @override
  String get staffSupervisorSearchEntryFilterUsed => 'Usados';

  @override
  String get staffSupervisorSearchEntryFilterError => 'Error';

  @override
  String get staffSupervisorSearchEntryPurchaseIdLabel => 'ID Compra';

  @override
  String get staffSupervisorSearchEntryTimeLabel => 'Hora ingreso';

  @override
  String get staffSupervisorSearchEntryValidatorLabel => 'Validador';

  @override
  String get staffSupervisorSearchEntryVipTableLabel => 'Mesa VIP';

  @override
  String get staffSupervisorSearchEntryAssociatedLabel => 'Ingresos asociados';

  @override
  String get staffSupervisorSearchEntryActionHistory => 'Ver historial';

  @override
  String get staffSupervisorEntryHistoryTitle => 'Historial de entrada';

  @override
  String get staffSupervisorEntryHistoryEmpty =>
      'Aún no hay historial registrado para esta entrada.';

  @override
  String staffSupervisorEntryHistoryQrLabel(String code) {
    return 'Código: $code';
  }

  @override
  String get staffSupervisorSearchEntryActionOverride => 'Override manual';

  @override
  String get staffSupervisorSearchEntryRecentEventsTitle => 'ÚLTIMOS EVENTOS';

  @override
  String get staffSupervisorEntryGateLabel => 'Puerta';

  @override
  String get staffSupervisorEntryStatusValidated => 'VALIDADO';

  @override
  String get staffSupervisorEntryStatusPending => 'PENDIENTE';

  @override
  String get staffSupervisorEntryStatusUsed => 'USADO';

  @override
  String get staffSupervisorEntryStatusAlreadyUsed => 'YA USADO';

  @override
  String get staffSupervisorEntryStatusBlocked => 'BLOQUEADO';

  @override
  String get staffSupervisorEntryStatusError => 'ERROR';

  @override
  String get staffSupervisorSearchEntryNoResults =>
      'No se encontraron entradas para esta búsqueda.';

  @override
  String get staffSupervisorSearchEntryNoVipResults =>
      'No hay entradas VIP para esta búsqueda. Desactiva el filtro VIP o prueba otro término.';

  @override
  String get staffSupervisorSearchEntryNoUsedResults =>
      'No hay entradas usadas para esta búsqueda. Desactiva el filtro Usados o prueba otro término.';

  @override
  String get staffSupervisorSearchEntryNoErrorResults =>
      'No hay entradas con error para esta búsqueda. Desactiva el filtro Error o prueba otro término.';

  @override
  String get staffSupervisorSearchEntrySearchError =>
      'No se pudo buscar entradas. Intenta de nuevo.';

  @override
  String get staffSupervisorSearchEntryRecentValidated => 'Validado';

  @override
  String get staffSupervisorSearchEntryRecentReentry => 'Reingreso autorizado';

  @override
  String get staffSupervisorSearchEntryRecentSupervisor => 'Supervisor';

  @override
  String staffSupervisorSearchEntryResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados encontrados',
      one: '1 resultado encontrado',
    );
    return '$_temp0';
  }

  @override
  String get staffSupervisorDuplicateAlertTitle => 'ALERTA DE DUPLICADO';

  @override
  String get staffSupervisorDuplicateCurrentStatusTitle => 'ESTADO ACTUAL';

  @override
  String get staffSupervisorDuplicateLastValidTitle => 'Último acceso válido';

  @override
  String get staffSupervisorDuplicateNewAttemptTitle =>
      'Nuevo intento detectado';

  @override
  String get staffSupervisorDuplicateTimeLabel => 'Hora';

  @override
  String get staffSupervisorDuplicateAccessLabel => 'Acceso';

  @override
  String get staffSupervisorDuplicateDeviceLabel => 'Dispositivo';

  @override
  String get staffSupervisorDuplicatePossibleReasonTitle => 'POSIBLE MOTIVO';

  @override
  String get staffSupervisorDuplicateReasonScreenshot =>
      'Screenshot compartido';

  @override
  String get staffSupervisorDuplicateReasonResold => 'QR revendida';

  @override
  String get staffSupervisorDuplicateReasonValidationError =>
      'Error validación';

  @override
  String get staffSupervisorDuplicateReasonAuthorizedReentry =>
      'Reingreso autorizado';

  @override
  String get staffSupervisorDuplicateSupervisorActionsTitle =>
      'ACCIONES SUPERVISOR';

  @override
  String get staffSupervisorDuplicateReleaseReentry => 'LIBERAR REINGRESO';

  @override
  String get staffSupervisorDuplicateBlockQr => 'BLOQUEAR QR';

  @override
  String get staffSupervisorDuplicateEscalateAlert => 'ESCALAR ALERTA';

  @override
  String get staffSupervisorDuplicateReasonPlaceholder =>
      'Escribe el motivo...';

  @override
  String get staffSupervisorExecuteDuplicateButton => 'RESOLVER DUPLICADO';

  @override
  String get staffSupervisorDuplicateNotFound =>
      'No se encontraron intentos duplicados para esta entrada.';

  @override
  String get staffSupervisorDuplicateResolvedSuccess =>
      'Duplicado resuelto correctamente.';

  @override
  String get staffSupervisorEntryOverrideSuccess =>
      'Override aplicado correctamente.';

  @override
  String get staffSupervisorDuplicateLogValidated => 'Validado';

  @override
  String get staffSupervisorDuplicateLogReentryRejected =>
      'Reingreso rechazado';

  @override
  String get staffSupervisorDuplicateLogSupervisorPending =>
      'Supervisor pendiente';

  @override
  String get staffSupervisorDuplicateLogSupervisorResolved =>
      'Supervisor resuelto';

  @override
  String get staffSupervisorDuplicateAlreadyResolved =>
      'Esta alerta de duplicado ya fue resuelta.';

  @override
  String get staffSupervisorDuplicateSearchHint =>
      'Busca por nombre, código, teléfono o ID de compra';

  @override
  String get staffBarMode => 'Modo Barra';

  @override
  String get staffNoScanAccessTitle => 'Sin acceso de escaneo';

  @override
  String get staffNoScanAccessSubtitle =>
      'Pide a un administrador que asigne permisos de puerta o barra a tu cuenta de staff.';

  @override
  String get staffSupervisorAccessDenied =>
      'No tienes acceso de supervisor para esta zona.';

  @override
  String get staffAccessValidatorTitle => 'VALIDADOR ACCESO';

  @override
  String get staffAccessValidatorSubtitle =>
      'Escanea el código QR de la entrada para validar el acceso al evento';

  @override
  String get staffScanEntryButton => 'ESCANEAR ENTRADA';

  @override
  String get staffActiveEventPrefix => 'Evento activo:';

  @override
  String staffActiveEventLabel(String eventName) {
    return 'Evento activo: $eventName';
  }

  @override
  String get staffRecentAccessTitle => 'Últimos accesos';

  @override
  String get staffRecentAccessEmpty =>
      'Aún no hay escaneos de entrada. Escanea un QR de ticket para verlo aquí.';

  @override
  String get staffViewAllAccess => 'Ver todos >';

  @override
  String get staffAccessDuplicateLabel => 'QR duplicado';

  @override
  String get staffScanResultValidTitle => 'VÁLIDO';

  @override
  String get staffScanResultValidSubtitle =>
      'El QR ha sido validado correctamente';

  @override
  String get staffScanResultUsedTitle => 'QR USADO';

  @override
  String get staffScanResultUsedSubtitle =>
      'Este código ya fue canjeado anteriormente.';

  @override
  String get staffScanResultProductLabel => 'Producto';

  @override
  String get staffScanResultUserLabel => 'Usuario';

  @override
  String get staffScanResultTimeLabel => 'Hora';

  @override
  String get staffScanResultAttemptTimeLabel => 'Hora del intento';

  @override
  String get staffScanResultBarLabel => 'Barra';

  @override
  String get staffScanResultTransactionIdLabel => 'ID de transacción';

  @override
  String get staffScanResultRememberTitle => 'Recuerda';

  @override
  String get staffScanResultRememberMessage =>
      'Presiona el botón para confirmar la entrega del producto.';

  @override
  String get staffScanResultLastSuccessfulUse => 'Último uso exitoso';

  @override
  String get staffScanResultDeliverButton => 'ENTREGAR PRODUCTO';

  @override
  String get staffScanResultConfirmAccessButton => 'CONFIRMAR ACCESO';

  @override
  String get staffScanResultEntryRememberMessage =>
      'Presiona el botón para confirmar el acceso al evento.';

  @override
  String get staffScanResultTicketLabel => 'Entrada';

  @override
  String get staffScanResultBackButton => 'VOLVER';

  @override
  String get staffEntryValidTitle => 'VÁLIDA';

  @override
  String get staffEntryValidSubtitle => 'QR único válido';

  @override
  String get staffEntryValidEventLabel => 'Evento';

  @override
  String get staffEntryValidEntryIdLabel => 'ID de entrada';

  @override
  String get staffEntryValidTicketTypeLabel => 'Tipo de entrada';

  @override
  String get staffEntryValidAccessLabel => 'Acceso autorizado';

  @override
  String get staffEntryValidTimeLabel => 'Hora de validación';

  @override
  String get staffEntryValidAllowButton => 'PERMITIR INGRESO';

  @override
  String get staffEntryInvalidTitle => 'INVÁLIDA';

  @override
  String get staffEntryInvalidSubtitle => 'QR ya utilizado';

  @override
  String get staffEntryInvalidReasonLabel => 'Motivo';

  @override
  String get staffEntryInvalidReasonTitle => 'QR ya utilizado';

  @override
  String get staffEntryInvalidReasonMessage =>
      'Este código ya fue escaneado anteriormente';

  @override
  String get staffEntryInvalidLastAccessLabel => 'Último acceso';

  @override
  String staffEntryInvalidLastAccessDate(String date) {
    return 'Hoy, $date';
  }

  @override
  String get staffEntryInvalidUserLabel => 'Usuario';

  @override
  String get staffEntryInvalidWarning =>
      'Este QR no puede ser utilizado. Si crees que esto es un error, contacta al supervisor.';

  @override
  String get staffEntryInvalidResolveDuplicateButton => 'RESOLVER DUPLICADO';

  @override
  String get staffScanErrorQrNotFound => 'Código QR no reconocido.';

  @override
  String get staffScanErrorQrInvalid =>
      'Este código QR no es válido para escanear.';

  @override
  String get staffScanErrorPermissionDenied =>
      'No tienes permiso para realizar este escaneo.';

  @override
  String get staffScanErrorSessionExpired =>
      'Tu sesión expiró. Vuelve a iniciar sesión.';

  @override
  String staffScanResultUnitCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count unidades',
      one: '1 unidad',
    );
    return '$_temp0';
  }
}
