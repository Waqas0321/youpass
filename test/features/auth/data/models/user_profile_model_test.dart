import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';

void main() {
  group('UserProfileModel.fromJson', () {
    test('parses ISO birthdate and nested user payload', () {
      final profile = UserProfileModel.fromJson({
        'user': {
          '_id': '6ale65f627aa1ba28c27b837',
          'phone': '+923216548001',
          'phone_display': '+92 321 6548001',
          'country_code': 'PK',
          'full_name': 'Waqas Akhtar',
          'email': 'waqasakhtar548@gmail.com',
          'birthdate': '2003-06-02T00:00:00.000+00:00',
          'gender': 'male',
          'instagram_username': 'Waqas0321',
          'category': 'bronze',
          'account_status': 'active',
          'created_at': '2026-06-02T05:11:18.353+00:00',
        },
      });

      expect(profile.id, '6ale65f627aa1ba28c27b837');
      expect(profile.birthdate, '2003-06-02');
      expect(profile.gender, 'male');
      expect(profile.instagramUsername, 'Waqas0321');
      expect(profile.fullName, 'Waqas Akhtar');
    });

    test('parses login user object with camelCase keys', () {
      final profile = UserProfileModel.fromJson({
        'id': '6a1e65f627aa1ba28c27b837',
        'phone': '+923216548001',
        'countryCode': 'PK',
        'fullName': 'Waqas Akhtar',
        'email': 'waqasakhtar548@gmail.com',
        'birthdate': '2003-06-02',
        'gender': 'male',
        'instagramUsername': 'Waqas0321',
        'category': 'bronze',
        'createdAt': '2026-06-02T05:11:18.353Z',
      });

      expect(profile.countryCode, 'PK');
      expect(profile.fullName, 'Waqas Akhtar');
      expect(profile.instagramUsername, 'Waqas0321');
      expect(profile.birthdate, '2003-06-02');
    });

    test('parses flat payload with YYYY-MM-DD birthdate', () {
      final profile = UserProfileModel.fromJson({
        'id': 'user-1',
        'phone': '+56912345678',
        'phone_display': '+56 9 1234 5678',
        'country_code': 'CL',
        'full_name': 'Test User',
        'email': 'test@email.com',
        'birthdate': '1995-06-15',
        'gender': 'female',
        'instagram_username': 'alerub',
        'rut_or_passport': '123',
        'category': 'gold',
        'account_status': 'active',
        'created_at': '2026-06-01T12:00:00.000Z',
        'profile_completeness': {
          'has_photo': false,
          'has_instagram': true,
          'completion_percentage': 70,
          'missing_fields': ['profile_photo'],
        },
      });

      expect(profile.birthdate, '1995-06-15');
      expect(profile.gender, 'female');
      expect(profile.instagramUsername, 'alerub');
    });
  });

  group('UserProfileModel.fromRegisterRequest', () {
    test('stores registration fields for immediate profile UI', () {
      const request = RegisterRequestEntity(
        phone: '3216548001',
        countryIsoCode: 'PK',
        code: '123456',
        fullName: 'Waqas Akhtar',
        documentId: '0987655544444',
        birthDate: '2003-06-02',
        gender: 'male',
        email: 'waqasakhtar548@gmail.com',
        instagram: 'Waqas0321',
      );

      final profile = UserProfileModel.fromRegisterRequest(
        user: UserModel(
          id: 'user-1',
          email: request.email,
          name: request.fullName,
        ),
        request: request,
        phone: '+923216548001',
        phoneDisplay: '+92 321 6548001',
      );

      expect(profile.birthdate, '2003-06-02');
      expect(profile.gender, 'male');
      expect(profile.instagramUsername, 'Waqas0321');
    });
  });
}
