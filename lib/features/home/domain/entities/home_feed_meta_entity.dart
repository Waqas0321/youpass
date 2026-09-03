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

class HomePartyModeEligibleEventEntity extends Equatable {
  const HomePartyModeEligibleEventEntity({
    required this.eventId,
    required this.eventTitle,
    this.startsAt,
    this.endsAt,
  });

  final String eventId;
  final String eventTitle;
  final DateTime? startsAt;
  final DateTime? endsAt;

  @override
  List<Object?> get props => [eventId, eventTitle, startsAt, endsAt];
}

class HomePartyModeRequirementsEntity extends Equatable {
  const HomePartyModeRequirementsEntity({
    this.hasPurchasedTicket = false,
    this.ticketScanned = false,
    this.atEventLocation = false,
  });

  final bool hasPurchasedTicket;
  final bool ticketScanned;
  final bool atEventLocation;

  @override
  List<Object?> get props =>
      [hasPurchasedTicket, ticketScanned, atEventLocation];
}

class HomePartyModeEntity extends Equatable {
  const HomePartyModeEntity({
    this.enabled = false,
    this.bannerVisible = true,
    this.eventId,
    this.eventTitle,
    this.scannedEventId,
    this.scannedEventTitle,
    this.eligibleEvents = const [],
    this.requirements = const HomePartyModeRequirementsEntity(),
  });

  final bool enabled;
  final bool bannerVisible;
  final String? eventId;
  final String? eventTitle;
  final String? scannedEventId;
  final String? scannedEventTitle;
  final List<HomePartyModeEligibleEventEntity> eligibleEvents;
  final HomePartyModeRequirementsEntity requirements;

  @override
  List<Object?> get props => [
        enabled,
        bannerVisible,
        eventId,
        eventTitle,
        scannedEventId,
        scannedEventTitle,
        eligibleEvents,
        requirements,
      ];
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
