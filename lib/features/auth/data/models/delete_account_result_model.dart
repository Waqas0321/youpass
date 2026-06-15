import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/delete_account_result_entity.dart';

class DeleteAccountResultModel extends DeleteAccountResultEntity {
  const DeleteAccountResultModel({
    required super.message,
    super.deletedAt,
    super.status,
    super.daysRemaining,
  });

  factory DeleteAccountResultModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResultModel(
      message: JsonReaders.string(json, 'message'),
      deletedAt: JsonReaders.dateTime(json, 'deleted_at') ??
          JsonReaders.dateTime(json, 'deletion_scheduled_at'),
      status: JsonReaders.string(json, 'status', fallback: 'deleted'),
      daysRemaining: JsonReaders.integer(json, 'days_remaining', fallback: 0),
    );
  }
}
