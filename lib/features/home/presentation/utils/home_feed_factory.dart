import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/data/datasources/home_mock_data.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class HomeFeedFactory {
  HomeFeedFactory._();

  static HomeFeedEntity create(AppLocalizations l10n) {
    return HomeMockData.buildFeed(
      labels: AppStrings.homeFeedLabels(l10n),
    );
  }
}
