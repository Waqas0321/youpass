import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/domain/entities/home_entity.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.remoteDataSource);

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<HomeEntity> getHomeData() {
    return remoteDataSource.fetchHomeData();
  }
}
