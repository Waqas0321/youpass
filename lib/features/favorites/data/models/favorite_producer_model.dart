import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';

class FavoriteProducerModel extends FavoriteProducerEntity {
  const FavoriteProducerModel({
    required super.id,
    required super.name,
    super.logoUrl,
    super.typeLabel,
    super.description,
    super.coverageLabel,
    super.followerCount,
    super.isFollowing,
  });

  factory FavoriteProducerModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProducerModel(
      id: JsonReaders.readId(json),
      name: JsonReaders.string(json, 'name'),
      logoUrl: JsonReaders.nullableString(json, 'logo_url'),
      typeLabel: JsonReaders.nullableString(json, 'type_label'),
      description: JsonReaders.nullableString(json, 'description'),
      coverageLabel: JsonReaders.nullableString(json, 'coverage_label'),
      followerCount: JsonReaders.integer(json, 'follower_count'),
      isFollowing: JsonReaders.boolean(json, 'is_following', fallback: true),
    );
  }

  static List<FavoriteProducerModel> listFromJson(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map(FavoriteProducerModel.fromJson)
        .toList();
  }
}
