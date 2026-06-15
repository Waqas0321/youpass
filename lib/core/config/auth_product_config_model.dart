import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/post_registration_navigation_entity.dart';

class AuthProductConfigModel {
  const AuthProductConfigModel({
    this.channel = 'whatsapp',
    this.whatsappOnly = true,
    this.smsEnabled = false,
    this.otpLength = 6,
    this.otpTtlMinutes = 3,
    this.otpResendCooldownSeconds = 60,
    this.otpMaxResendsPerHour = 5,
    this.otpMaxFailedAttempts = 3,
    this.otpBlockMinutes = 15,
    this.sessionIndefinite = true,
    this.sessionExpiresOnLogoutOnly = true,
    this.supportEmail = 'soporte@youpass.app',
  });

  final String channel;
  final bool whatsappOnly;
  final bool smsEnabled;
  final int otpLength;
  final int otpTtlMinutes;
  final int otpResendCooldownSeconds;
  final int otpMaxResendsPerHour;
  final int otpMaxFailedAttempts;
  final int otpBlockMinutes;
  final bool sessionIndefinite;
  final bool sessionExpiresOnLogoutOnly;
  final String supportEmail;

  int get otpTtlSeconds => otpTtlMinutes * 60;

  factory AuthProductConfigModel.fromJson(Map<String, dynamic> json) {
    return AuthProductConfigModel(
      channel: JsonReaders.string(json, 'channel', fallback: 'whatsapp'),
      whatsappOnly: JsonReaders.boolean(json, 'whatsapp_only', fallback: true),
      smsEnabled: JsonReaders.boolean(json, 'sms_enabled', fallback: false),
      otpLength: JsonReaders.integer(json, 'otp_length', fallback: 6),
      otpTtlMinutes: JsonReaders.integer(json, 'otp_ttl_minutes', fallback: 3),
      otpResendCooldownSeconds: JsonReaders.integer(
        json,
        'otp_resend_cooldown_seconds',
        fallback: 60,
      ),
      otpMaxResendsPerHour: JsonReaders.integer(
        json,
        'otp_max_resends_per_hour',
        fallback: 5,
      ),
      otpMaxFailedAttempts: JsonReaders.integer(
        json,
        'otp_max_failed_attempts',
        fallback: 3,
      ),
      otpBlockMinutes: JsonReaders.integer(json, 'otp_block_minutes', fallback: 15),
      sessionIndefinite: JsonReaders.boolean(
        json,
        'session_indefinite',
        fallback: true,
      ),
      sessionExpiresOnLogoutOnly: JsonReaders.boolean(
        json,
        'session_expires_on_logout_only',
        fallback: true,
      ),
      supportEmail: JsonReaders.string(
        json,
        'support_email',
        fallback: 'soporte@youpass.app',
      ),
    );
  }

  static const AuthProductConfigModel defaults = AuthProductConfigModel();
}

class GenderOptionConfig {
  const GenderOptionConfig({
    required this.value,
    required this.labels,
  });

  final String value;
  final Map<String, String> labels;

  String labelFor(String languageCode) {
    final normalized = languageCode.toLowerCase();
    return labels[normalized] ??
        labels['es'] ??
        labels['en'] ??
        labels['pt'] ??
        (labels.isNotEmpty ? labels.values.first : value);
  }

  factory GenderOptionConfig.fromJson(Map<String, dynamic> json) {
    final labelsRaw = json['labels'];
    final labels = <String, String>{};

    if (labelsRaw is Map) {
      labelsRaw.forEach((key, value) {
        labels[key.toString().toLowerCase()] = value.toString();
      });
    }

    const flatLabelKeys = {
      'en': 'label_en',
      'es': 'label_es',
      'pt': 'label_pt',
    };
    for (final entry in flatLabelKeys.entries) {
      final raw = json[entry.value]?.toString();
      if (raw != null && raw.isNotEmpty) {
        labels[entry.key] = raw;
      }
    }

    final singleLabel = json['label']?.toString();
    if (singleLabel != null && singleLabel.isNotEmpty && labels.isEmpty) {
      labels['en'] = singleLabel;
    }

    return GenderOptionConfig(
      value: JsonReaders.string(json, 'value'),
      labels: labels,
    );
  }
}

class RegistrationProductConfigModel {
  const RegistrationProductConfigModel({
    this.requiredFields = const [
      'phone',
      'country_code',
      'code',
      'full_name',
      'email',
      'birthdate',
      'gender',
      'rut_or_passport',
      'accept_terms',
    ],
    this.optionalFields = const [
      'instagram_username',
      'preferred_language',
      'profile_photo',
    ],
    this.profilePhotoAfterRegister = true,
    this.minAgeYears = 18,
    this.genderOptions = const [],
    this.termsUrl,
    this.privacyUrl,
  });

  final List<String> requiredFields;
  final List<String> optionalFields;
  final bool profilePhotoAfterRegister;
  final int minAgeYears;
  final List<GenderOptionConfig> genderOptions;
  final String? termsUrl;
  final String? privacyUrl;

