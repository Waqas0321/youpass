import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_menu_category.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_category_filter.dart';

void main() {
  test('toggleCategory selects All exclusively', () {
    final result = PartyDrinkCategoryFilter.toggleCategory(
      {'piscos', 'beers'},
      PartyDrinkMenuCategory.allSlug,
    );

    expect(result, {PartyDrinkMenuCategory.allSlug});
  });

  test('toggleCategory supports multiple drink categories', () {
    var selected = {PartyDrinkMenuCategory.allSlug};

    selected = PartyDrinkCategoryFilter.toggleCategory(
      selected,
      'piscos',
    );
    expect(selected, {'piscos'});

    selected = PartyDrinkCategoryFilter.toggleCategory(
      selected,
      'beers',
    );
    expect(selected, {'piscos', 'beers'});
  });

  test('toggleCategory falls back to All when last category is removed', () {
    final result = PartyDrinkCategoryFilter.toggleCategory(
      {'piscos'},
      'piscos',
    );

    expect(result, {PartyDrinkMenuCategory.allSlug});
  });
}
