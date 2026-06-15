import 'package:equatable/equatable.dart';

class TicketsPageResult<T> extends Equatable {
  const TicketsPageResult({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<T> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  bool get hasMore => page < totalPages;

  @override
  List<Object?> get props => [items, total, page, limit, totalPages];
}
