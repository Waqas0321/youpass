import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/profile/data/models/profile_banner_status_model.dart';
import 'package:youpass/features/profile/data/models/profile_notification_settings_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_balance_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_data_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_transaction_model.dart';
import 'package:youpass/features/invitations/data/models/payment_method_request_model.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/profile/data/models/support_faq_model.dart';

class ProfileApiService extends BaseApiService {
  ProfileApiService(super.apiClient);

  Future<UserProfileModel> updateProfile(Map<String, dynamic> body) {
    return patchModel(
      ApiEndpoints.userProfile,
      body: body,
      fromJson: UserProfileModel.fromJson,
      authenticated: true,
    );
  }

  Future<ProfileBannerStatusModel> fetchBannerStatus() {
    return getModel(
      ApiEndpoints.userProfileBannerStatus,
      fromJson: ProfileBannerStatusModel.fromJson,
      authenticated: true,
    );
  }

  Future<void> dismissBanner() {
    return postVoid(
      ApiEndpoints.userProfileBannerDismiss,
      authenticated: true,
    );
  }

  Future<ProfileNotificationSettingsModel> fetchNotificationSettings() {
    return getModel(
      ApiEndpoints.userNotificationSettings,
      fromJson: ProfileNotificationSettingsModel.fromJson,
      authenticated: true,
    );
  }

  Future<ProfileNotificationSettingsModel> updateNotificationSettings(
    Map<String, dynamic> body,
  ) {
    return patchModel(
      ApiEndpoints.userNotificationSettings,
      body: body,
      fromJson: ProfileNotificationSettingsModel.fromJson,
      authenticated: true,
    );
  }

  Future<ProfileNotificationSettingsModel> toggleNotificationsMaster(
    bool enabled,
  ) {
    return postModel(
      ApiEndpoints.userNotificationsToggle,
      body: {'enabled': enabled},
      fromJson: ProfileNotificationSettingsModel.fromJson,
      authenticated: true,
    );
  }

  Future<ProfileWalletDataModel> fetchWalletData() async {
    final raw = await getRawData(
      ApiEndpoints.userWalletCards,
      authenticated: true,
    );

    if (raw is Map<String, dynamic>) {
      return ProfileWalletDataModel.fromJson(raw);
    }

    if (raw is List) {
      return ProfileWalletDataModel(
        cards: raw
            .whereType<Map<String, dynamic>>()
            .map(ProfileWalletCardModel.fromJson)
            .toList(),
        balance: ProfileWalletBalanceModel.empty,
      );
    }

    return const ProfileWalletDataModel(
      cards: [],
      balance: ProfileWalletBalanceModel.empty,
    );
  }

  Future<List<ProfileWalletCardModel>> fetchWalletCards() async {
    final data = await fetchWalletData();
    return data.cards;
  }

  Future<ProfileWalletBalanceModel> fetchWalletBalance() async {
    return getModel(
      ApiEndpoints.userWalletBalance,
      fromJson: ProfileWalletBalanceModel.fromJson,
      authenticated: true,
    );
  }

  Future<List<ProfileWalletTransactionModel>> fetchWalletTransactions() async {
    final raw = await getRawData(
      ApiEndpoints.userWalletTransactions,
      authenticated: true,
    );

    if (raw is Map<String, dynamic>) {
      final transactions = raw['transactions'];
      if (transactions is List) {
        return transactions
            .whereType<Map<String, dynamic>>()
            .map(ProfileWalletTransactionModel.fromJson)
            .toList();
      }
    }

    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map(ProfileWalletTransactionModel.fromJson)
          .toList();
    }

