import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_list_tab.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationsTabBarWidget extends StatelessWidget {
  const InvitationsTabBarWidget({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final InvitationListTab selectedTab;
  final ValueChanged<InvitationListTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final tabs = <(InvitationListTab, String)>[
      (InvitationListTab.pending, AppStrings.invitationsTabPending(strings)),
      (InvitationListTab.confirmed, AppStrings.invitationsTabConfirmed(strings)),
    ];

    return Row(
      children: [
        for (var i = 0; i < tabs.length; i++) ...[
          if (i > 0) SizedBox(width: InvitationsDesignSpec.px(context, 10)),
          Expanded(
            child: _TabButton(
              label: tabs[i].$2,
              isSelected: selectedTab == tabs[i].$1,
              onTap: () => onTabSelected(tabs[i].$1),
            ),
          ),
        ],
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = InvitationsScreenTheme.accent(context);

    return Material(
      color: isSelected ? accent.withValues(alpha: 0.14) : Colors.transparent,
      borderRadius: BorderRadius.circular(InvitationsDesignSpec.px(context, 10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(InvitationsDesignSpec.px(context, 10)),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: InvitationsDesignSpec.px(context, 12),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(InvitationsDesignSpec.px(context, 10)),
            border: Border.all(
              color: isSelected ? accent : InvitationsDesignSpec.filterUnselectedBorder,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: InvitationsDesignSpec.px(context, 13),
              fontWeight: FontWeight.w700,
              color: isSelected ? accent : InvitationsScreenTheme.body(context),
              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    );
  }
}
