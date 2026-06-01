import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/data/models/home_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeModel> fetchHomeData() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return const HomeModel(
      title: 'Dashboard',
      subtitle: 'Your learning journey starts here',
    );
  }
}
