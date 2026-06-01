import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';

import '../../../../helpers/test_fixtures.dart';

void main() {
  group('UserModel', () {
    test('toJson and fromJson round-trip', () {
      final json = TestFixtures.testUser.toJson();
      final restored = UserModel.fromJson(json);

      expect(restored, TestFixtures.testUser);
    });

    test('fromEntity maps fields correctly', () {
      final model = UserModel.fromEntity(TestFixtures.testUser);

      expect(model.id, TestFixtures.testUser.id);
      expect(model.email, TestFixtures.testUser.email);
      expect(model.name, TestFixtures.testUser.name);
    });
  });
}
