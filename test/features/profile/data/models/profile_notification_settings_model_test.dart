import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/profile/data/models/profile_notification_settings_model.dart';

void main() {
  test('ProfileNotificationSettingsModel parses full API payload', () {
    final model = ProfileNotificationSettingsModel.fromJson({
      'master_enabled': false,
      'channels': {
        'email': true,
        'push': false,
        'whatsapp': true,
      },
      'types': {
        'purchases': {'email': true, 'push': true, 'whatsapp': false},
        'reminders': {'email': false, 'push': true, 'whatsapp': true},
        'promotions': {'email': true, 'push': false, 'whatsapp': false},
        'social': {'email': false, 'push': true, 'whatsapp': false},
      },
      'night_silence': {
        'enabled': true,
        'from_hour': 23,
      },
      'critical_always_on': [
        'event_cancellation',
        'payment_receipts',
      ],
    });

    expect(model.masterEnabled, isFalse);
    expect(model.emailEnabled, isTrue);
    expect(model.pushEnabled, isFalse);
    expect(model.whatsappEnabled, isTrue);
    expect(model.types[NotificationTypeKey.reminders]?.email, isFalse);
    expect(model.nightSilence.enabled, isTrue);
    expect(model.nightSilence.fromHour, 23);
    expect(model.criticalAlwaysOn, ['event_cancellation', 'payment_receipts']);
  });

  test('patch builders emit partial update payloads', () {
    const model = ProfileNotificationSettingsModel(
      masterEnabled: true,
      channels: NotificationChannelPreferences.defaults,
      types: {},
      nightSilence: NotificationNightSilenceSettings.empty,
      criticalAlwaysOn: ProfileNotificationSettingsModel.defaultCriticalKeys,
    );

    expect(
      model.patchChannel(channel: 'push', enabled: false),
      {'channels': {'push': false}},
    );
    expect(
      model.patchTypeChannel(
        type: NotificationTypeKey.social,
        channel: 'whatsapp',
        enabled: true,
      ),
      {
        'types': {
          'social': {'whatsapp': true},
        },
      },
    );
    expect(
      model.patchNightSilence(
        const NotificationNightSilenceSettings(enabled: true, fromHour: 22),
      ),
      {
        'night_silence': {'enabled': true, 'from_hour': 22},
      },
    );
  });
}
