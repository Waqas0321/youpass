import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';

class VipTablesEntryWidget extends StatelessWidget {
  const VipTablesEntryWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return VipNavigationEntryCardWidget(
      icon: Icons.star_rounded,
      title: AppStrings.vipMesasVipTitle(strings),
      subtitle: AppStrings.vipMesasVipSubtitle(strings),
      onTap: onTap,
      useFilledIconBadge: true,
    );
  }
}
