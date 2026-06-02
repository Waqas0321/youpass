import 'package:equatable/equatable.dart';

class ProfileCompletenessEntity extends Equatable {
  const ProfileCompletenessEntity({
    required this.hasPhoto,
    required this.hasInstagram,
    required this.completionPercentage,
    required this.missingFields,
  });

  final bool hasPhoto;
  final bool hasInstagram;
  final int completionPercentage;
  final List<String> missingFields;

  @override
  List<Object?> get props => [
        hasPhoto,
        hasInstagram,
        completionPercentage,
        missingFields,
      ];
}
