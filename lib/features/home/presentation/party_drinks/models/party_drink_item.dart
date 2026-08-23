import 'package:youpass/l10n/app_localizations.dart';

typedef PartyDrinkLocalizedText = String Function(AppLocalizations l10n);

class PartyDrinkItem {
  const PartyDrinkItem({
    required this.id,
    required this.categorySlug,
    this.name,
    this.description,
    this.nameText,
    this.descriptionText,
    required this.volumeMl,
    required this.priceClp,
    this.imageAsset,
    this.imageUrl,
    this.isRecommended = false,
    this.isAvailable = true,
    this.eventId,
    this.eventTitle,
  });

  final String id;
  final String categorySlug;
  final PartyDrinkLocalizedText? name;
  final PartyDrinkLocalizedText? description;
  final String? nameText;
  final String? descriptionText;
  final int volumeMl;
  final int priceClp;
  final String? imageAsset;
  final String? imageUrl;
  final bool isRecommended;
  final bool isAvailable;
  final String? eventId;
  final String? eventTitle;

  String displayName(AppLocalizations l10n) {
    if (nameText != null && nameText!.isNotEmpty) {
      return nameText!;
    }
    return name?.call(l10n) ?? '';
  }

  String displayDescription(AppLocalizations l10n) {
    if (descriptionText != null && descriptionText!.isNotEmpty) {
      return descriptionText!;
    }
    return description?.call(l10n) ?? '';
  }

  bool get hasNetworkImage => imageUrl != null && imageUrl!.trim().isNotEmpty;
}
