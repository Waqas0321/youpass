import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/controllers/staff_supervisor_entry_search_controller.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_entry_search_result_tile.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_form_utils.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';

/// Reusable debounced entry search field with inline results dropdown.
class StaffSupervisorEntrySearchField extends StatelessWidget {
  const StaffSupervisorEntrySearchField({
    super.key,
    required this.controller,
    required this.onResultSelected,
    required this.hint,
    this.sectionTitle,
    this.wrapInCard = true,
  });

  final StaffSupervisorEntrySearchController controller;
  final ValueChanged<StaffSupervisorEntrySearchResult> onResultSelected;
  final String hint;
  final String? sectionTitle;
  final bool wrapInCard;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.queryController,
              focusNode: controller.focusNode,
              decoration: staffSupervisorInputDecoration(
                layout,
                hint: hint,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.secondaryGrey,
                  size: layout.spacing(22),
                ),
              ),
            ),
            if (controller.isDropdownVisible) SizedBox(height: layout.spacing(8)),
            _SearchDropdown(
              layout: layout,
              controller: controller,
              noResultsLabel: l10n.staffSupervisorSearchEntryNoResults,
              resultsCountLabel: (count) =>
                  l10n.staffSupervisorSearchEntryResultsCount(count),
              onResultSelected: (result) {
                controller.dismissResults();
                controller.unfocus();
                onResultSelected(result);
              },
            ),
          ],
        );

        if (!wrapInCard) {
          return content;
        }

        return StaffSupervisorSectionCard(
          titleWidget: sectionTitle == null
              ? null
              : AppText(
                  sectionTitle!,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.homeBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: layout.fontSize(15),
                ),
          child: content,
        );
      },
    );
  }
}

class _SearchDropdown extends StatelessWidget {
  const _SearchDropdown({
    required this.layout,
    required this.controller,
    required this.noResultsLabel,
    required this.resultsCountLabel,
    required this.onResultSelected,
  });

  final ResponsiveLayout layout;
  final StaffSupervisorEntrySearchController controller;
  final String noResultsLabel;
  final String Function(int count) resultsCountLabel;
  final ValueChanged<StaffSupervisorEntrySearchResult> onResultSelected;

  @override
  Widget build(BuildContext context) {
    if (!controller.isDropdownVisible) {
      return const SizedBox.shrink();
    }

    return Material(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      color: AppColors.backgroundWhite,
      borderRadius: BorderRadius.circular(layout.radius(12)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: layout.spacing(280)),
        child: controller.isSearching && controller.results.isEmpty
            ? Padding(
                padding: EdgeInsets.all(layout.spacing(20)),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: StaffSupervisorDesign.accent,
                  ),
                ),
              )
            : controller.hasSearched &&
                    !controller.isSearching &&
                    controller.results.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(layout.spacing(16)),
                    child: AppText(
                      controller.searchError ?? noResultsLabel,
                      variant: AppTextVariant.body,
                      textAlign: TextAlign.center,
                      color: controller.searchError != null
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
                          resultsCountLabel(controller.totalResults),
                          variant: AppTextVariant.label,
                          color: AppColors.secondaryGrey,
                          fontWeight: FontWeight.w700,
                          fontSize: layout.fontSize(11),
                        ),
                      ),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.results.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: AppColors.homeDividerGrey.withValues(alpha: 0.7),
                          ),
                          itemBuilder: (context, index) {
                            final result = controller.results[index];
                            return StaffSupervisorEntrySearchResultTile(
                              layout: layout,
                              result: result,
                              onTap: () => onResultSelected(result),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
