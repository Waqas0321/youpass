import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/favorites/presentation/data/favorites_mock_data.dart';
import 'package:youpass/l10n/app_localizations.dart';

class FavoritesTextFactory {
  FavoritesTextFactory._();

  static String producerDescription(
    AppLocalizations strings,
    String producerId,
  ) {
    switch (producerId) {
      case FavoritesMockData.youfestId:
        return AppStrings.favoritesYoufestDescription(strings);
      case FavoritesMockData.iguanaId:
        return AppStrings.favoritesIguanaDescription(strings);
      default:
        return '';
    }
  }
}