  factory RegistrationProductConfigModel.fromJson(Map<String, dynamic> json) {
    final requiredRaw = json['required_fields'];
    final optionalRaw = json['optional_fields'];
    final genderRaw = json['gender_options'];
    final genderOptions = <GenderOptionConfig>[];
    if (genderRaw is List) {
      for (final item in genderRaw) {
        if (item is Map<String, dynamic>) {
          genderOptions.add(GenderOptionConfig.fromJson(item));
        }
      }
    }

    return RegistrationProductConfigModel(
      requiredFields: requiredRaw is List
          ? requiredRaw.map((item) => item.toString()).toList()
          : RegistrationProductConfigModel.defaults.requiredFields,
      optionalFields: optionalRaw is List
          ? optionalRaw.map((item) => item.toString()).toList()
          : RegistrationProductConfigModel.defaults.optionalFields,
      profilePhotoAfterRegister: JsonReaders.boolean(
        json,
        'profile_photo_after_register',
        fallback: true,
      ),
      minAgeYears: JsonReaders.integer(json, 'min_age_years', fallback: 18),
      genderOptions: genderOptions,
      termsUrl: JsonReaders.nullableString(json, 'terms_url') ??
          JsonReaders.nullableString(json, 'termsUrl'),
      privacyUrl: JsonReaders.nullableString(json, 'privacy_url') ??
          JsonReaders.nullableString(json, 'privacyUrl'),
    );
  }

  static const RegistrationProductConfigModel defaults =
      RegistrationProductConfigModel();
}

class UiMessagesConfigModel {
  const UiMessagesConfigModel({
    this.whatsappHelp,
    this.changeNumberConfirm,
  });

  final String? whatsappHelp;
  final String? changeNumberConfirm;

  factory UiMessagesConfigModel.fromJson(Map<String, dynamic> json) {
    return UiMessagesConfigModel(
      whatsappHelp: JsonReaders.nullableString(json, 'whatsapp_help') ??
          JsonReaders.nullableString(json, 'whatsappHelp'),
      changeNumberConfirm:
          JsonReaders.nullableString(json, 'change_number_confirm') ??
              JsonReaders.nullableString(json, 'changeNumberConfirm'),
    );
  }

  static const UiMessagesConfigModel defaults = UiMessagesConfigModel();
}

class CommerceProductConfigModel {
  const CommerceProductConfigModel({
    this.countriesScope = 'chile_and_latam',
    this.multiCurrency = true,
    this.multiLanguage = true,
    this.languageSource = 'country_default',
    this.gateways = const {'CL': 'klap', 'default': 'stripe'},
  });

  final String countriesScope;
  final bool multiCurrency;
  final bool multiLanguage;
  final String languageSource;
  final Map<String, String> gateways;

  factory CommerceProductConfigModel.fromJson(Map<String, dynamic> json) {
    final gatewaysRaw = json['gateways'];
    final gateways = <String, String>{};
    if (gatewaysRaw is Map) {
      gatewaysRaw.forEach((key, value) {
        gateways[key.toString()] = value.toString();
      });
    }

    return CommerceProductConfigModel(
      countriesScope: JsonReaders.string(
        json,
        'countries',
        fallback: 'chile_and_latam',
      ),
      multiCurrency: JsonReaders.boolean(json, 'multi_currency', fallback: true),
      multiLanguage: JsonReaders.boolean(json, 'multi_language', fallback: true),
      languageSource: JsonReaders.string(
        json,
        'language_source',
        fallback: 'country_default',
      ),
      gateways: gateways.isEmpty
          ? CommerceProductConfigModel.defaults.gateways
          : gateways,
    );
  }

  static const CommerceProductConfigModel defaults = CommerceProductConfigModel();
}

class PostRegistrationConfigModel {
  const PostRegistrationConfigModel({
    this.navigateTo = 'you_home',
    this.showWelcomeScreen = true,
    this.welcomeDurationSeconds = 2,
    this.openHamburgerMenu = false,
    this.openProfile = false,
    this.showOnboarding = false,
    this.requestPermissions = false,
    this.showPartyModeBanner = false,
    this.profileCompletionLater = true,
    this.preloadEndpoint = '/home/initial-feed',
    this.analyticsEndpoint = '/analytics/event/registration-completed',
  });

  final String navigateTo;
  final bool showWelcomeScreen;
  final int welcomeDurationSeconds;
  final bool openHamburgerMenu;
  final bool openProfile;
  final bool showOnboarding;
  final bool requestPermissions;
  final bool showPartyModeBanner;
  final bool profileCompletionLater;
  final String preloadEndpoint;
  final String analyticsEndpoint;

