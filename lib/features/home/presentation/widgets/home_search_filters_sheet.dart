import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_bottom_sheet_shell.dart';
import 'package:youpass/core/widgets/youpass_filter_chip_widget.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/widgets/home_near_me_button_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

class HomeSearchFiltersSheet {
  HomeSearchFiltersSheet._();

  static Future<void> show(BuildContext context) async {
    final provider = context.read<HomeProvider>();
    provider.beginFilterEditing();
    final config = provider.homeFeed?.searchConfig ?? HomeSearchFiltersConfigEntity.defaults;
    final l10n = context.l10n;

    await AuthBottomSheetShell.show<void>(
      context: context,
      title: AppStrings.homeFiltersTitle(l10n),
      maxHeightFactor: 0.9,
      child: _HomeSearchFiltersBody(config: config),
    );
  }
}

class _HomeSearchFiltersBody extends StatefulWidget {
  const _HomeSearchFiltersBody({required this.config});

  final HomeSearchFiltersConfigEntity config;

  @override
  State<_HomeSearchFiltersBody> createState() => _HomeSearchFiltersBodyState();
}

class _HomeSearchFiltersBodyState extends State<_HomeSearchFiltersBody> {
  late RangeValues _priceRange;
  String? _selectedCityId;

  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();
    final filters = provider.draftFilters;
    final price = widget.config.priceRange;
    _priceRange = RangeValues(
      filters.minPrice ?? price.min,
      filters.maxPrice ?? price.max,
    );

