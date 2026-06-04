import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';

void main() {
  test('fromJson parses welcome block for new users', () {
    final session = AuthSessionModel.fromJson({
      'access_token': 'token',
      'session_id': 'sess-1',
      'is_new_user': true,
      'user': {'id': '1', 'phone': '+56912345678', 'full_name': 'Test'},
      'welcome': {
        'title': 'Welcome to YouPass, Test!',
        'subtitle': 'Your access starts here',
        'duration_seconds': 2,
      },
    });

    expect(session.accessToken, 'token');
    expect(session.isNewUser, isTrue);
    expect(session.welcome?.title, contains('Welcome'));
    expect(session.welcome?.durationSeconds, 2);
  });

  test('fromJson trims access token and keeps login user json', () {
    final session = AuthSessionModel.fromJson({
      'access_token': '  token-with-space  ',
      'user': {
        'id': '1',
        'fullName': 'Test',
        'countryCode': 'PK',
      },
    });

    expect(session.accessToken, 'token-with-space');
    expect(session.cachedLoginProfile?.fullName, 'Test');
  });
}
