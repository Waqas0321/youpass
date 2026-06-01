import 'package:youpass/features/home/domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.title,
    required super.subtitle,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
    );
  }
}
