import 'package:equatable/equatable.dart';

class FavoriteProducerEntity extends Equatable {
  const FavoriteProducerEntity({
    required this.id,
    required this.name,
    this.logoUrl,
    this.typeLabel,
    this.description,
    this.coverageLabel,
    this.followerCount = 0,
    this.isFollowing = true,
  });

  final String id;
  final String name;
  final String? logoUrl;
  final String? typeLabel;
  final String? description;
  final String? coverageLabel;
  final int followerCount;
  final bool isFollowing;

  @override
  List<Object?> get props => [
        id,
        name,
        logoUrl,
        typeLabel,
        description,
        coverageLabel,
        followerCount,
        isFollowing,
      ];
}
