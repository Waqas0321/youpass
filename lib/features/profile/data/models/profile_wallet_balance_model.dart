import 'package:youpass/core/utils/json_readers.dart';

class ProfileWalletBalanceModel {
  const ProfileWalletBalanceModel({
    required this.credits,
    required this.currency,
  });

  final double credits;
  final String currency;

  factory ProfileWalletBalanceModel.fromJson(Map<String, dynamic> json) {
    final creditsRaw = json['credits'];
    return ProfileWalletBalanceModel(
      credits: creditsRaw is num ? creditsRaw.toDouble() : 0,
      currency: JsonReaders.string(json, 'currency', fallback: 'CLP'),
    );
  }

  static const ProfileWalletBalanceModel empty =
      ProfileWalletBalanceModel(credits: 0, currency: 'CLP');
}
