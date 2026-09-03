import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/core/utils/app_logger.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_snack_bar.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/widgets/staff_connection_status_bar.dart';
import 'package:youpass/staff_app/features/scan/presentation/widgets/staff_scan_screen_header.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_events_timeline.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_history_route_args.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_manual_validation_route_args.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_qr_override_route_args.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_search_result_tile.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/staff_app/routes/app_routes.dart';

class StaffSupervisorSearchEntryScreen extends StatefulWidget {
  const StaffSupervisorSearchEntryScreen({
    super.key,
    this.supervisorApiService,
  });

  final StaffSupervisorApiService? supervisorApiService;

  @override
  State<StaffSupervisorSearchEntryScreen> createState() =>
      _StaffSupervisorSearchEntryScreenState();
}

class _StaffSupervisorSearchEntryScreenState
    extends State<StaffSupervisorSearchEntryScreen> {
  static const _accent = AppColors.homeAccentYellow;
  static const _pageBg = Color(0xFFF8F9FA);

  late final StaffSupervisorApiService _supervisorApiService =
      widget.supervisorApiService ?? StaffSupervisorApiService(ApiClient());

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounceTimer;
  int _searchRequestId = 0;
  bool _isDropdownVisible = false;

  StaffSupervisorEntryQuickFilter? _activeFilter;
  List<StaffSupervisorEntrySearchResult> _results = const [];
  StaffSupervisorEntrySearchResult? _selectedResult;
  List<StaffSupervisorEntryEventLog> _recentEvents = const [];
  bool _isLoading = false;
  bool _hasSearched = false;
  int _totalResults = 0;
  String? _searchError;
  bool _isLoadingDetail = false;
  int _detailRequestId = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    _searchFocusNode.addListener(_onSearchFocusChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchTextChanged);
    _searchFocusNode.removeListener(_onSearchFocusChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchFocusChanged() {
    setState(_updateDropdownVisibility);
  }

  void _updateDropdownVisibility() {
    _isDropdownVisible =
        _searchFocusNode.hasFocus && _canSearch && _activeFilter == null;
  }

  bool get _showInlineResults {
    if (!_hasSearched || _selectedResult != null) {
      return false;
    }

    return _activeFilter != null || !_searchFocusNode.hasFocus;
  }

  bool get _canSearch {
    final query = _searchController.text.trim();
    return query.isNotEmpty || _activeFilter != null;
  }

  void _clearResults() {
    _results = const [];
    _selectedResult = null;
    _recentEvents = const [];
    _totalResults = 0;
    _hasSearched = false;
    _isLoading = false;
    _searchError = null;
    _isDropdownVisible = false;
  }

  void _onSearchTextChanged() {
    _debounceTimer?.cancel();
    if (!_canSearch) {
      setState(_clearResults);
      return;
    }
    setState(() {
      _clearSelectedResult();
      _updateDropdownVisibility();
    });
    _debounceTimer = Timer(const Duration(milliseconds: 300), _runSearch);
  }

  void _clearSelectedResult() {
    _selectedResult = null;
    _recentEvents = const [];
    _isLoadingDetail = false;
    _detailRequestId++;
  }

  bool _isSelectedResultInResults() {
    final selected = _selectedResult;
    if (selected == null) {
      return false;
    }

    return _results.any((result) => result.ticketId == selected.ticketId);
  }

  void _syncSelectedResultWithResults() {
    if (_selectedResult != null && !_isSelectedResultInResults()) {
      _clearSelectedResult();
    }
  }

  String _emptyResultsMessage(AppLocalizations l10n) {
    if (_searchError != null) {
      return _searchError!;
    }

    return switch (_activeFilter) {
      StaffSupervisorEntryQuickFilter.vip =>
        l10n.staffSupervisorSearchEntryNoVipResults,
      StaffSupervisorEntryQuickFilter.used =>
        l10n.staffSupervisorSearchEntryNoUsedResults,
      StaffSupervisorEntryQuickFilter.error =>
        l10n.staffSupervisorSearchEntryNoErrorResults,
      StaffSupervisorEntryQuickFilter.duplicate ||
      null =>
        l10n.staffSupervisorSearchEntryNoResults,
    };
  }

  Future<void> _runSearch() async {
    if (!_canSearch) {
      if (mounted) {
        setState(_clearResults);
      }
      return;
    }

    final requestId = ++_searchRequestId;
    final query = _searchController.text.trim();

    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _searchError = null;
      _clearSelectedResult();
    });

    try {
      final response = await _supervisorApiService.searchEntries(
        query: query,
        filter: _activeFilter,
      );

      if (!mounted || requestId != _searchRequestId) {
        return;
      }

      AppLogger.debug(
        'Supervisor search "$query" returned ${response.results.length} result(s)',
      );

      setState(() {
        _results = response.results;
        _totalResults = response.total;
        _searchError = null;
        _syncSelectedResultWithResults();
        _updateDropdownVisibility();
      });
    } on ApiException catch (error) {
      if (!mounted || requestId != _searchRequestId) {
        return;
      }
      setState(() {
        _results = const [];
        _totalResults = 0;
        _searchError = error.message;
        _clearSelectedResult();
        _updateDropdownVisibility();
      });
    } catch (error, stackTrace) {
      if (!mounted || requestId != _searchRequestId) {
        return;
      }
      AppLogger.error(
        'Supervisor search failed',
        error: error,
        stackTrace: stackTrace,
      );
      setState(() {
        _results = const [];
        _totalResults = 0;
        _searchError = context.l10n.staffSupervisorSearchEntrySearchError;
        _clearSelectedResult();
        _updateDropdownVisibility();
      });
    } finally {
      if (mounted && requestId == _searchRequestId) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleSearch() {
    _debounceTimer?.cancel();
    _runSearch();
  }

  void _toggleFilter(StaffSupervisorEntryQuickFilter filter) {
    setState(() {
      _activeFilter = _activeFilter == filter ? null : filter;
      _clearSelectedResult();
      _searchFocusNode.unfocus();
    });
    _debounceTimer?.cancel();
    if (_canSearch) {
      _runSearch();
    } else {
      setState(_clearResults);
    }
  }

  Future<void> _selectResult(StaffSupervisorEntrySearchResult result) async {
    final requestId = ++_detailRequestId;

    setState(() {
      _selectedResult = result;
      _recentEvents = const [];
      _isDropdownVisible = false;
      _isLoadingDetail = true;
    });
    _searchFocusNode.unfocus();

    try {
      final detail = await _supervisorApiService.getEntryDetail(result.ticketId);

      if (!mounted || requestId != _detailRequestId) {
        return;
      }

      setState(() {
        _selectedResult = detail;
        _recentEvents = detail.recentEvents;
        _isLoadingDetail = false;
      });
    } on ApiException catch (error) {
      if (!mounted || requestId != _detailRequestId) {
        return;
      }
      setState(() {
        _isLoadingDetail = false;
      });
      AppSnackBar.show(context, error.message);
    } catch (_) {
      if (!mounted || requestId != _detailRequestId) {
        return;
      }
      setState(() {
        _isLoadingDetail = false;
      });
      AppSnackBar.show(
        context,
        context.l10n.staffSupervisorSearchEntrySearchError,
      );
    }
  }

  void _openEntryHistory() {
    final selected = _selectedResult;
    if (selected == null) {
      return;
    }

    Navigator.of(context).pushNamed(
      StaffAppRoutes.supervisorEntryHistory,
      arguments: StaffSupervisorEntryHistoryRouteArgs(
        ticketId: selected.ticketId,
        guestName: selected.guestName,
        eventTitle: selected.eventTitle,
        qrId: selected.qrId,
      ),
    );
  }

  void _openEntryManualValidation() {
    final selected = _selectedResult;
    if (selected == null) {
      return;
    }

    Navigator.of(context).pushNamed(
      StaffAppRoutes.supervisorEntryManualValidation,
      arguments: StaffSupervisorEntryManualValidationRouteArgs(
        ticketId: selected.ticketId,
        entryCode: selected.qrId,
      ),
    );
  }

  void _openEntryOverride({required String initialAction}) {
    final selected = _selectedResult;
    if (selected == null) {
      return;
    }

    Navigator.of(context).pushNamed(
      StaffAppRoutes.supervisorEntryQrOverride,
      arguments: StaffSupervisorEntryQrOverrideRouteArgs(
        ticketId: selected.ticketId,
        entryCode: selected.qrId,
        initialAction: initialAction,
      ),
    );
  }

  String _validatorFooterLabel(AppLocalizations l10n) {
    final zoneLabel = context.read<StaffAuthProvider>().profile?.zoneLabel;
    if (zoneLabel == null || zoneLabel.isEmpty) {
      return l10n.staffSupervisorValidatorLabel('VAL-AC-02');
    }

    final code = zoneLabel
        .trim()
        .toUpperCase()
        .replaceAll(RegExp(r'[^\w]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');

    return l10n.staffSupervisorValidatorLabel(
      code.length >= 3 ? code : zoneLabel,
    );
  }

  Widget _buildSearchDropdown(
    AppLocalizations l10n,
    ResponsiveLayout layout,
  ) {
    if (!_isDropdownVisible) {
      return const SizedBox.shrink();
    }

    final borderRadius = BorderRadius.circular(layout.radius(12));

    return Material(
      elevation: 16,
      shadowColor: Colors.black.withValues(alpha: 0.18),
      color: AppColors.backgroundWhite,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: layout.spacing(280)),
        child: _isLoading && _results.isEmpty
            ? Padding(
                padding: EdgeInsets.all(layout.spacing(20)),
                child: const Center(
                  child: CircularProgressIndicator(color: _accent),
                ),
              )
            : _hasSearched && !_isLoading && _results.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(layout.spacing(16)),
                    child: AppText(
                      _emptyResultsMessage(l10n),
                      variant: AppTextVariant.body,
                      textAlign: TextAlign.center,
                      color: _searchError != null
                          ? const Color(0xFFEF4444)
                          : AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          layout.spacing(14),
                          layout.spacing(10),
                          layout.spacing(14),
                          layout.spacing(6),
                        ),
                        child: AppText(
                          l10n.staffSupervisorSearchEntryResultsCount(
                            _totalResults,
                          ),
                          variant: AppTextVariant.label,
                          color: AppColors.secondaryGrey,
                          fontWeight: FontWeight.w700,
                          fontSize: layout.fontSize(11),
                          letterSpacing: 0.6,
                        ),
                      ),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _results.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: AppColors.homeDividerGrey.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final result = _results[index];
                            return StaffSupervisorEntrySearchResultTile(
                              layout: layout,
                              result: result,
                              onTap: () => _selectResult(result),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  List<Widget> _buildEmptySearchState(
    AppLocalizations l10n,
    ResponsiveLayout layout,
  ) {
    if (!_showInlineResults ||
        _isLoading ||
        _selectedResult != null ||
        _results.isNotEmpty) {
      return const [];
    }

    return [
      Padding(
        padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
        child: AppText(
          _emptyResultsMessage(l10n),
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
          color: _searchError != null
              ? const Color(0xFFEF4444)
              : AppColors.secondaryGrey,
          fontSize: layout.fontSize(14),
        ),
      ),
    ];
  }

  List<Widget> _buildInlineResultsSection(
    AppLocalizations l10n,
    ResponsiveLayout layout,
  ) {
    if (!_showInlineResults || _selectedResult != null) {
      return const [];
    }

    if (_isLoading && _results.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(32)),
          child: const Center(
            child: CircularProgressIndicator(color: _accent),
          ),
        ),
      ];
    }

    if (_results.isEmpty) {
      return const [];
    }

    return [
      AppText(
        l10n.staffSupervisorSearchEntryResultsCount(_totalResults),
        variant: AppTextVariant.label,
        color: AppColors.secondaryGrey,
        fontWeight: FontWeight.w700,
        fontSize: layout.fontSize(11),
        letterSpacing: 0.6,
      ),
      SizedBox(height: layout.spacing(8)),
      Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(layout.radius(12)),
          border: Border.all(color: AppColors.homeDividerGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: layout.spacing(8),
              offset: Offset(0, layout.spacing(2)),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < _results.length; index++) ...[
              if (index > 0)
                Divider(
                  height: 1,
                  color: AppColors.homeDividerGrey.withValues(alpha: 0.7),
                ),
              StaffSupervisorEntrySearchResultTile(
                layout: layout,
                result: _results[index],
                onTap: () => _selectResult(_results[index]),
              ),
            ],
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildSelectedDetailSection(
    AppLocalizations l10n,
    ResponsiveLayout layout,
  ) {
    if (_selectedResult == null) {
      return const [];
    }

    return [
      SizedBox(height: layout.spacing(8)),
      if (_isLoadingDetail)
        Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
          child: const Center(
            child: CircularProgressIndicator(color: _accent),
          ),
        )
      else ...[
        _EntryResultCard(
          layout: layout,
          l10n: l10n,
          result: _selectedResult!,
        ),
        SizedBox(height: layout.spacing(20)),
        AppText(
          l10n.staffSupervisorActionsTitle,
          variant: AppTextVariant.label,
          color: AppColors.secondaryGrey,
          fontWeight: FontWeight.w700,
          fontSize: layout.fontSize(12),
          letterSpacing: 0.8,
        ),
        SizedBox(height: layout.spacing(12)),
        // Contextual actions only — based on ticket status (no permanent action menu).
        Wrap(
          spacing: layout.spacing(8),
          runSpacing: layout.spacing(8),
          children: [
            SizedBox(
              width: (MediaQuery.sizeOf(context).width - layout.spacing(48)) / 2 -
                  layout.spacing(4),
              child: _ActionTile(
                layout: layout,
                icon: Icons.description_outlined,
                label: l10n.staffSupervisorSearchEntryActionHistory,
                onTap: _openEntryHistory,
              ),
            ),
            if (_selectedResult!.status == StaffSupervisorEntryStatus.used ||
                _selectedResult!.status == StaffSupervisorEntryStatus.validated)
              SizedBox(
                width: (MediaQuery.sizeOf(context).width - layout.spacing(48)) /
                        2 -
                    layout.spacing(4),
                child: _ActionTile(
                  layout: layout,
                  icon: Icons.login_rounded,
                  label: l10n.staffSupervisorAuthorizeReentryAction,
                  onTap: () =>
                      _openEntryOverride(initialAction: 'authorize_reentry'),
                ),
              ),
            // Exceptional entry only for technical/error tickets — not for unused active.
            if (_selectedResult!.status == StaffSupervisorEntryStatus.error)
              SizedBox(
                width: (MediaQuery.sizeOf(context).width - layout.spacing(48)) /
                        2 -
                    layout.spacing(4),
                child: _ActionTile(
                  layout: layout,
                  icon: Icons.verified_user_outlined,
                  label: l10n.staffSupervisorRegisterExceptionalEntryAction,
                  onTap: _openEntryManualValidation,
                ),
              ),
            // PREVIOUS always-visible actions (commented out):
            // revalidate_qr, release_qr, manage_accounts override tiles
            // exceptional entry for pending
          ],
        ),
        // ACTIVE unused (pending): history only — no force/authorization buttons.
        if (_selectedResult!.status == StaffSupervisorEntryStatus.pending)
          Padding(
            padding: EdgeInsets.only(top: layout.spacing(8)),
            child: AppText(
              l10n.staffSupervisorNoActionForActiveTicket,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
              height: 1.4,
            ),
          ),
        // CANCELLED / REFUNDED / BLOCKED: no authorization buttons — status only.
        if (_selectedResult!.status == StaffSupervisorEntryStatus.blocked)
          Padding(
            padding: EdgeInsets.only(top: layout.spacing(8)),
            child: AppText(
              l10n.staffSupervisorNoActionForBlockedTicket,
              variant: AppTextVariant.body,
              color: AppColors.secondaryGrey,
              fontSize: layout.fontSize(13),
              height: 1.4,
            ),
          ),
        if (_recentEvents.isNotEmpty) ...[
          SizedBox(height: layout.spacing(20)),
          Container(
            padding: EdgeInsets.all(layout.spacing(16)),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(layout.radius(16)),
              border: Border.all(color: AppColors.homeDividerGrey),
            ),
            child: StaffSupervisorEntryEventsTimeline(
              layout: layout,
              logs: _recentEvents,
            ),
          ),
        ],
      ],
    ];
  }

  Widget _buildSearchHeader(AppLocalizations l10n, ResponsiveLayout layout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.search_rounded,
                color: _accent, size: layout.spacing(18)),
            SizedBox(width: layout.spacing(6)),
            AppText(
              l10n.staffSupervisorSearchEntryByLabel,
              variant: AppTextVariant.bodyEmphasis,
              color: AppColors.homeBlack,
              fontWeight: FontWeight.w700,
              fontSize: layout.fontSize(14),
            ),
          ],
        ),
        SizedBox(height: layout.spacing(10)),
        TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onSubmitted: (_) => _handleSearch(),
          decoration: InputDecoration(
            hintText: l10n.staffSupervisorSearchEntryPlaceholder,
            hintStyle: TextStyle(
              color: AppColors.secondaryGrey.withValues(alpha: 0.85),
              fontSize: layout.fontSize(13),
            ),
            filled: true,
            fillColor: AppColors.backgroundWhite,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.secondaryGrey,
              size: layout.spacing(20),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: layout.spacing(14),
              vertical: layout.spacing(14),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(layout.radius(14)),
              borderSide: const BorderSide(color: AppColors.homeDividerGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(layout.radius(14)),
              borderSide: const BorderSide(color: AppColors.homeDividerGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(layout.radius(14)),
              borderSide: const BorderSide(color: _accent, width: 1.5),
            ),
          ),
        ),
        SizedBox(height: layout.spacing(20)),
        AppText(
          l10n.staffSupervisorSearchEntryQuickFilters,
          variant: AppTextVariant.bodyEmphasis,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w700,
          fontSize: layout.fontSize(14),
        ),
        SizedBox(height: layout.spacing(10)),
        Row(
          children: [
            Expanded(
              child: _QuickFilterChip(
                layout: layout,
                icon: Icons.star_rounded,
                label: l10n.staffSupervisorSearchEntryFilterVip,
                selected: _activeFilter == StaffSupervisorEntryQuickFilter.vip,
                onTap: () => _toggleFilter(StaffSupervisorEntryQuickFilter.vip),
              ),
            ),
            SizedBox(width: layout.spacing(8)),
            Expanded(
              child: _QuickFilterChip(
                layout: layout,
                icon: Icons.schedule_rounded,
                label: l10n.staffSupervisorSearchEntryFilterUsed,
                selected:
                    _activeFilter == StaffSupervisorEntryQuickFilter.used,
                onTap: () => _toggleFilter(StaffSupervisorEntryQuickFilter.used),
              ),
            ),
            SizedBox(width: layout.spacing(8)),
            Expanded(
              child: _QuickFilterChip(
                layout: layout,
                icon: Icons.warning_amber_rounded,
                label: l10n.staffSupervisorSearchEntryFilterError,
                selected:
                    _activeFilter == StaffSupervisorEntryQuickFilter.error,
                onTap: () =>
                    _toggleFilter(StaffSupervisorEntryQuickFilter.error),
              ),
            ),
          ],
        ),
      ],
    );
  }

  double _searchDropdownTopOffset(ResponsiveLayout layout) {
    return layout.spacing(10) +
        layout.fontSize(14) +
        layout.spacing(6) +
        layout.spacing(52);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Scaffold(
      backgroundColor: _pageBg,
      body: Column(
        children: [
          StaffScanScreenHeader(showBottomDivider: true),
          Padding(
            padding: EdgeInsets.fromLTRB(
              layout.spacing(20),
              layout.spacing(8),
              layout.spacing(20),
              layout.spacing(12),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                l10n.staffSupervisorSearchEntryHeaderSubtitle,
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        layout.spacing(20),
                        0,
                        layout.spacing(20),
                        layout.spacing(12),
                      ),
                      child: _buildSearchHeader(l10n, layout),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(
                          layout.spacing(20),
                          0,
                          layout.spacing(20),
                          layout.spacing(12),
                        ),
                        children: [
                          ..._buildInlineResultsSection(l10n, layout),
                          ..._buildEmptySearchState(l10n, layout),
                          ..._buildSelectedDetailSection(l10n, layout),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: _searchDropdownTopOffset(layout),
                  left: layout.spacing(20),
                  right: layout.spacing(20),
                  child: _buildSearchDropdown(l10n, layout),
                ),
              ],
            ),
          ),
          StaffConnectionStatusBar(
            validatorLabel: _validatorFooterLabel(l10n),
            style: StaffConnectionStatusStyle.supervisorCompact,
          ),
        ],
      ),
    );
  }
}

