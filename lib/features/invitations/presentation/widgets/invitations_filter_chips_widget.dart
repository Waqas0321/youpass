import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/core/widgets/youpass_filter_chip_widget.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_filter.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsFilterChipsWidget extends StatelessWidget {
  const InvitationsFilterChipsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final InvitationFilter selectedFilter;
  final ValueChanged<InvitationFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final filters = <(InvitationFilter, String)>[
      (InvitationFilter.all, AppStrings.invitationsFilterAll(strings)),
      (InvitationFilter.courtesies, AppStrings.invitationsFilterCourtesy(strings)),
      (InvitationFilter.general, AppStrings.invitationsFilterGeneral(strings)),
      (InvitationFilter.vip, AppStrings.invitationsFilterVip(strings)),
      (InvitationFilter.tables, AppStrings.invitationsFilterTables(strings)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.invitationsFiltersLabel(strings),
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 11),
            fontWeight: FontWeight.w700,
            color: InvitationsScreenTheme.body(context),
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 8)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < filters.length; i++) ...[
                if (i > 0) SizedBox(width: InvitationsDesignSpec.px(context, 8)),
                YouPassFilterChipWidget(
                  label: filters[i].$2,
                  isSelected: selectedFilter == filters[i].$1,
                  onTap: () => onFilterSelected(filters[i].$1),
                  selectedColor: InvitationsScreenTheme.accent(context),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
