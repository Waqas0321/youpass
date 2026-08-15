import 'dart:async';

import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_vip_table_result.dart';

/// Debounced VIP table search used on the supervisor VIP management screen.
class StaffSupervisorVipSearchController extends ChangeNotifier {
  StaffSupervisorVipSearchController({
    StaffSupervisorApiService? apiService,
    required this.genericSearchError,
  }) : _apiService = apiService ?? StaffSupervisorApiService(ApiClient()) {
    queryController.addListener(_onQueryChanged);
    focusNode.addListener(_onFocusChanged);
  }

  final StaffSupervisorApiService _apiService;
  final String genericSearchError;

  final TextEditingController queryController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  Timer? _debounceTimer;
  int _searchRequestId = 0;

  List<StaffSupervisorVipTableResult> results = const [];
  bool isSearching = false;
  bool hasSearched = false;
  int totalResults = 0;
  String? searchError;
  bool isDropdownVisible = false;

  bool get canSearch => queryController.text.trim().length >= 2;

  void _onFocusChanged() {
    _updateDropdownVisibility(notify: true);
  }

  void _onQueryChanged() {
    _debounceTimer?.cancel();
    if (!canSearch) {
      _clearResults();
      notifyListeners();
      return;
    }

    _updateDropdownVisibility(notify: false);
    notifyListeners();
    _debounceTimer = Timer(const Duration(milliseconds: 300), _runSearch);
  }

  void _updateDropdownVisibility({required bool notify}) {
    isDropdownVisible =
        canSearch && (focusNode.hasFocus || results.isNotEmpty);
    if (notify) {
      notifyListeners();
    }
  }

  void _clearResults() {
    results = const [];
    totalResults = 0;
    hasSearched = false;
    isSearching = false;
    searchError = null;
    isDropdownVisible = false;
  }

  Future<void> _runSearch() async {
    if (!canSearch) {
      _clearResults();
      notifyListeners();
      return;
    }

    final requestId = ++_searchRequestId;
    final query = queryController.text.trim();

    isSearching = true;
    hasSearched = true;
    searchError = null;
    _updateDropdownVisibility(notify: false);
    notifyListeners();

    try {
      final response = await _apiService.searchVipTables(query);

      if (requestId != _searchRequestId) {
        return;
      }

      results = response.results;
      totalResults = response.results.length;
      isSearching = false;
      _updateDropdownVisibility(notify: false);
      notifyListeners();
    } on ApiException catch (error) {
      if (requestId != _searchRequestId) {
        return;
      }
      results = const [];
      totalResults = 0;
      isSearching = false;
      searchError = error.message;
      _updateDropdownVisibility(notify: false);
      notifyListeners();
    } catch (_) {
      if (requestId != _searchRequestId) {
        return;
      }
      results = const [];
      totalResults = 0;
      isSearching = false;
      searchError = genericSearchError;
      _updateDropdownVisibility(notify: false);
      notifyListeners();
    }
  }

  void dismissResults() {
    isDropdownVisible = false;
    results = const [];
    totalResults = 0;
    notifyListeners();
  }

  void unfocus() {
    focusNode.unfocus();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    queryController.removeListener(_onQueryChanged);
    focusNode.removeListener(_onFocusChanged);
    queryController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
