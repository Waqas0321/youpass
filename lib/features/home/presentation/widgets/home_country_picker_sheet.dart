import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/constants/country_code_registry.dart';
import 'package:youpass/core/constants/country_codes_data.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

/// Home country picker — dropdown under the country chip with the full country list.
class HomeCountryPickerSheet {
  HomeCountryPickerSheet._();

  /// Full worldwide list so any country can be selected for home browsing.
  static List<CountryCode> get _allCountriesSorted {
    final byCode = <String, CountryCode>{};
    for (final country in CountryCodeRegistry.fallbackCountries) {
      byCode[country.isoCode.toUpperCase()] = country;
    }
    for (final country in CountryCodesData.all) {
      byCode.putIfAbsent(country.isoCode.toUpperCase(), () => country);
    }
    final sorted = byCode.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }

  static CountryCode _findCountry(String isoCode) {
    final normalized = isoCode.toUpperCase();
    return _allCountriesSorted.firstWhere(
      (country) => country.isoCode == normalized,
      orElse: () => CountryCodeList.findByIsoCode(normalized),
    );
  }

  static List<CountryCode> _filterCountries(String query) {
    final normalized = query.trim().toLowerCase();
    final all = _allCountriesSorted;
    if (normalized.isEmpty) {
      return all;
    }
    return all.where((country) {
      return country.name.toLowerCase().contains(normalized) ||
          country.isoCode.toLowerCase().contains(normalized) ||
          country.dialCode.contains(normalized) ||
          country.displayDialCode.contains(normalized);
    }).toList();
  }

  /// Shows a menu under [anchorContext] (the country chip).
  static Future<String?> show(
    BuildContext anchorContext, {
    required String selectedCountryCode,
  }) async {
    final renderBox = anchorContext.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      return null;
    }

    final overlay = Overlay.maybeOf(anchorContext);
    if (overlay == null) {
      return null;
    }

    final overlayBox = overlay.context.findRenderObject() as RenderBox?;
    if (overlayBox == null || !overlayBox.hasSize) {
      return null;
    }

    final chipOffset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlayBox,
    );
    final chipSize = renderBox.size;
    final selected = _findCountry(selectedCountryCode);

    return showGeneralDialog<String>(
      context: anchorContext,
      barrierDismissible: true,
      barrierLabel:
          MaterialLocalizations.of(anchorContext).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 140),
      pageBuilder: (context, animation, secondaryAnimation) {
        final layout = ResponsiveLayout(context);
        final media = MediaQuery.sizeOf(context);
        final menuWidth = math
            .max(chipSize.width, layout.spacing(220))
            .clamp(layout.spacing(220), media.width - layout.spacing(24))
            .toDouble();
        final maxLeft = media.width - menuWidth - layout.spacing(12);
        final left = chipOffset.dx
            .clamp(layout.spacing(12), math.max(layout.spacing(12), maxLeft))
            .toDouble();
        final top = chipOffset.dy + chipSize.height + layout.spacing(6);
        final maxHeight = math
            .min(
              layout.spacing(360),
              media.height - top - layout.spacing(24),
            )
            .toDouble();

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
              Positioned(
                left: left,
                top: top,
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: _CountryDropdownMenu(
                    width: menuWidth,
                    maxHeight: maxHeight,
                    selectedIsoCode: selected.isoCode,
                    layout: layout,
                    filterCountries: _filterCountries,
                    onSelected: (isoCode) => Navigator.of(context).pop(isoCode),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CountryDropdownMenu extends StatefulWidget {
  const _CountryDropdownMenu({
    required this.width,
    required this.maxHeight,
    required this.selectedIsoCode,
    required this.layout,
    required this.filterCountries,
    required this.onSelected,
  });

  final double width;
  final double maxHeight;
  final String selectedIsoCode;
  final ResponsiveLayout layout;
  final List<CountryCode> Function(String query) filterCountries;
  final ValueChanged<String> onSelected;

  @override
  State<_CountryDropdownMenu> createState() => _CountryDropdownMenuState();
}

class _CountryDropdownMenuState extends State<_CountryDropdownMenu> {
  late final TextEditingController _searchController;
  late List<CountryCode> _visibleCountries;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _visibleCountries = widget.filterCountries('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    setState(() {
      _visibleCountries = widget.filterCountries(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = widget.layout;
    final l10n = context.l10n;
    final radius = layout.radius(12);

    return Material(
      color: AppColors.backgroundWhite,
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: widget.width,
        height: widget.maxHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: const Color(0xFFE5E5E5),
                width: layout.spacing(2),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  layout.spacing(10),
                  layout.spacing(10),
                  layout.spacing(10),
                  layout.spacing(6),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onQueryChanged,
                  autofocus: false,
                  style: TextStyle(
                    color: AppColors.homeBlack,
                    fontSize: layout.fontSize(13),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: l10n.searchCountryHint,
                    hintStyle: TextStyle(
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(13),
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: layout.fontSize(18),
                      color: AppColors.secondaryGrey,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: layout.spacing(36),
                      minHeight: layout.spacing(36),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: layout.spacing(10),
                      vertical: layout.spacing(10),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(layout.radius(10)),
                      borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(layout.radius(10)),
                      borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(layout.radius(10)),
                      borderSide: const BorderSide(
                        color: AppColors.homeAccentYellow,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _visibleCountries.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(layout.spacing(16)),
                          child: AppText(
                            l10n.searchCountryEmpty,
                            variant: AppTextVariant.body,
                            color: AppColors.secondaryGrey,
                            fontSize: layout.fontSize(13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: layout.spacing(6)),
                        itemCount: _visibleCountries.length,
                        itemBuilder: (context, index) {
                          final country = _visibleCountries[index];
                          final isSelected = country.isoCode.toUpperCase() ==
                              widget.selectedIsoCode.toUpperCase();

                          return InkWell(
                            onTap: () => widget.onSelected(country.isoCode),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: layout.spacing(14),
                                vertical: layout.spacing(10),
                              ),
                              child: Row(
                                children: [
                                  AppText(
                                    country.flagEmoji,
                                    variant: AppTextVariant.emojiMedium,
                                    fontSize: layout.fontSize(18),
                                  ),
                                  SizedBox(width: layout.spacing(10)),
                                  Expanded(
                                    child: AppText(
                                      country.name,
                                      variant: AppTextVariant.bodyEmphasis,
                                      color: AppColors.homeBlack,
                                      fontSize: layout.fontSize(14),
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: layout.spacing(6)),
                                  AppText(
                                    country.isoCode,
                                    variant: AppTextVariant.body,
                                    color: AppColors.secondaryGrey,
                                    fontSize: layout.fontSize(12),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
