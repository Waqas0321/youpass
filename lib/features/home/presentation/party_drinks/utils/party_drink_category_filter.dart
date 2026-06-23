import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_menu_category.dart';

class PartyDrinkCategoryFilter {
  PartyDrinkCategoryFilter._();

  static Set<String> toggleCategory(
    Set<String> current,
    String categorySlug,
  ) {
    if (categorySlug == PartyDrinkMenuCategory.allSlug) {
      return {PartyDrinkMenuCategory.allSlug};
    }

    final next = Set<String>.from(current)
      ..remove(PartyDrinkMenuCategory.allSlug);

    if (next.contains(categorySlug)) {
      next.remove(categorySlug);
      if (next.isEmpty) {
        return {PartyDrinkMenuCategory.allSlug};
      }
      return next;
    }

    next.add(categorySlug);
    return next;
  }

  static bool isSelected(Set<String> selected, String categorySlug) {
    if (selected.contains(PartyDrinkMenuCategory.allSlug)) {
      return categorySlug == PartyDrinkMenuCategory.allSlug;
    }
    return selected.contains(categorySlug);
  }
}
