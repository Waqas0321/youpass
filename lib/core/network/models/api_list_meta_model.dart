class ApiListMetaModel {
  const ApiListMetaModel({this.total = 0});

  final int total;

  factory ApiListMetaModel.fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return const ApiListMetaModel();
    }

    final total = json['total'];
    if (total is num) {
      return ApiListMetaModel(total: total.toInt());
    }

    return ApiListMetaModel(
      total: int.tryParse(total?.toString() ?? '') ?? 0,
    );
  }
}