    for (final city in widget.config.cities) {
      if (city.label == filters.city) {
        _selectedCityId = city.id;
        break;
      }
    }
  }

  HomeProvider get provider => context.read<HomeProvider>();

  void _updateFilters(HomeEventsFiltersEntity filters) {
    provider.updateDraftFilters(filters);
  }

  HomeEventsFiltersEntity get _filters => provider.draftFilters;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        final filters = homeProvider.draftFilters;
        final previewCount = homeProvider.filterPreviewCount;
        final isPreviewLoading = homeProvider.isFilterPreviewLoading;
        final price = widget.config.priceRange;
        HomeCityFilterEntity? selectedCity;
        if (_selectedCityId != null) {
          for (final city in widget.config.cities) {
            if (city.id == _selectedCityId) {
              selectedCity = city;
              break;
            }
          }
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: layout.spacing(24)),
                children: [
                  _SectionTitle(AppStrings.homeFiltersDate(l10n)),
                  SizedBox(height: layout.spacing(10)),
                  Wrap(
                    spacing: layout.spacing(8),
                    runSpacing: layout.spacing(8),
                    children: widget.config.datePresets.map((preset) {
                      final selected = filters.datePreset == preset.id;
                      return YouPassFilterChipWidget(
                        label: preset.label,
                        isSelected: selected,
                        onTap: () {
                          if (preset.id == 'custom') {
                            _pickCustomRange(l10n);
                            return;
                          }
                          _updateFilters(
                            filters.copyWith(
                              datePreset: preset.id,
                              clearDateFrom: true,
                              clearDateTo: true,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  if (filters.dateFrom != null || filters.dateTo != null) ...[
                    SizedBox(height: layout.spacing(8)),
                    AppText(
                      _formatCustomRange(filters, l10n),
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                  SizedBox(height: layout.spacing(20)),
                  _SectionTitle(AppStrings.homeFiltersPrice(l10n)),
                  SizedBox(height: layout.spacing(10)),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: AppText(
                      AppStrings.homeFiltersFreeOnly(l10n),
                      variant: AppTextVariant.bodyEmphasis,
                    ),
                    value: filters.freeOnly,
                    activeTrackColor: AppColors.primaryMustard.withValues(alpha: 0.45),
                    activeThumbColor: AppColors.primaryMustard,
                    inactiveThumbColor: theme.cardBorder,
                    inactiveTrackColor: theme.searchFill,
                    onChanged: price.freeToggleEnabled
                        ? (value) => _updateFilters(filters.copyWith(freeOnly: value))
                        : null,
                  ),
                  if (!filters.freeOnly) ...[
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.primaryMustard,
                        inactiveTrackColor: theme.cardBorder,
                        thumbColor: AppColors.primaryMustard,
                        overlayColor: AppColors.primaryMustard.withValues(alpha: 0.12),
                        rangeThumbShape:
                            const RoundRangeSliderThumbShape(enabledThumbRadius: 10),
                        trackHeight: 3,
                      ),
                      child: RangeSlider(
                        values: _priceRange,
                        min: price.min,
                        max: price.max,
                        divisions: 20,
                        labels: RangeLabels(
                          '${price.currency} ${_priceRange.start.round()}',
                          '${price.currency} ${_priceRange.end.round()}',
                        ),
                        onChanged: (values) {
                          setState(() => _priceRange = values);
                          _updateFilters(
                            filters.copyWith(
                              minPrice: values.start,
                              maxPrice: values.end,
                            ),
                          );
                        },
                      ),
                    ),
                    AppText(
                      '${price.currency} ${_priceRange.start.round()} – ${_priceRange.end.round()}',
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                    ),
                  ],
                  SizedBox(height: layout.spacing(20)),
                  _SectionTitle(AppStrings.homeFiltersCityZone(l10n)),
                  SizedBox(height: layout.spacing(10)),
                  HomeNearMeButtonWidget(
                    isEnabled: homeProvider.nearMeEnabled,
                    isLoading: homeProvider.isNearMeLoading,
                    onPressed: () => homeProvider.toggleNearMeFilter(),
                  ),
                  SizedBox(height: layout.spacing(14)),
                  _FilterDropdown<String?>(
                    value: _selectedCityId,
                    label: AppStrings.homeFiltersCityLabel(l10n),
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text(AppStrings.homeFiltersAllCities(l10n)),
                      ),
                      ...widget.config.cities.map(
                        (city) => DropdownMenuItem<String?>(
                          value: city.id,
                          child: Text(city.label),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedCityId = value);
                      if (value == null) {
                        _updateFilters(
                          filters.copyWith(clearCity: true, clearZone: true),
                        );
                        return;
                      }
                      final city = widget.config.cities.firstWhere((item) => item.id == value);
                      _updateFilters(
                        filters.copyWith(city: city.label, clearZone: true),
                      );
                    },
                  ),
                  if (selectedCity != null && selectedCity.zones.isNotEmpty) ...[
                    SizedBox(height: layout.spacing(12)),
                    _FilterDropdown<String?>(
                      value: filters.zone,
                      label: AppStrings.homeFiltersZoneLabel(l10n),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('—'),
                        ),
                        ...selectedCity.zones.map(
                          (zone) => DropdownMenuItem<String?>(
                            value: zone,
                            child: Text(zone),
                          ),
                        ),
                      ],
                      onChanged: (value) => _updateFilters(
                        value == null
                            ? filters.copyWith(clearZone: true)
                            : filters.copyWith(zone: value),
                      ),
                    ),
                  ],
                  SizedBox(height: layout.spacing(20)),
                  _SectionTitle(AppStrings.homeFiltersVenueType(l10n)),
                  SizedBox(height: layout.spacing(10)),
                  Wrap(
                    spacing: layout.spacing(8),
                    runSpacing: layout.spacing(8),
                    children: widget.config.venueTypes.map((venue) {
                      final selected = filters.venueKind == venue.id;
                      return YouPassFilterChipWidget(
                        label: venue.label,
                        isSelected: selected,
                        onTap: () => _updateFilters(
                          filters.copyWith(
                            venueKind: selected ? null : venue.id,
                            clearVenueKind: selected,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: layout.spacing(12)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(24),
                layout.spacing(8),
                layout.spacing(24),
                layout.spacing(16),
              ),
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(top: BorderSide(color: theme.cardBorder)),
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      await homeProvider.clearAllFilters();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.outlineButtonForeground,
                      textStyle: TextStyle(
                        fontSize: layout.fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(AppStrings.homeFiltersClear(l10n)),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: isPreviewLoading
                        ? null
                        : () async {
                            await homeProvider.applyDraftFilters();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryMustard,
                      disabledBackgroundColor:
                          AppColors.primaryMustard.withValues(alpha: 0.5),
                      foregroundColor: AppColors.darkNavy,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: layout.spacing(20),
                        vertical: layout.spacing(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(layout.radius(12)),
                      ),
                    ),
                    child: isPreviewLoading
                        ? SizedBox(
                            width: layout.spacing(18),
                            height: layout.spacing(18),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.darkNavy,
                            ),
                          )
                        : AppText(
                            previewCount == null
                                ? AppStrings.homeFiltersApply(l10n)
                                : AppStrings.homeFiltersApplyCount(l10n, previewCount),
                            variant: AppTextVariant.button,
                            color: AppColors.darkNavy,
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickCustomRange(AppLocalizations l10n) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDateRange: _filters.dateFrom != null && _filters.dateTo != null
          ? DateTimeRange(start: _filters.dateFrom!, end: _filters.dateTo!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primaryMustard,
                  onPrimary: AppColors.darkNavy,
                ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (picked == null) {
      return;
    }

    _updateFilters(
      _filters.copyWith(
        datePreset: 'custom',
        dateFrom: picked.start,
        dateTo: DateTime(
          picked.end.year,
          picked.end.month,
          picked.end.day,
          23,
          59,
          59,
        ),
      ),
    );
  }

  String _formatCustomRange(HomeEventsFiltersEntity filters, AppLocalizations l10n) {
    final from = filters.dateFrom;
    final to = filters.dateTo;
    if (from == null && to == null) {
      return '';
    }
    if (from != null && to != null) {
      return l10n.homeFiltersDateRange(_formatDate(from), _formatDate(to));
    }
    if (from != null) {
      return l10n.homeFiltersDateFrom(_formatDate(from));
    }
    return l10n.homeFiltersDateUntil(_formatDate(to!));
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppText(label, variant: AppTextVariant.sectionTitle);
  }
}

class _FilterDropdown<T> extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  final T? value;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    final radius = BorderRadius.circular(layout.radius(12));

    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: theme.inputFill,
        contentPadding: EdgeInsets.symmetric(
          horizontal: layout.spacing(12),
          vertical: layout.spacing(14),
        ),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: theme.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: theme.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.primaryMustard,
            width: 1.5,
          ),
        ),
      ),
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.chipUnselectedForeground),
      borderRadius: radius,
      items: items,
      onChanged: onChanged,
    );
  }
}
