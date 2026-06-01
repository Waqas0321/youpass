import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/home/data/models/home_model.dart';

class TestFixtures {
  static const UserModel testUser = UserModel(
    id: 'test-1',
    email: 'test@youpass.com',
    name: 'test',
  );

  static const HomeModel testHome = HomeModel(
    title: 'Test Dashboard',
    subtitle: 'Test subtitle',
  );

  static const String testPhone = '912345678';
  static const String testEmail = 'test@youpass.com';
  static const String testPassword = 'password123';
  static const String testToken = 'mock_token_test-1';
}
