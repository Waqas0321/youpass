import 'package:youpass/core/utils/json_readers.dart';

class ProfileWalletTransactionModel {
  const ProfileWalletTransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.type = 'purchase',
  });

  final String id;
  final String description;
  final double amount;
  final String currency;
  final String status;
  final String createdAt;
  final String type;

  factory ProfileWalletTransactionModel.fromJson(Map<String, dynamic> json) {
    final amountRaw = json['amount'];
    return ProfileWalletTransactionModel(
      id: JsonReaders.string(json, 'id'),
      description: JsonReaders.string(json, 'description', fallback: ''),
      amount: amountRaw is num ? amountRaw.toDouble() : 0,
      currency: JsonReaders.string(json, 'currency', fallback: 'CLP'),
      status: JsonReaders.string(json, 'status', fallback: 'paid'),
      createdAt: json['created_at']?.toString() ??
          json['createdAt']?.toString() ??
          '',
      type: JsonReaders.string(json, 'type', fallback: 'purchase'),
    );
  }
}
