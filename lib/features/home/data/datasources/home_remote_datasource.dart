import 'package:youpass/features/home/data/models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> fetchHomeData();
}
