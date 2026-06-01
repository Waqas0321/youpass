import 'package:youpass/features/home/data/models/home_feed_labels.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AppStrings {
  AppStrings._();

  static String defaultGuestName(AppLocalizations l10n) => l10n.defaultGuestName;

  static String brandBadgeOff(AppLocalizations l10n) => l10n.brandBadgeOff;

  static String homeGreeting(AppLocalizations l10n, String name) =>
      l10n.homeGreeting(name);

  static String homeDiscoverSubtitle(AppLocalizations l10n) =>
      l10n.homeDiscoverSubtitle;

  static String eventsSectionTitle(AppLocalizations l10n) =>
      l10n.eventsSectionTitle;

  static String seeAll(AppLocalizations l10n) => l10n.seeAll;

  static String buyTickets(AppLocalizations l10n) => l10n.buyTickets;

  static String errorGeneric(AppLocalizations l10n) => l10n.errorGeneric;

  static String selectCountryTitle(AppLocalizations l10n) =>
      l10n.selectCountryTitle;

  static String searchCountryHint(AppLocalizations l10n) =>
      l10n.searchCountryHint;

  static String searchCountryEmpty(AppLocalizations l10n) =>
      l10n.searchCountryEmpty;

  static HomeFeedLabels homeFeedLabels(AppLocalizations l10n) {
    return HomeFeedLabels(
      chileLabel: l10n.categoryChile,
      partiesLabel: l10n.categoryParties,
      concertsLabel: l10n.categoryConcerts,
      sportsLabel: l10n.categorySports,
      featuredTitle: l10n.featuredEventTitle,
      featuredDate: l10n.featuredEventDate,
      featuredLocation: l10n.featuredEventLocation,
      featuredSummerTitle: l10n.featuredEventSummerTitle,
      featuredUrbanTitle: l10n.featuredEventUrbanTitle,
      eventCaribeTitle: l10n.eventCaribeTitle,
      eventRockTitle: l10n.eventRockTitle,
      caribeDate: l10n.eventCaribeDate,
      caribeLocation: l10n.eventCaribeLocation,
      rockDate: l10n.eventRockDate,
      rockLocation: l10n.eventRockLocation,
    );
  }
}
