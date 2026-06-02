import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/delete_account_result_entity.dart';

class DeleteAccountResultModel extends DeleteAccountResultEntity {
  const DeleteAccountResultModel({
    required super.message,
    super.deletedAt,
  });

  factory DeleteAccountResultModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResultModel(
      message: JsonReaders.string(json, 'message'),
      deletedAt: JsonReaders.dateTime(json, 'deleted_at'),
    );
  }
}
