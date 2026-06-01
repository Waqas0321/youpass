import 'package:youpass/features/home/data/models/home_feed_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeFeedModel> fetchHomeFeed();
}
