import 'package:youpass/core/utils/json_readers.dart';

class ProfileBannerStatusModel {
  const ProfileBannerStatusModel({
    required this.showBanner,
    required this.completionPercentage,
    required this.missingFields,
  });

  final bool showBanner;
  final int completionPercentage;
  final List<String> missingFields;

  factory ProfileBannerStatusModel.fromJson(Map<String, dynamic> json) {
    return ProfileBannerStatusModel(
      showBanner: JsonReaders.boolean(json, 'show_banner'),
      completionPercentage: JsonReaders.integer(json, 'completion_percentage'),
      missingFields: JsonReaders.stringList(json, 'missing_fields'),
    );
  }
}
