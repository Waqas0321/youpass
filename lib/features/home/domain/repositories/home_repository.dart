import 'package:youpass/features/home/domain/entities/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHomeData();
}