    return const [];
  }

  Future<ProfileWalletTokenizeSessionModel> createWalletTokenizeSession() {
    return postModel(
      ApiEndpoints.userWalletCardsTokenizeSession,
      fromJson: ProfileWalletTokenizeSessionModel.fromJson,
      authenticated: true,
    );
  }

  Future<ProfileWalletCardModel> saveWalletCard(
    PaymentMethodRequestEntity request,
  ) {
    return postModel(
      ApiEndpoints.userWalletCards,
      body: PaymentMethodRequestModel.fromEntity(request).toJson(),
      fromJson: ProfileWalletCardModel.fromJson,
      authenticated: true,
    );
  }

  Future<void> deleteWalletCard(String cardId) {
    return deleteVoid(
      ApiEndpoints.walletCard(cardId),
      authenticated: true,
    );
  }

  Future<void> setDefaultWalletCard(String cardId) {
    return patchVoid(
      ApiEndpoints.walletCardDefault(cardId),
      authenticated: true,
    );
  }

  Future<SupportContactModel> fetchSupportContact() {
    return getModel(
      ApiEndpoints.supportContactInfo,
      fromJson: SupportContactModel.fromJson,
      authenticated: false,
    );
  }

  Future<SupportFaqResponseModel> fetchFaqs({String? query}) {
    final endpoint = query == null || query.trim().isEmpty
        ? ApiEndpoints.supportFaqs
        : '${ApiEndpoints.supportFaqs}?q=${Uri.encodeQueryComponent(query.trim())}';

    return getModel(
      endpoint,
      fromJson: SupportFaqResponseModel.fromJson,
      authenticated: false,
    );
  }

  Future<Map<String, dynamic>> fetchWhatsAppTemplate({String? context}) {
    final endpoint = context == null || context.isEmpty
        ? ApiEndpoints.supportWhatsAppTemplate
        : '${ApiEndpoints.supportWhatsAppTemplate}?context=${Uri.encodeQueryComponent(context)}';

    return getData(endpoint, authenticated: true);
  }

  Future<Map<String, dynamic>> fetchEmailTemplate({String? context}) {
    final endpoint = context == null || context.isEmpty
        ? ApiEndpoints.supportEmailTemplate
        : '${ApiEndpoints.supportEmailTemplate}?context=${Uri.encodeQueryComponent(context)}';

    return getData(endpoint, authenticated: true);
  }

  Future<Map<String, dynamic>> fetchCategoryBenefits() {
    return getData(ApiEndpoints.userCategoryBenefits, authenticated: true);
  }

  Future<Map<String, dynamic>> fetchDeletionStatus() {
    return getData(ApiEndpoints.userAccountDeletionStatus, authenticated: true);
  }

  Future<void> cancelAccountDeletion() {
    return postVoid(
      ApiEndpoints.userAccountDeleteCancel,
      authenticated: true,
    );
  }

  Future<void> submitFaqFeedback(String faqId, bool helpful) {
    return postVoid(
      ApiEndpoints.supportFaqFeedback(faqId),
      body: {'helpful': helpful},
      authenticated: false,
    );
  }
}

class ProfileUpdatePayload {
  ProfileUpdatePayload({
    this.fullName,
    this.email,
    this.birthdate,
    this.gender,
    this.instagramUsername,
  });

  final String? fullName;
  final String? email;
  final String? birthdate;
  final String? gender;
  final String? instagramUsername;

  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (birthdate != null) 'birthdate': birthdate,
      if (gender != null) 'gender': gender,
      if (instagramUsername != null) 'instagram_username': instagramUsername,
    };
  }

  static String? normalizeInstagram(String? value) {
    if (value == null) {
      return null;
    }

    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    return trimmed.replaceFirst(RegExp(r'^@+'), '');
  }

  static String? apiGender(String display, String localeCode) {
    final normalized = display.trim().toLowerCase();
    if (normalized.contains('male') || normalized == 'hombre' || normalized == 'homem') {
      return 'male';
    }
    if (normalized.contains('female') || normalized == 'mujer' || normalized == 'mulher') {
      return 'female';
    }
    if (normalized.contains('other') || normalized == 'otro' || normalized == 'outro') {
      return 'other';
    }
    return 'prefer_not_to_say';
  }

  static String formatBirthdateForApi(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static DateTime? parseBirthdate(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    final iso = DateTime.tryParse(trimmed);
    if (iso != null) {
      return DateTime(iso.year, iso.month, iso.day);
    }

    final parts = trimmed.split('/');
    if (parts.length == 3) {
      final day = int.tryParse(parts[0].trim());
      final month = int.tryParse(parts[1].trim());
      final year = int.tryParse(parts[2].trim());
      if (day != null && month != null && year != null) {
        return DateTime(year, month, day);
      }
    }

    return null;
  }

  static int ageFromBirthdate(DateTime birthdate) {
    final now = DateTime.now();
    var age = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      age--;
    }
    return age;
  }
}