  factory PostRegistrationConfigModel.fromJson(Map<String, dynamic> json) {
    return PostRegistrationConfigModel(
      navigateTo: JsonReaders.string(
        json,
        'navigate_to',
        fallback: JsonReaders.string(json, 'navigateTo', fallback: 'you_home'),
      ),
      showWelcomeScreen: JsonReaders.boolean(
        json,
        'show_welcome_screen',
        fallback: JsonReaders.boolean(json, 'showWelcomeScreen', fallback: true),
      ),
      welcomeDurationSeconds: JsonReaders.integer(
        json,
        'welcome_duration_seconds',
        fallback: JsonReaders.integer(
          json,
          'welcomeDurationSeconds',
          fallback: 2,
        ),
      ),
      openHamburgerMenu: JsonReaders.boolean(
        json,
        'open_hamburger_menu',
        fallback: JsonReaders.boolean(json, 'openHamburgerMenu', fallback: false),
      ),
      openProfile: JsonReaders.boolean(
        json,
        'open_profile',
        fallback: JsonReaders.boolean(json, 'openProfile', fallback: false),
      ),
      showOnboarding: JsonReaders.boolean(
        json,
        'show_onboarding',
        fallback: JsonReaders.boolean(json, 'showOnboarding', fallback: false),
      ),
      requestPermissions: JsonReaders.boolean(
        json,
        'request_permissions',
        fallback: JsonReaders.boolean(json, 'requestPermissions', fallback: false),
      ),
      showPartyModeBanner: JsonReaders.boolean(
        json,
        'show_party_mode_banner',
        fallback: JsonReaders.boolean(json, 'showPartyModeBanner', fallback: false),
      ),
      profileCompletionLater: JsonReaders.boolean(
        json,
        'profile_completion_later',
        fallback: JsonReaders.boolean(json, 'profileCompletionLater', fallback: true),
      ),
      preloadEndpoint: JsonReaders.string(
        json,
        'preload_endpoint',
        fallback: JsonReaders.string(
          json,
          'preloadEndpoint',
          fallback: '/home/initial-feed',
        ),
      ),
      analyticsEndpoint: JsonReaders.string(
        json,
        'analytics_endpoint',
        fallback: JsonReaders.string(
          json,
          'analyticsEndpoint',
          fallback: '/analytics/event/registration-completed',
        ),
      ),
    );
  }

  PostRegistrationNavigationEntity toNavigationEntity({
    bool highlightPendingInvitation = false,
    int linkedInvitationsCount = 0,
  }) {
    return PostRegistrationNavigationEntity(
      navigateTo: navigateTo,
      showWelcomeScreen: showWelcomeScreen,
      welcomeDurationSeconds: welcomeDurationSeconds,
      openHamburgerMenu: openHamburgerMenu,
      openProfile: openProfile,
      showOnboarding: showOnboarding,
      requestPermissions: requestPermissions,
      showPartyModeBanner: showPartyModeBanner,
      highlightPendingInvitation: highlightPendingInvitation,
      linkedInvitationsCount: linkedInvitationsCount,
      preloadEndpoint: preloadEndpoint,
    );
  }

  static const PostRegistrationConfigModel defaults = PostRegistrationConfigModel();
}

class ProductConfigModel {
  const ProductConfigModel({
    required this.auth,
    required this.registration,
    required this.commerce,
    required this.uiMessages,
    required this.postRegistration,
  });

  final AuthProductConfigModel auth;
  final RegistrationProductConfigModel registration;
  final CommerceProductConfigModel commerce;
  final UiMessagesConfigModel uiMessages;
  final PostRegistrationConfigModel postRegistration;

  factory ProductConfigModel.fromJson(Map<String, dynamic> json) {
    final authRaw = json['auth'];
    final registrationRaw = json['registration'];
    final commerceRaw = json['commerce'];
    final uiRaw = json['ui_messages'] ?? json['uiMessages'];
    final postRegRaw = json['post_registration'] ?? json['postRegistration'];

    return ProductConfigModel(
      auth: authRaw is Map<String, dynamic>
          ? AuthProductConfigModel.fromJson(authRaw)
          : AuthProductConfigModel.defaults,
      registration: registrationRaw is Map<String, dynamic>
          ? RegistrationProductConfigModel.fromJson(registrationRaw)
          : RegistrationProductConfigModel.defaults,
      commerce: commerceRaw is Map<String, dynamic>
          ? CommerceProductConfigModel.fromJson(commerceRaw)
          : CommerceProductConfigModel.defaults,
      uiMessages: uiRaw is Map<String, dynamic>
          ? UiMessagesConfigModel.fromJson(uiRaw)
          : UiMessagesConfigModel.defaults,
      postRegistration: postRegRaw is Map<String, dynamic>
          ? PostRegistrationConfigModel.fromJson(postRegRaw)
          : PostRegistrationConfigModel.defaults,
    );
  }

  static const ProductConfigModel defaults = ProductConfigModel(
    auth: AuthProductConfigModel.defaults,
    registration: RegistrationProductConfigModel.defaults,
    commerce: CommerceProductConfigModel.defaults,
    uiMessages: UiMessagesConfigModel.defaults,
    postRegistration: PostRegistrationConfigModel.defaults,
  );
}
