import 'package:equatable/equatable.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';

class InvitationEntity extends Equatable {
  const InvitationEntity({
    required this.id,
    required this.eventTitle,
    required this.locationLabel,
    required this.dateTimeLabel,
    required this.imageAssetPath,
    required this.tier,
    required this.status,
    this.entryCode,
    this.qrPayload,
  });

  final String id;
  final String eventTitle;
  final String locationLabel;
  final String dateTimeLabel;
  final String imageAssetPath;
  final InvitationTier tier;
  final InvitationStatus status;
  final String? entryCode;
  final String? qrPayload;

  @override
  List<Object?> get props => [
        id,
        eventTitle,
        locationLabel,
        dateTimeLabel,
        imageAssetPath,
        tier,
        status,
        entryCode,
        qrPayload,
      ];
}
