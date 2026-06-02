import 'package:equatable/equatable.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_filter.dart';

class FavoriteProducerEntity extends Equatable {
  const FavoriteProducerEntity({
    required this.id,
    required this.name,
    required this.imageAssetPath,
    required this.coverageLabel,
    this.isFavorite = true,
    this.tags = const [],
  });

  final String id;
  final String name;
  final String imageAssetPath;
  final String coverageLabel;
  final bool isFavorite;
  final List<FavoriteProducerFilter> tags;

  @override
  List<Object?> get props => [
        id,
        name,
        imageAssetPath,
        coverageLabel,
        isFavorite,
        tags,
      ];
}
