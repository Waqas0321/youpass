import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  const HomeEntity({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  List<Object?> get props => [title, subtitle];
}
