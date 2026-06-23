import 'package:youpass/core/utils/json_readers.dart';

class EventDrinkMenuCategoryModel {
  const EventDrinkMenuCategoryModel({
    required this.categoryId,
    required this.slug,
    required this.name,
    this.icon,
    this.displayOrder = 0,
  });

  final String categoryId;
  final String slug;
  final String name;
  final String? icon;
  final int displayOrder;

  factory EventDrinkMenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventDrinkMenuCategoryModel(
      categoryId: JsonReaders.string(json, 'category_id',
          fallback: JsonReaders.string(json, 'categoryId')),
      slug: JsonReaders.string(json, 'slug'),
      name: JsonReaders.string(json, 'name'),
      icon: JsonReaders.nullableString(json, 'icon'),
      displayOrder: JsonReaders.integer(json, 'display_order',
          fallback: JsonReaders.integer(json, 'displayOrder')),
    );
  }
}

class EventDrinkMenuProductModel {
  const EventDrinkMenuProductModel({
    required this.productId,
    required this.name,
    this.categorySlug,
    this.description,
    this.volumeMl,
    required this.priceClp,
    this.imageUrl,
    this.isRecommended = false,
    this.isAvailable = true,
  });

  final String productId;
  final String? categorySlug;
  final String name;
  final String? description;
  final int? volumeMl;
  final int priceClp;
  final String? imageUrl;
  final bool isRecommended;
  final bool isAvailable;

  factory EventDrinkMenuProductModel.fromJson(Map<String, dynamic> json) {
    return EventDrinkMenuProductModel(
      productId: JsonReaders.string(json, 'product_id',
          fallback: JsonReaders.string(json, 'productId')),
      categorySlug: JsonReaders.nullableString(json, 'category_slug') ??
          JsonReaders.nullableString(json, 'categorySlug'),
      name: JsonReaders.string(json, 'name'),
      description: JsonReaders.nullableString(json, 'description'),
      volumeMl: json['volume_ml'] != null || json['volumeMl'] != null
          ? JsonReaders.integer(json, 'volume_ml',
              fallback: JsonReaders.integer(json, 'volumeMl'))
          : null,
      priceClp: JsonReaders.integer(json, 'price_clp',
          fallback: JsonReaders.integer(json, 'priceClp')),
      imageUrl: JsonReaders.nullableString(json, 'image_url') ??
          JsonReaders.nullableString(json, 'imageUrl'),
      isRecommended: JsonReaders.boolean(json, 'is_recommended',
          fallback: JsonReaders.boolean(json, 'isRecommended')),
      isAvailable: JsonReaders.boolean(json, 'is_available',
          fallback: JsonReaders.boolean(json, 'isAvailable', fallback: true)),
    );
  }
}

class EventDrinkMenuResponseModel {
  const EventDrinkMenuResponseModel({
    required this.eventId,
    required this.categories,
    required this.products,
  });

  final String eventId;
  final List<EventDrinkMenuCategoryModel> categories;
  final List<EventDrinkMenuProductModel> products;

  factory EventDrinkMenuResponseModel.fromJson(Map<String, dynamic> json) {
    final categoriesRaw = json['categories'];
    final productsRaw = json['products'];

    return EventDrinkMenuResponseModel(
      eventId: JsonReaders.string(json, 'event_id',
          fallback: JsonReaders.string(json, 'eventId')),
      categories: categoriesRaw is List
          ? categoriesRaw
              .whereType<Map<String, dynamic>>()
              .map(EventDrinkMenuCategoryModel.fromJson)
              .toList()
          : const [],
      products: productsRaw is List
          ? productsRaw
              .whereType<Map<String, dynamic>>()
              .map(EventDrinkMenuProductModel.fromJson)
              .toList()
          : const [],
    );
  }
}
