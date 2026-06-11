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
  });

  final bool enabled;
  final bool bannerVisible;

  @override
  List<Object?> get props => [enabled, bannerVisible];
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
