import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_footer_actions_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class DeleteAccountInfoScreen extends StatefulWidget {
  const DeleteAccountInfoScreen({
    super.key,
    required this.onContinue,
  });

  final VoidCallback onContinue;

  @override
  State<DeleteAccountInfoScreen> createState() => _DeleteAccountInfoScreenState();
}

class _DeleteAccountInfoScreenState extends State<DeleteAccountInfoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        title: AppStrings.profileDeleteInfoTitle(strings),
        onBack: () => Navigator.of(context).pop(),
        onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: ProfileDesignSpec.px(context, 20)),
            Icon(
              Icons.warning_amber_rounded,
              size: ProfileDesignSpec.px(context, 48),
              color: theme.deleteButtonForeground,
            ),
            SizedBox(height: ProfileDesignSpec.px(context, 16)),
            Text(
              AppStrings.profileDeleteInfoIntro(strings),
              style: TextStyle(
                fontSize: ProfileDesignSpec.px(context, 16),
                fontWeight: FontWeight.w700,
                color: theme.valueText,
                height: 1.35,
              ),
            ),
            SizedBox(height: ProfileDesignSpec.px(context, 16)),
            ..._deleteItems(strings).map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: ProfileDesignSpec.px(context, 10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.close,
                      size: ProfileDesignSpec.px(context, 18),
                      color: theme.deleteButtonForeground,
                    ),
                    SizedBox(width: ProfileDesignSpec.px(context, 10)),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(context, 15),
                          color: theme.valueText,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ProfileDesignSpec.px(context, 12)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ProfileDesignSpec.px(context, 14)),
              decoration: BoxDecoration(
                color: theme.deleteButtonFill,
                borderRadius: BorderRadius.circular(
                  ProfileDesignSpec.px(context, 12),
                ),
                border: Border.all(color: theme.deleteButtonForeground),
              ),
              child: Text(
                AppStrings.profileDeleteIrreversibleWarning(strings),
                style: TextStyle(
                  fontSize: ProfileDesignSpec.px(context, 14),
                  fontWeight: FontWeight.w700,
                  color: theme.deleteButtonForeground,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            ProfileFooterActionsWidget(
              children: [
                FilledButton(
                  onPressed: widget.onContinue,
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.deleteButtonForeground,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: ProfileDesignSpec.px(context, 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ProfileDesignSpec.px(context, ProfileDesignSpec.footerButtonRadius),
                      ),
                    ),
                  ),
                  child: Text(
                    AppStrings.profileDeleteContinue(strings),
                    style: TextStyle(
                      fontSize: ProfileDesignSpec.px(context, 15),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<String> _deleteItems(AppLocalizations strings) {
    return [
      AppStrings.profileDeleteItemPersonalData(strings),
      AppStrings.profileDeleteItemTickets(strings),
      AppStrings.profileDeleteItemPaymentMethods(strings),
      AppStrings.profileDeleteItemPoints(strings),
      AppStrings.profileDeleteItemHistory(strings),
    ];
  }
}
