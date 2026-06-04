import 'package:equatable/equatable.dart';

class EventTypeEntity extends Equatable {
  const EventTypeEntity({
    required this.id,
    required this.slug,
    required this.name,
    this.iconEmoji,
  });

  final String id;
  final String slug;
  final String name;
  final String? iconEmoji;

  @override
  List<Object?> get props => [id, slug, name, iconEmoji];
}
