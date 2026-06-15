import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';

class GetHomeFeedUseCase {
  GetHomeFeedUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  Future<HomeFeedEntity> call({String? feedContext, String? countryCode}) {
    return homeRepository.getHomeFeed(
      feedContext: feedContext,
      countryCode: countryCode,
    );
  }
}
