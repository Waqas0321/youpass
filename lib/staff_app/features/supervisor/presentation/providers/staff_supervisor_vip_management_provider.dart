import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_vip_table_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/controllers/staff_supervisor_vip_search_controller.dart';

class StaffSupervisorVipManagementProvider extends ChangeNotifier {
  StaffSupervisorVipManagementProvider({
    StaffSupervisorApiService? apiService,
    required String genericError,
  })  : _apiService = apiService ?? StaffSupervisorApiService(ApiClient()),
        _genericError = genericError {
    search = StaffSupervisorVipSearchController(
      apiService: _apiService,
      genericSearchError: genericError,
    );
  }

  final StaffSupervisorApiService _apiService;
  final String _genericError;

  late final StaffSupervisorVipSearchController search;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  StaffSupervisorVipTableResult? tableContext;
  StaffSupervisorVipAction? selectedAction;
  String? selectedSlotId;
  String? selectedTargetSlotId;
  String? selectedAccessLabel;
  bool isSubmitting = false;
  bool isRefreshing = false;
  String? submitError;
  String? refreshError;

  bool get requiresGuestSelection {
    return selectedAction != null &&
        selectedAction != StaffSupervisorVipAction.authorizeExtraGuest;
  }

  bool get canSubmit {
    if (tableContext == null || isSubmitting || selectedAction == null) {
      return false;
    }

    if (reasonController.text.trim().isEmpty || pinController.text.length != 4) {
      return false;
    }

    return switch (selectedAction!) {
      StaffSupervisorVipAction.authorizeExtraGuest =>
        nameController.text.trim().isNotEmpty &&
            phoneController.text.trim().isNotEmpty,
      StaffSupervisorVipAction.releaseInvitation =>
        _selectedGuest?.canRelease ?? false,
      StaffSupervisorVipAction.changeAccess =>
        _selectedGuest != null &&
            (selectedAccessLabel?.trim().isNotEmpty ?? false),
      StaffSupervisorVipAction.moveGuest =>
        (_selectedGuest?.canMove ?? false) &&
            (selectedTargetSlotId?.isNotEmpty ?? false),
    };
  }

  StaffSupervisorVipGuest? get _selectedGuest =>
      tableContext?.guestBySlotId(selectedSlotId);

  void onSearchResultSelected(StaffSupervisorVipTableResult result) {
    tableContext = result;
    selectedAction = StaffSupervisorVipAction.authorizeExtraGuest;
    selectedSlotId = null;
    selectedTargetSlotId = null;
    selectedAccessLabel = null;
    submitError = null;
    notifyListeners();
  }

  void clearTableContext() {
    tableContext = null;
    selectedAction = null;
    selectedSlotId = null;
    selectedTargetSlotId = null;
    selectedAccessLabel = null;
    submitError = null;
    notifyListeners();
  }

  void selectAction(StaffSupervisorVipAction action) {
    selectedAction = action;
    selectedSlotId = null;
    selectedTargetSlotId = null;
    selectedAccessLabel = null;
    notifyListeners();
  }

  void selectGuestSlot(String slotId) {
    if (!requiresGuestSelection) {
      return;
    }

    final guest = tableContext?.guestBySlotId(slotId);
    if (guest == null) {
      return;
    }

    final allowed = switch (selectedAction!) {
      StaffSupervisorVipAction.releaseInvitation => guest.canRelease,
      StaffSupervisorVipAction.changeAccess => guest.canRelease,
      StaffSupervisorVipAction.moveGuest => guest.canMove,
      StaffSupervisorVipAction.authorizeExtraGuest => false,
    };

    if (!allowed) {
      return;
    }

    selectedSlotId = slotId;
    selectedTargetSlotId = null;
    selectedAccessLabel = guest.accessLabel;
    notifyListeners();
  }

  void selectTargetSlot(String slotId) {
    selectedTargetSlotId = slotId;
    notifyListeners();
  }

  void selectAccessLabel(String label) {
    selectedAccessLabel = label;
    notifyListeners();
  }

  void notifyFormChanged() {
    notifyListeners();
  }

  Future<void> refreshTableContext() async {
    final orderId = tableContext?.orderId;
    if (orderId == null || isRefreshing) {
      return;
    }

    isRefreshing = true;
    refreshError = null;
    notifyListeners();

    try {
      final refreshed = await _apiService.getVipTableContext(orderId);
      tableContext = refreshed;
      selectedSlotId = null;
      selectedTargetSlotId = null;
      selectedAccessLabel = null;
      isRefreshing = false;
      notifyListeners();
    } on ApiException catch (error) {
      isRefreshing = false;
      refreshError = error.message;
      notifyListeners();
    } catch (_) {
      isRefreshing = false;
      refreshError = _genericError;
      notifyListeners();
    }
  }

  Future<StaffSupervisorVipApplyResult?> submit() async {
    final context = tableContext;
    final action = selectedAction;

    if (context == null || action == null || !canSubmit) {
      return null;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final result = await _apiService.applyVipTableAction(
        orderId: context.orderId,
        pin: pinController.text,
        action: action,
        notes: reasonController.text.trim(),
        guestName: action == StaffSupervisorVipAction.authorizeExtraGuest
            ? nameController.text.trim()
            : null,
        guestPhone: action == StaffSupervisorVipAction.authorizeExtraGuest
            ? phoneController.text.trim()
            : null,
        slotId: selectedSlotId,
        targetSlotId: selectedTargetSlotId,
        accessLabel: selectedAccessLabel,
      );

      tableContext = result.context;
      isSubmitting = false;
      selectedSlotId = null;
      selectedTargetSlotId = null;
      selectedAccessLabel = null;
      nameController.clear();
      phoneController.clear();
      notifyListeners();
      return result;
    } on ApiException catch (error) {
      isSubmitting = false;
      submitError = error.message;
      notifyListeners();
      return null;
    } catch (_) {
      isSubmitting = false;
      submitError = _genericError;
      notifyListeners();
      return null;
    }
  }

  @override
  void dispose() {
    search.dispose();
    nameController.dispose();
    phoneController.dispose();
    reasonController.dispose();
    pinController.dispose();
    super.dispose();
  }
}
