import 'package:equatable/equatable.dart';

class InvitationsSummaryEntity extends Equatable {
  const InvitationsSummaryEntity({
    required this.pendingCount,
    required this.newCount,
    required this.totalCount,
  });

  final int pendingCount;
  final int newCount;
  final int totalCount;

  @override
  List<Object?> get props => [pendingCount, newCount, totalCount];
}
