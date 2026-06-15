import 'package:youpass/core/utils/json_readers.dart';

enum NotificationTypeKey {
  purchases,
  reminders,
  promotions,
  social,
}

extension NotificationTypeKeyX on NotificationTypeKey {
  String get apiKey => name;

  static NotificationTypeKey? tryParse(String? value) {
    if (value == null) {
      return null;
    }
    for (final type in NotificationTypeKey.values) {
      if (type.name == value) {
        return type;
      }
    }
    return null;
  }
}

class NotificationChannelPreferences {
  const NotificationChannelPreferences({
    required this.email,
    required this.push,
    required this.whatsapp,
  });

  final bool email;
  final bool push;
  final bool whatsapp;

  static const defaults = NotificationChannelPreferences(
    email: true,
    push: true,
    whatsapp: false,
  );

  factory NotificationChannelPreferences.fromJson(
    Map<String, dynamic>? json, {
    NotificationChannelPreferences fallback = defaults,
  }) {
    if (json == null) {
      return fallback;
    }

    return NotificationChannelPreferences(
      email: JsonReaders.boolean(json, 'email', fallback: fallback.email),
      push: JsonReaders.boolean(json, 'push', fallback: fallback.push),
      whatsapp: JsonReaders.boolean(json, 'whatsapp', fallback: fallback.whatsapp),
    );
  }

  NotificationChannelPreferences copyWith({
    bool? email,
    bool? push,
    bool? whatsapp,
  }) {
    return NotificationChannelPreferences(
      email: email ?? this.email,
      push: push ?? this.push,
      whatsapp: whatsapp ?? this.whatsapp,
    );
  }

  Map<String, bool> toJson() {
    return {
      'email': email,
      'push': push,
      'whatsapp': whatsapp,
    };
  }
}

class NotificationNightSilenceSettings {
  const NotificationNightSilenceSettings({
    required this.enabled,
    this.fromHour,
  });

  final bool enabled;
  final int? fromHour;

  static const empty = NotificationNightSilenceSettings(enabled: false);

  factory NotificationNightSilenceSettings.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return empty;
    }

    final fromHourRaw = json['from_hour'];
    return NotificationNightSilenceSettings(
      enabled: JsonReaders.boolean(json, 'enabled'),
      fromHour: fromHourRaw is num ? fromHourRaw.toInt() : null,
    );
  }

  NotificationNightSilenceSettings copyWith({
    bool? enabled,
    int? fromHour,
    bool clearFromHour = false,
  }) {
    return NotificationNightSilenceSettings(
      enabled: enabled ?? this.enabled,
      fromHour: clearFromHour ? null : (fromHour ?? this.fromHour),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'from_hour': fromHour,
    };
  }
}

class ProfileNotificationSettingsModel {
  const ProfileNotificationSettingsModel({
    required this.masterEnabled,
    required this.channels,
    required this.types,
    required this.nightSilence,
    required this.criticalAlwaysOn,
  });

  final bool masterEnabled;
  final NotificationChannelPreferences channels;
  final Map<NotificationTypeKey, NotificationChannelPreferences> types;
  final NotificationNightSilenceSettings nightSilence;
  final List<String> criticalAlwaysOn;

  bool get emailEnabled => channels.email;
  bool get pushEnabled => channels.push;
  bool get whatsappEnabled => channels.whatsapp;

  static const defaultCriticalKeys = [
    'event_cancellation',
    'event_datetime_change',
    'event_venue_change',
    'security_alerts',
    'payment_receipts',
    'processed_refunds',
  ];

  factory ProfileNotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    final channelsRaw = json['channels'];
    final typesRaw = json['types'];
    final nightSilenceRaw = json['night_silence'];
    final criticalRaw = json['critical_always_on'];

    final types = <NotificationTypeKey, NotificationChannelPreferences>{};
    if (typesRaw is Map<String, dynamic>) {
      for (final type in NotificationTypeKey.values) {
        final rawType = typesRaw[type.apiKey];
        types[type] = NotificationChannelPreferences.fromJson(
          rawType is Map<String, dynamic> ? rawType : null,
          fallback: _defaultForType(type),
        );
      }
    } else {
      for (final type in NotificationTypeKey.values) {
        types[type] = _defaultForType(type);
      }
    }

    return ProfileNotificationSettingsModel(
      masterEnabled: JsonReaders.boolean(json, 'master_enabled', fallback: true),
      channels: channelsRaw is Map<String, dynamic>
          ? NotificationChannelPreferences.fromJson(channelsRaw)
          : NotificationChannelPreferences.defaults,
      types: types,
      nightSilence: nightSilenceRaw is Map<String, dynamic>
          ? NotificationNightSilenceSettings.fromJson(nightSilenceRaw)
          : NotificationNightSilenceSettings.empty,
      criticalAlwaysOn: criticalRaw is List
          ? criticalRaw.whereType<String>().toList()
          : defaultCriticalKeys,
    );
  }

  static NotificationChannelPreferences defaultForType(NotificationTypeKey type) {
    return _defaultForType(type);
  }

  static NotificationChannelPreferences _defaultForType(NotificationTypeKey type) {
    return switch (type) {
      NotificationTypeKey.purchases => const NotificationChannelPreferences(
          email: true,
          push: true,
          whatsapp: false,
        ),
      NotificationTypeKey.reminders => const NotificationChannelPreferences(
          email: true,
          push: true,
          whatsapp: true,
        ),
      NotificationTypeKey.promotions => const NotificationChannelPreferences(
          email: true,
          push: true,
          whatsapp: false,
        ),
      NotificationTypeKey.social => const NotificationChannelPreferences(
          email: false,
          push: true,
          whatsapp: true,
        ),
    };
  }

  ProfileNotificationSettingsModel copyWith({
    bool? masterEnabled,
    NotificationChannelPreferences? channels,
    Map<NotificationTypeKey, NotificationChannelPreferences>? types,
    NotificationNightSilenceSettings? nightSilence,
    List<String>? criticalAlwaysOn,
  }) {
    return ProfileNotificationSettingsModel(
      masterEnabled: masterEnabled ?? this.masterEnabled,
      channels: channels ?? this.channels,
      types: types ?? this.types,
      nightSilence: nightSilence ?? this.nightSilence,
      criticalAlwaysOn: criticalAlwaysOn ?? this.criticalAlwaysOn,
    );
  }

  Map<String, dynamic> patchMaster(bool enabled) {
    return {'master_enabled': enabled};
  }

  Map<String, dynamic> patchChannel({
    required String channel,
    required bool enabled,
  }) {
    return {
      'channels': {channel: enabled},
    };
  }

  Map<String, dynamic> patchTypeChannel({
    required NotificationTypeKey type,
    required String channel,
    required bool enabled,
  }) {
    return {
      'types': {
        type.apiKey: {channel: enabled},
      },
    };
  }

  Map<String, dynamic> patchNightSilence(NotificationNightSilenceSettings value) {
    return {'night_silence': value.toJson()};
  }
}
