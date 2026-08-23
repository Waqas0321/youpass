import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_balance_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';

class ProfileWalletDataModel {
  const ProfileWalletDataModel({
    required this.cards,
    required this.balance,
  });

  final List<ProfileWalletCardModel> cards;
  final ProfileWalletBalanceModel balance;

  factory ProfileWalletDataModel.fromJson(Map<String, dynamic> json) {
    final cardsRaw = json['cards'] ?? json['payment_methods'];
    final cards = cardsRaw is List
        ? cardsRaw
            .whereType<Map<String, dynamic>>()
            .map(ProfileWalletCardModel.fromJson)
            .toList()
        : const <ProfileWalletCardModel>[];

    final balanceRaw = json['balance'];
    final balance = balanceRaw is Map<String, dynamic>
        ? ProfileWalletBalanceModel.fromJson(balanceRaw)
        : ProfileWalletBalanceModel.empty;

    return ProfileWalletDataModel(cards: cards, balance: balance);
  }
}

class ProfileWalletTokenizeSessionModel {
  const ProfileWalletTokenizeSessionModel({
    required this.gateway,
    required this.sessionId,
    required this.tokenizationUrl,
    required this.successRedirectScheme,
  });

  final String gateway;
  final String sessionId;
  final String tokenizationUrl;
  final String successRedirectScheme;

  factory ProfileWalletTokenizeSessionModel.fromJson(Map<String, dynamic> json) {
    return ProfileWalletTokenizeSessionModel(
      gateway: JsonReaders.string(json, 'gateway', fallback: 'kushki'),
      sessionId: _readString(json, 'session_id', 'sessionId'),
      tokenizationUrl: _readString(json, 'tokenization_url', 'tokenizationUrl'),
      successRedirectScheme: _readString(
        json,
        'success_redirect_scheme',
        'successRedirectScheme',
        fallback: 'youpass://wallet/tokenized',
      ),
    );
  }
}

String _readString(
  Map<String, dynamic> json,
  String snakeKey,
  String camelKey, {
  String fallback = '',
}) {
  return JsonReaders.string(json, snakeKey, fallback: fallback).isNotEmpty
      ? JsonReaders.string(json, snakeKey)
      : JsonReaders.string(json, camelKey, fallback: fallback);
}
