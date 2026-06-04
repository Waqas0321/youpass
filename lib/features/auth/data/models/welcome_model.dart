import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';

class WelcomeModel extends WelcomeEntity {
  const WelcomeModel({
    required super.title,
    required super.subtitle,
    required super.durationSeconds,
  });

  factory WelcomeModel.fromJson(Map<String, dynamic> json) {
    return WelcomeModel(
      title: JsonReaders.string(json, 'title'),
      subtitle: JsonReaders.string(json, 'subtitle'),
      durationSeconds: JsonReaders.integer(json, 'duration_seconds', fallback: 2),
    );
  }
}
