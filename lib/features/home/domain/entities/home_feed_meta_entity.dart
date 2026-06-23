import 'package:equatable/equatable.dart';

class HomeGreetingEntity extends Equatable {
  const HomeGreetingEntity({
    required this.firstName,
    required this.fullName,
    required this.message,
    this.category,
  });

  final String firstName;
  final String fullName;
  final String message;
  final String? category;

  @override
  List<Object?> get props => [firstName, fullName, message, category];
}

class HomePartyModeEntity extends Equatable {
  const HomePartyModeEntity({
    this.enabled = false,
    this.bannerVisible = true,
    this.eventId,
    this.eventTitle,
  });

  final bool enabled;
  final bool bannerVisible;
  final String? eventId;
  final String? eventTitle;

  @override
  List<Object?> get props => [enabled, bannerVisible, eventId, eventTitle];
}

class HomeFeaturedInvitationEntity extends Equatable {
  const HomeFeaturedInvitationEntity({
    required this.id,
    required this.eventTitle,
    this.status,
  });

  final String id;
  final String eventTitle;
  final String? status;

  @override
  List<Object?> get props => [id, eventTitle, status];
}

class HomeInvitationsMetaEntity extends Equatable {
  const HomeInvitationsMetaEntity({
    this.highlight = false,
    this.pendingCount = 0,
    this.featured,
  });

  final bool highlight;
  final int pendingCount;
  final HomeFeaturedInvitationEntity? featured;

  @override
  List<Object?> get props => [highlight, pendingCount, featured];
}
