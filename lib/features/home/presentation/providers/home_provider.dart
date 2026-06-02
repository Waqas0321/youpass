import 'package:flutter/foundation.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  HomeProvider(this.getHomeFeedUseCase);

  final GetHomeFeedUseCase getHomeFeedUseCase;

  HomeStatus status = HomeStatus.initial;
  HomeFeedEntity? homeFeed;
  String? errorMessage;
  String selectedCategoryId = AppConstants.defaultHomeCategoryId;

  Future<void> loadHomeData() async {
    status = HomeStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      homeFeed = await getHomeFeedUseCase();
      status = HomeStatus.loaded;
    } catch (error) {
      status = HomeStatus.error;
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  void setHomeFeed(HomeFeedEntity feed) {
    homeFeed = feed;
    status = HomeStatus.loaded;
    errorMessage = null;
    notifyListeners();
  }

  void selectCategory(String categoryId) {
    if (selectedCategoryId == categoryId) {
      return;
    }

    selectedCategoryId = categoryId;
    notifyListeners();
  }

  void reset() {
    status = HomeStatus.initial;
    homeFeed = null;
    errorMessage = null;
    selectedCategoryId = AppConstants.defaultHomeCategoryId;
    notifyListeners();
  }
}
