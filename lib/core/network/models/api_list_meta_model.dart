class ApiListMetaModel {
  const ApiListMetaModel({
    this.total = 0,
    this.page = 1,
    this.limit = 20,
    this.totalPages = 1,
  });

  final int total;
  final int page;
  final int limit;
  final int totalPages;

  factory ApiListMetaModel.fromJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      return const ApiListMetaModel();
    }

    return ApiListMetaModel(
      total: _readInt(json['total']),
      page: _readInt(json['page'], fallback: 1),
      limit: _readInt(json['limit'], fallback: 20),
      totalPages: _readInt(json['total_pages'] ?? json['totalPages'], fallback: 1),
    );
  }

  static int _readInt(Object? value, {int fallback = 0}) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }
}
