import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

abstract class HomeRepository {
  Future<HomeFeedEntity> getHomeFeed();
}
