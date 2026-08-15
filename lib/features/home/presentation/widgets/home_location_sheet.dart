import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_field.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_bottom_sheet_shell.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

/// Location chooser for Upcoming Events: GPS near-me or typed city/area.
class HomeLocationSheet {
  HomeLocationSheet._();

  static Future<void> show(BuildContext context) {
    final l10n = context.l10n;
    return AuthBottomSheetShell.show<void>(
      context: context,
      title: AppStrings.homeLocationSheetTitle(l10n),
      maxHeightFactor: 0.72,
      child: const _HomeLocationSheetBody(),
    );
  }
}

class _HomeLocationSheetBody extends StatefulWidget {
  const _HomeLocationSheetBody();

  @override
  State<_HomeLocationSheetBody> createState() => _HomeLocationSheetBodyState();
}

class _HomeLocationSheetBodyState extends State<_HomeLocationSheetBody> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeProvider>();
    _controller = TextEditingController(text: provider.typedLocationQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final theme = YouPassThemeExtension.of(context);

    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        final suggestions = provider.locationSuggestionsFor(_controller.text);
        final hasActiveLocation = provider.hasActiveLocationContext;
        final nearMeSelected = provider.nearMeEnabled;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: layout.spacing(24)),
                children: [
                  AppText(
                    AppStrings.homeLocationSheetSubtitle(l10n),
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
                  ),
                  SizedBox(height: layout.spacing(16)),
                  Material(
                    color: nearMeSelected
                        ? AppColors.drawerMenuHighlight
                        : AppColors.outlineButtonFill,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(layout.radius(12)),
                      side: BorderSide(
                        color: nearMeSelected
                            ? AppColors.primaryMustard
                            : AppColors.outlineButtonBorder,
                        width: nearMeSelected ? 1.5 : 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: provider.isNearMeLoading
                          ? null
                          : () async {
                              await provider.enableNearMeLocation();
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: layout.spacing(14),
                          vertical: layout.spacing(14),
                        ),
                        child: Row(
                          children: [
                            if (provider.isNearMeLoading)
                              SizedBox(
                                width: layout.fontSize(18),
                                height: layout.fontSize(18),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primaryMustard,
                                ),
                              )
                            else
                              Icon(
                                nearMeSelected
                                    ? Icons.my_location
                                    : Icons.my_location_outlined,
                                size: layout.fontSize(18),
                                color: AppColors.homeAccentYellow,
                              ),
                            SizedBox(width: layout.spacing(10)),
                            Expanded(
                              child: AppText(
                                AppStrings.homeLocationUseCurrent(l10n),
                                variant: AppTextVariant.bodyEmphasis,
                                color: AppColors.homeBlack,
                                fontSize: layout.fontSize(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (nearMeSelected)
                              const Icon(
                                Icons.check_circle,
                                size: 18,
                                color: AppColors.primaryMustard,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: layout.spacing(16)),
                  AppText(
                    AppStrings.homeFiltersCityLabel(l10n),
                    variant: AppTextVariant.bodyEmphasis,
                    color: AppColors.homeBlack,
                    fontSize: layout.fontSize(13),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: layout.spacing(10)),
                  AppTextField(
                    controller: _controller,
                    hintText: AppStrings.homeLocationTypeHint(l10n),
                    textInputAction: TextInputAction.search,
                    onChanged: (_) => setState(() {}),
                  ),
                  if (suggestions.isNotEmpty) ...[
                    SizedBox(height: layout.spacing(8)),
                    ...suggestions.map((suggestion) {
                      final selected = provider.typedLocationQuery
                              .toLowerCase() ==
                          suggestion.toLowerCase();
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            leading: Icon(
                              Icons.location_city_outlined,
                              size: layout.fontSize(20),
                              color: AppColors.homeAccentYellow,
                            ),
                            title: AppText(
                              suggestion,
                              variant: AppTextVariant.body,
                              fontSize: layout.fontSize(14),
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: AppColors.homeBlack,
                            ),
                            trailing: selected
                                ? const Icon(
                                    Icons.check,
                                    size: 18,
                                    color: AppColors.primaryMustard,
                                  )
                                : null,
                            onTap: () => _applyTyped(context, suggestion),
                          ),
                          Divider(height: 1, color: theme.cardBorder),
                        ],
                      );
                    }),
                  ],
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
                color: AppColors.backgroundWhite,
                border: Border(top: BorderSide(color: theme.cardBorder)),
              ),
              child: Row(
                children: [
                  TextButton(
                    onPressed: hasActiveLocation
                        ? () async {
                            await provider.clearLocationContext();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        : null,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.outlineButtonForeground,
                      disabledForegroundColor: AppColors.secondaryGrey
                          .withValues(alpha: 0.55),
                      textStyle: TextStyle(
                        fontSize: layout.fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(AppStrings.homeLocationClear(l10n)),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _controller.text.trim().isEmpty
                        ? null
                        : () => _applyTyped(context, _controller.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.homeAccentYellow,
                      disabledBackgroundColor: AppColors.drawerGoldBadge,
                      foregroundColor: AppColors.homeBlack,
                      disabledForegroundColor:
                          AppColors.homeBlack.withValues(alpha: 0.45),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: layout.spacing(20),
                        vertical: layout.spacing(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(layout.radius(12)),
                      ),
                    ),
                    child: AppText(
                      AppStrings.homeLocationApply(l10n),
                      variant: AppTextVariant.button,
                      color: _controller.text.trim().isEmpty
                          ? AppColors.homeBlack.withValues(alpha: 0.45)
                          : AppColors.homeBlack,
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

  Future<void> _applyTyped(BuildContext context, String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return;
    }
    await context.read<HomeProvider>().applyTypedCityLocation(trimmed);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
