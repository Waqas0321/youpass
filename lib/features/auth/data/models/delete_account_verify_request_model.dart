class DeleteAccountVerifyRequestModel {
  const DeleteAccountVerifyRequestModel({required this.code});

  final String code;

  Map<String, dynamic> toJson() {
    return {'code': code};
  }
}
