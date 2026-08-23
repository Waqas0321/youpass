import 'package:youpass/features/home/data/models/event_drink_menu_response_model.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_menu_category.dart';

class PartyDrinkMenuMapper {
  PartyDrinkMenuMapper._();

  static List<PartyDrinkMenuCategory> categories(
    EventDrinkMenuResponseModel menu,
  ) {
    return menu.categories
        .map(
          (category) => PartyDrinkMenuCategory(
            slug: category.slug,
            name: category.name,
            icon: category.icon,
          ),
        )
        .toList();
  }

  static List<PartyDrinkItem> products(
    EventDrinkMenuResponseModel menu, {
    String? eventId,
    String? eventTitle,
  }) {
    return menu.products
        .map(
          (product) => PartyDrinkItem(
            id: product.productId,
            categorySlug: product.categorySlug ?? 'uncategorized',
            nameText: product.name,
            descriptionText: product.description ?? '',
            volumeMl: product.volumeMl ?? 0,
            priceClp: product.priceClp,
            imageUrl: product.imageUrl,
            isRecommended: product.isRecommended,
            isAvailable: product.isAvailable,
            eventId: eventId ?? menu.eventId,
            eventTitle: eventTitle,
          ),
        )
        .toList();
  }
}
