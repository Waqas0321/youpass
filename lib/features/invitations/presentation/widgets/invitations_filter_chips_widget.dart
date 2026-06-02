import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          YouPassFilterChipWidget(
            label: AppStrings.invitationsFilterAll(strings),
            isSelected: selectedFilter == InvitationFilter.all,
            selectedColor: InvitationsDesignSpec.primary,
            onTap: () => onFilterSelected(InvitationFilter.all),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 8)),
          YouPassFilterChipWidget(
            label: AppStrings.invitationsFilterGeneral(strings),
            isSelected: selectedFilter == InvitationFilter.general,
            selectedColor: InvitationsDesignSpec.primary,
            onTap: () => onFilterSelected(InvitationFilter.general),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 8)),
          YouPassFilterChipWidget(
            label: AppStrings.invitationsFilterVip(strings),
            isSelected: selectedFilter == InvitationFilter.vip,
            selectedColor: InvitationsDesignSpec.primary,
            onTap: () => onFilterSelected(InvitationFilter.vip),
          ),
        ],
      ),
    );
  }
}
