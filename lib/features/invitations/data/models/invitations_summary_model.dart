import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';

class InvitationsSummaryModel extends InvitationsSummaryEntity {
  const InvitationsSummaryModel({
    required super.pendingCount,
    required super.newCount,
    required super.totalCount,
  });

  factory InvitationsSummaryModel.fromJson(Map<String, dynamic> json) {
    return InvitationsSummaryModel(
      pendingCount: _readInt(json, 'pending_count', 'pendingCount'),
      newCount: _readInt(json, 'new_count', 'newCount'),
      totalCount: _readInt(json, 'total_count', 'totalCount'),
    );
  }

  static int _readInt(Map<String, dynamic> json, String key, String altKey) {
    final value = json[key] ?? json[altKey];
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
