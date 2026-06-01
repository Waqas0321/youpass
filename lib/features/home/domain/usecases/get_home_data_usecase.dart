import 'package:youpass/features/home/domain/entities/home_entity.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';

class GetHomeDataUseCase {
  GetHomeDataUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  Future<HomeEntity> call() {
    return homeRepository.getHomeData();
  }
}
