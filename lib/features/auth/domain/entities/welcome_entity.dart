import 'package:equatable/equatable.dart';

class WelcomeEntity extends Equatable {
  const WelcomeEntity({
    required this.title,
    required this.subtitle,
    required this.durationSeconds,
  });

  final String title;
  final String subtitle;
  final int durationSeconds;

  @override
  List<Object?> get props => [title, subtitle, durationSeconds];
}