class _QuickFilterChip extends StatelessWidget {
  const _QuickFilterChip({
    required this.layout,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backgroundWhite,
      borderRadius: BorderRadius.circular(layout.radius(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(layout.radius(12)),
            border: Border.all(
              color: selected ? _accent : AppColors.homeDividerGrey,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: _accent, size: layout.spacing(18)),
              SizedBox(height: layout.spacing(4)),
              AppText(
                label,
                variant: AppTextVariant.body,
                color: _accent,
                fontWeight: FontWeight.w700,
                fontSize: layout.fontSize(12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntryResultCard extends StatelessWidget {
  const _EntryResultCard({
    required this.layout,
    required this.l10n,
    required this.result,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final AppLocalizations l10n;
  final StaffSupervisorEntrySearchResult result;

  _StatusStyle _statusStyle() {
    switch (result.status) {
      case StaffSupervisorEntryStatus.validated:
        return const _StatusStyle(
          labelKey: _StatusLabel.validated,
          color: Color(0xFF22C55E),
          background: Color(0xFFECFDF5),
          icon: Icons.check_circle_rounded,
        );
      case StaffSupervisorEntryStatus.pending:
        return const _StatusStyle(
          labelKey: _StatusLabel.pending,
          color: Color(0xFFF59E0B),
          background: Color(0xFFFFFBEB),
          icon: Icons.schedule_rounded,
        );
      case StaffSupervisorEntryStatus.used:
        return const _StatusStyle(
          labelKey: _StatusLabel.used,
          color: Color(0xFF64748B),
          background: Color(0xFFF1F5F9),
          icon: Icons.history_rounded,
        );
      case StaffSupervisorEntryStatus.error:
        return const _StatusStyle(
          labelKey: _StatusLabel.error,
          color: Color(0xFFEF4444),
          background: Color(0xFFFEF2F2),
          icon: Icons.error_outline_rounded,
        );
      case StaffSupervisorEntryStatus.blocked:
        return const _StatusStyle(
          labelKey: _StatusLabel.blocked,
          color: Color(0xFFEF4444),
          background: Color(0xFFFEF2F2),
          icon: Icons.block_rounded,
        );
    }
  }

  String _statusLabel(_StatusStyle style) {
    switch (style.labelKey) {
      case _StatusLabel.validated:
      case _StatusLabel.used:
        return l10n.staffSupervisorEntryStatusAlreadyUsed;
      case _StatusLabel.pending:
        return l10n.staffSupervisorEntryStatusPending;
      case _StatusLabel.error:
        return l10n.staffSupervisorEntryStatusError;
      case _StatusLabel.blocked:
        return l10n.staffSupervisorEntryStatusBlocked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _statusStyle();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(layout.radius(16)),
        border: Border.all(color: AppColors.homeDividerGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: layout.spacing(8),
            offset: Offset(0, layout.spacing(2)),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: layout.spacing(4),
              color: statusStyle.color,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(layout.spacing(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                AppText(
                  l10n.staffSupervisorResultFoundTitle,
                  variant: AppTextVariant.label,
                  color: AppColors.secondaryGrey,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(11),
                  letterSpacing: 0.8,
                ),
                SizedBox(height: layout.spacing(12)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: layout.spacing(24),
                          backgroundColor: const Color(0xFFFFF8EB),
                          child: Icon(
                            Icons.person_rounded,
                            color: _accent,
                            size: layout.spacing(28),
                          ),
                        ),
                        if (result.isVip)
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: layout.spacing(6),
                                vertical: layout.spacing(2),
                              ),
                              decoration: BoxDecoration(
                                color: _accent,
                                borderRadius:
                                    BorderRadius.circular(layout.radius(8)),
                              ),
                              child: AppText(
                                'VIP',
                                variant: AppTextVariant.label,
                                color: AppColors.backgroundWhite,
                                fontWeight: FontWeight.w800,
                                fontSize: layout.fontSize(9),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: layout.spacing(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            result.guestName,
                            variant: AppTextVariant.bodyEmphasis,
                            color: AppColors.homeBlack,
                            fontWeight: FontWeight.w800,
                            fontSize: layout.fontSize(17),
                          ),
                          SizedBox(height: layout.spacing(8)),
                          Wrap(
                            spacing: layout.spacing(6),
                            runSpacing: layout.spacing(6),
                            children: result.vipTags
                                .map(
                                  (tag) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: layout.spacing(8),
                                      vertical: layout.spacing(4),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: _accent),
                                      borderRadius: BorderRadius.circular(
                                        layout.radius(8),
                                      ),
                                    ),
                                    child: AppText(
                                      tag,
                                      variant: AppTextVariant.label,
                                      color: _accent,
                                      fontWeight: FontWeight.w700,
                                      fontSize: layout.fontSize(11),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppText(
                          l10n.staffSupervisorConsumptionStatusLabel,
                          variant: AppTextVariant.body,
                          color: AppColors.secondaryGrey,
                          fontSize: layout.fontSize(11),
                        ),
                        SizedBox(height: layout.spacing(4)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: layout.spacing(10),
                            vertical: layout.spacing(5),
                          ),
                          decoration: BoxDecoration(
                            color: statusStyle.background,
                            borderRadius:
                                BorderRadius.circular(layout.radius(20)),
                            border: Border.all(
                              color: statusStyle.color.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                statusStyle.icon,
                                color: statusStyle.color,
                                size: layout.spacing(14),
                              ),
                              SizedBox(width: layout.spacing(4)),
                              AppText(
                                _statusLabel(statusStyle),
                                variant: AppTextVariant.label,
                                color: statusStyle.color,
                                fontWeight: FontWeight.w800,
                                fontSize: layout.fontSize(11),
                                letterSpacing: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: layout.spacing(14)),
                _IdRow(
                  layout: layout,
                  label: l10n.staffSupervisorOverrideQrIdLabel,
                  value: result.qrId,
                ),
                if (result.ticketTypeLabel != null &&
                    result.ticketTypeLabel!.trim().isNotEmpty) ...[
                  SizedBox(height: layout.spacing(6)),
                  _IdRow(
                    layout: layout,
                    label: l10n.staffSupervisorSearchEntryTicketTypeLabel,
                    value: result.ticketTypeLabel!,
                  ),
                ],
                SizedBox(height: layout.spacing(6)),
                _IdRow(
                  layout: layout,
                  label: l10n.staffSupervisorSearchEntryPurchaseIdLabel,
                  value: result.purchaseId,
                ),
                if (result.purchaseStatus != null &&
                    result.purchaseStatus!.trim().isNotEmpty) ...[
                  SizedBox(height: layout.spacing(6)),
                  _IdRow(
                    layout: layout,
                    label: l10n.staffSupervisorSearchEntryPurchaseStatusLabel,
                    value: result.purchaseStatus!,
                  ),
                ],
                if (result.accessPoint != null &&
                    result.accessPoint!.trim().isNotEmpty) ...[
                  SizedBox(height: layout.spacing(6)),
                  _IdRow(
                    layout: layout,
                    label: l10n.staffSupervisorSearchEntryAccessPointLabel,
                    value: result.accessPoint!,
                  ),
                ],
                SizedBox(height: layout.spacing(14)),
                Divider(color: AppColors.homeDividerGrey, height: 1),
                SizedBox(height: layout.spacing(14)),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCell(
                        layout: layout,
                        icon: Icons.schedule_rounded,
                        label: l10n.staffSupervisorSearchEntryTimeLabel,
                        value: result.entryTimeLabel,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: layout.spacing(48),
                      color: AppColors.homeDividerGrey,
                    ),
                    Expanded(
                      child: _InfoCell(
                        layout: layout,
                        icon: Icons.verified_user_outlined,
                        label: l10n.staffSupervisorSearchEntryValidatorLabel,
                        value: result.validatorId,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: layout.spacing(12)),
                Divider(color: AppColors.homeDividerGrey, height: 1),
                SizedBox(height: layout.spacing(12)),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCell(
                        layout: layout,
                        icon: Icons.workspace_premium_outlined,
                        label: l10n.staffSupervisorSearchEntryVipTableLabel,
                        value: result.vipTableLabel,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: layout.spacing(48),
                      color: AppColors.homeDividerGrey,
                    ),
                    Expanded(
                      child: _InfoCell(
                        layout: layout,
                        icon: Icons.groups_outlined,
                        label: l10n.staffSupervisorSearchEntryAssociatedLabel,
                        value: result.associatedEntriesLabel,
                      ),
                    ),
                  ],
                ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _StatusLabel { validated, pending, used, error, blocked }

class _StatusStyle {
  const _StatusStyle({
    required this.labelKey,
    required this.color,
    required this.background,
    required this.icon,
  });

  final _StatusLabel labelKey;
  final Color color;
  final Color background;
  final IconData icon;
}

class _IdRow extends StatelessWidget {
  const _IdRow({
    required this.layout,
    required this.label,
    required this.value,
  });

  final ResponsiveLayout layout;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          '$label:',
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
        ),
        SizedBox(width: layout.spacing(8)),
        AppText(
          value,
          variant: AppTextVariant.bodyEmphasis,
          color: AppColors.homeBlack,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(14),
        ),
      ],
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({
    required this.layout,
    required this.icon,
    required this.label,
    required this.value,
  });

  static const _accent = AppColors.homeAccentYellow;

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: layout.spacing(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _accent, size: layout.spacing(18)),
          SizedBox(height: layout.spacing(6)),
          AppText(
            label,
            variant: AppTextVariant.body,
            color: AppColors.secondaryGrey,
            fontSize: layout.fontSize(11),
          ),
          AppText(
            value,
            variant: AppTextVariant.bodyEmphasis,
            color: AppColors.homeBlack,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(14),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.layout,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  static const _accent = AppColors.homeAccentYellow;
  static const _tileBg = Color(0xFFFFF8EB);

  final ResponsiveLayout layout;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _tileBg,
      borderRadius: BorderRadius.circular(layout.radius(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: layout.spacing(12),
            horizontal: layout.spacing(4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(layout.radius(12)),
            border: Border.all(color: const Color(0xFFFDE6B0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: _accent, size: layout.spacing(22)),
              SizedBox(height: layout.spacing(6)),
              AppText(
                label,
                variant: AppTextVariant.label,
                color: _accent,
                fontWeight: FontWeight.w700,
                fontSize: layout.fontSize(10),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
