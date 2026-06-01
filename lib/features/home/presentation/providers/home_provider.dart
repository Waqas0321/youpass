import 'package:flutter/foundation.dart';
import 'package:youpass/features/home/domain/entities/home_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_home_data_usecase.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  HomeProvider(this.getHomeDataUseCase);

  final GetHomeDataUseCase getHomeDataUseCase;

  HomeStatus status = HomeStatus.initial;
  HomeEntity? homeData;
  String? errorMessage;

  Future<void> loadHomeData() async {
    status = HomeStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      homeData = await getHomeDataUseCase();
      status = HomeStatus.loaded;
    } catch (error) {
      status = HomeStatus.error;
      errorMessage = error.toString();
    }
    notifyListeners();
  }
}
