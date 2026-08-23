import 'package:youpass/core/utils/json_readers.dart';

class ProfileWalletCardModel {
  const ProfileWalletCardModel({
    required this.id,
    required this.brand,
    required this.lastFour,
    required this.isDefault,
    this.expirationMonth,
    this.expirationYear,
    this.holderName,
    this.gateway,
    this.chargeable = true,
  });

  final String id;
  final String brand;
  final String lastFour;
  final bool isDefault;
  final int? expirationMonth;
  final int? expirationYear;
  final String? holderName;
  final String? gateway;
  final bool chargeable;

  factory ProfileWalletCardModel.fromJson(Map<String, dynamic> json) {
    final isDefault = json['is_default'] is bool
        ? json['is_default'] as bool
        : json['isDefault'] is bool
            ? json['isDefault'] as bool
            : false;

    return ProfileWalletCardModel(
      id: JsonReaders.string(json, 'id'),
      brand: JsonReaders.string(json, 'brand', fallback: 'visa'),
      lastFour: JsonReaders.string(json, 'last_four', fallback: '0000'),
      isDefault: isDefault,
      expirationMonth: _nullableInt(json['expiration_month']),
      expirationYear: _nullableInt(json['expiration_year']),
      holderName: JsonReaders.nullableStringWithAlt(
        json,
        'holder_name',
        altKeys: const ['holderName', 'cardholder_name'],
      ),
      gateway: JsonReaders.nullableStringWithAlt(
        json,
        'gateway',
        altKeys: const ['payment_gateway', 'paymentGateway'],
      ),
      chargeable: json['chargeable'] is bool ? json['chargeable'] as bool : true,
    );
  }

  String get displaySubtitle {
    final parts = <String>[];
    final name = holderName?.trim();
    if (name != null && name.isNotEmpty) {
      parts.add(name);
    }
    if (expirationMonth != null && expirationYear != null) {
      final month = expirationMonth!.toString().padLeft(2, '0');
      final year = expirationYear! % 100;
      parts.add('$month/${year.toString().padLeft(2, '0')}');
    }
    return parts.join(' · ');
  }

  String get displayExpiry {
    if (expirationMonth == null || expirationYear == null) {
      return '';
    }
    final month = expirationMonth!.toString().padLeft(2, '0');
    final year = expirationYear! % 100;
    return '$month/${year.toString().padLeft(2, '0')}';
  }

  String get maskedLabel {
    final normalizedBrand = brand.toLowerCase();
    final label = normalizedBrand == 'mastercard'
        ? 'Mastercard'
        : normalizedBrand == 'amex'
            ? 'Amex'
            : normalizedBrand == 'diners'
                ? 'Diners'
                : 'Visa';
    return '$label ••••$lastFour';
  }
}

int? _nullableInt(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return null;
}
