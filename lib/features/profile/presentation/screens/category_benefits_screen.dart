import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_outline_button.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/utils/profile_support_actions.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class CategoryBenefitsScreen extends StatefulWidget {
  const CategoryBenefitsScreen({super.key});

  @override
  State<CategoryBenefitsScreen> createState() => _CategoryBenefitsScreenState();
}

class _CategoryBenefitsScreenState extends State<CategoryBenefitsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBenefits();
  }

  Future<void> loadBenefits() async {
    try {
      final result = await sl<ProfileApiService>().fetchCategoryBenefits();
      if (mounted) {
        setState(() {
          data = result;
          isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  List<String> _stringList(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    return raw.map((item) => '$item').where((item) => item.isNotEmpty).toList();
  }

  List<String> _fallbackNextBenefits(String nextCategory, bool isSpanish) {
    switch (nextCategory) {
      case 'silver':
        return isSpanish
            ? const [
                'Todo lo de Bronze',
                'Acceso anticipado a preventas selectas',
                'Prioridad en lista de espera',
                'Descuentos exclusivos en eventos partner',
                'Badge Silver en tu perfil',
              ]
            : const [
                'Everything in Bronze',
                'Early access to select presales',
                'Waitlist priority',
                'Exclusive discounts at partner events',
                'Silver badge on your profile',
              ];
      case 'gold':
        return isSpanish
            ? const [
                'Todo lo de Silver',
                'Acceso VIP a lanzamientos',
                'Invitaciones a eventos exclusivos YouPass',
                'Atención prioritaria en soporte',
                'Badge Gold en tu perfil',
              ]
            : const [
                'Everything in Silver',
                'VIP access to launches',
                'Invitations to exclusive YouPass events',
                'Priority support',
                'Gold badge on your profile',
              ];
      default:
        return const [];
    }
  }

  String _fallbackUpgradeHint(String nextCategory, bool isSpanish) {
    switch (nextCategory) {
      case 'silver':
        return isSpanish
            ? 'Asiste a eventos, compra entradas y completa tu perfil para desbloquear Silver.'
            : 'Attend events, buy tickets, and complete your profile to unlock Silver.';
      case 'gold':
        return isSpanish
            ? 'Sigue activo en YouPass y en eventos partner para desbloquear Gold.'
            : 'Stay active on YouPass and at partner events to unlock Gold.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);
    final theme = ProfileTheme.of(context);
    const titleYellow = AppColors.homeAccentYellow;

    final payload = data;
    final title = isSpanish
        ? (payload?['title_es'] as String? ?? '')
        : (payload?['title_en'] as String? ?? '');
    final benefits = _stringList(
      payload == null
          ? null
          : (isSpanish ? payload['benefits_es'] : payload['benefits_en']),
    );
    final nextTitle = isSpanish
        ? (payload?['next_title_es'] as String? ?? '')
        : (payload?['next_title_en'] as String? ?? '');
    final nextCategory = (payload?['next_category'] as String?) ?? '';
    final nextBenefitsRaw = _stringList(
      payload == null
          ? null
          : (isSpanish
              ? payload['next_benefits_es']
              : payload['next_benefits_en']),
    );
    final nextBenefits = nextBenefitsRaw.isNotEmpty
        ? nextBenefitsRaw
        : _fallbackNextBenefits(nextCategory, isSpanish);
    final upgradeHintRaw = isSpanish
        ? (payload?['upgrade_hint_es'] as String? ?? '')
        : (payload?['upgrade_hint_en'] as String? ?? '');
    final upgradeHint = upgradeHintRaw.isNotEmpty
        ? upgradeHintRaw
        : _fallbackUpgradeHint(nextCategory, isSpanish);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        onBack: () => Navigator.of(context).maybePop(),
        title: AppStrings.profileCategoryBenefits(strings),
        accentColor: titleYellow,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: titleYellow))
          : ListView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                MediaQuery.paddingOf(context).bottom + 24,
              ),
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ProfileDesignSpec.px(context, 22),
                    fontWeight: FontWeight.w700,
                    color: titleYellow,
                  ),
                ),
                const SizedBox(height: 16),
                ...benefits.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: titleYellow,
                          size: ProfileDesignSpec.px(context, 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              color: theme.valueText,
                              fontSize: ProfileDesignSpec.px(context, 15),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (nextCategory.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ProfileSectionCardWidget(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppStrings.profileUnlockTierTitle(
                              strings,
                              nextTitle.isEmpty ? nextCategory : nextTitle,
                            ),
                            style: TextStyle(
                              fontSize: ProfileDesignSpec.px(context, 16),
                              fontWeight: FontWeight.w800,
                              color: titleYellow,
                            ),
                          ),
                          if (upgradeHint.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              upgradeHint,
                              style: TextStyle(
                                fontSize: ProfileDesignSpec.px(context, 14),
                                color: theme.labelText,
                                height: 1.4,
                              ),
                            ),
                          ],
                          const SizedBox(height: 12),
                          ...nextBenefits.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    color: theme.labelText,
                                    size: ProfileDesignSpec.px(context, 18),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: theme.labelText,
                                        fontSize: ProfileDesignSpec.px(
                                          context,
                                          14,
                                        ),
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          YouPassOutlineButton(
                            label: AppStrings.profileUnlockTierButton(
                              strings,
                              nextTitle.isEmpty ? nextCategory : nextTitle,
                            ),
                            icon: Icons.chat_outlined,
                            backgroundColor: theme.walletViewButtonFill,
                            onPressed: () => ProfileSupportActions(
                              context,
                              sourceContext: 'Category benefits upgrade',
                            ).openWhatsApp(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
