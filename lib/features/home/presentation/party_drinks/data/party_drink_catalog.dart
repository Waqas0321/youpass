import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_menu_category.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drink_assets.dart';

class PartyDrinkCatalog {
  PartyDrinkCatalog._();

  static const List<PartyDrinkMenuCategory> categories = [
    PartyDrinkMenuCategory(slug: PartyDrinkMenuCategory.allSlug, name: 'All'),
    PartyDrinkMenuCategory(slug: 'piscos', name: 'Piscos'),
    PartyDrinkMenuCategory(slug: 'beers', name: 'Beers'),
    PartyDrinkMenuCategory(slug: 'sparkling', name: 'Sparkling'),
    PartyDrinkMenuCategory(slug: 'energy', name: 'Energy'),
  ];

  static const List<PartyDrinkItem> drinks = [
    PartyDrinkItem(
      id: 'piscola',
      categorySlug: 'piscos',
      name: AppStrings.partyDrinkMockPiscola,
      description: AppStrings.partyDrinkMockPiscolaDesc,
      volumeMl: 350,
      priceClp: 4500,
      imageAsset: PartyDrinkAssets.piscola,
      isRecommended: true,
    ),
    PartyDrinkItem(
      id: 'jager-bomb',
      categorySlug: 'energy',
      name: AppStrings.partyDrinkMockJagerBomb,
      description: AppStrings.partyDrinkMockJagerBombDesc,
      volumeMl: 250,
      priceClp: 5000,
      imageAsset: PartyDrinkAssets.jagerBomb,
      isRecommended: true,
    ),
    PartyDrinkItem(
      id: 'tropical-gin',
      categorySlug: 'piscos',
      name: AppStrings.partyDrinkMockTropicalGin,
      description: AppStrings.partyDrinkMockTropicalGinDesc,
      volumeMl: 350,
      priceClp: 6000,
      imageAsset: PartyDrinkAssets.tropicalGin,
      isRecommended: true,
    ),
    PartyDrinkItem(
      id: 'cuba-libre',
      categorySlug: 'piscos',
      name: AppStrings.partyDrinkMockCubaLibre,
      description: AppStrings.partyDrinkMockCubaLibreDesc,
      volumeMl: 350,
      priceClp: 4200,
      imageAsset: PartyDrinkAssets.cubaLibre,
    ),
    PartyDrinkItem(
      id: 'corona',
      categorySlug: 'beers',
      name: AppStrings.partyDrinkMockCorona,
      description: AppStrings.partyDrinkMockCoronaDesc,
      volumeMl: 330,
      priceClp: 3500,
      imageAsset: PartyDrinkAssets.corona,
    ),
    PartyDrinkItem(
      id: 'chandon',
      categorySlug: 'sparkling',
      name: AppStrings.partyDrinkMockChandon,
      description: AppStrings.partyDrinkMockChandonDesc,
      volumeMl: 750,
      priceClp: 12000,
      imageAsset: PartyDrinkAssets.chandon,
    ),
  ];

  static List<PartyDrinkItem> drinksForCategories(
    List<PartyDrinkItem> drinks,
    Set<String> categorySlugs,
  ) {
    if (categorySlugs.isEmpty ||
        categorySlugs.contains(PartyDrinkMenuCategory.allSlug)) {
      return drinks;
    }

    return drinks
        .where((drink) => categorySlugs.contains(drink.categorySlug))
        .toList();
  }

  static List<PartyDrinkItem> recommendedDrinksForCategories(
    List<PartyDrinkItem> drinks,
    Set<String> categorySlugs,
  ) {
    return drinksForCategories(drinks, categorySlugs)
        .where((drink) => drink.isRecommended)
        .toList();
  }
}
