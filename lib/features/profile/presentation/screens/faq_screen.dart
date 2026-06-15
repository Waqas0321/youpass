import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/profile/data/models/support_faq_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_faq_contact_shortcuts_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key, this.contact});

  final SupportContactModel? contact;

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final searchController = TextEditingController();
  SupportFaqResponseModel? response;
  bool isLoading = true;
  String? expandedFaqId;
  final Map<String, bool?> feedbackByFaqId = {};
  Timer? searchDebounce;

  @override
  void initState() {
    super.initState();
    loadFaqs();
  }

  @override
  void dispose() {
    searchDebounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadFaqs([String? query]) async {
    setState(() => isLoading = true);
    try {
      final result = await sl<ProfileApiService>().fetchFaqs(query: query);
      if (mounted) {
        setState(() {
          response = result;
          isLoading = false;
          if (expandedFaqId != null &&
              !_faqIds(result).contains(expandedFaqId)) {
            expandedFaqId = null;
          }
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Set<String> _faqIds(SupportFaqResponseModel result) {
    return result.categories
        .expand((category) => category.items)
        .map((item) => item.id)
        .toSet();
  }

  void onSearchChanged(String value) {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 350), () {
      loadFaqs(value.trim().isEmpty ? null : value.trim());
    });
  }

  Future<void> submitFeedback(String faqId, bool helpful) async {
    setState(() => feedbackByFaqId[faqId] = helpful);
    try {
      await sl<ProfileApiService>().submitFaqFeedback(faqId, helpful);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);
    final hasResults = (response?.total ?? 0) > 0;
    final isSearching = searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        title: AppStrings.profileFaqTitle(strings),
        onBack: () => Navigator.of(context).pop(),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: theme.primary))
          : ListView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                MediaQuery.paddingOf(context).bottom + 24,
              ),
              children: [
                TextField(
                  controller: searchController,
                  style: TextStyle(color: theme.valueText),
                  decoration: InputDecoration(
                    hintText: AppStrings.profileFaqSearch(strings),
                    prefixIcon: Icon(Icons.search, color: theme.chevronMuted),
                    suffixIcon: searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: Icon(Icons.clear, color: theme.chevronMuted),
                            onPressed: () {
                              searchController.clear();
                              loadFaqs();
                              setState(() {});
                            },
                          ),
                    filled: true,
                    fillColor: theme.sectionCardBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ProfileDesignSpec.px(context, 12),
                      ),
                      borderSide: BorderSide(color: theme.sectionCardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ProfileDesignSpec.px(context, 12),
                      ),
                      borderSide: BorderSide(color: theme.sectionCardBorder),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                    onSearchChanged(value);
                  },
                  onSubmitted: loadFaqs,
                ),
                const SizedBox(height: 12),
                if (!hasResults && isSearching) ...[
                  AppText(
                    AppStrings.profileFaqNoResults(strings),
                    variant: AppTextVariant.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ProfileFaqContactShortcutsWidget(contact: widget.contact),
                ] else ...[
                  ...?response?.categories.expand((category) {
                    final label =
                        isSpanish ? category.labelEs : category.labelEn;
                    return [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        child: AppText(
                          label,
                          variant: AppTextVariant.label,
                          color: theme.primary,
                        ),
                      ),
                      ...category.items.map((item) => _buildFaqItem(item)),
                    ];
                  }),
                ],
              ],
            ),
    );
  }

  Widget _buildFaqItem(SupportFaqItemModel item) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final feedback = feedbackByFaqId[item.id];
    final isExpanded = expandedFaqId == item.id;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ProfileSectionCardWidget(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: Key('faq-${item.id}-$isExpanded'),
            initiallyExpanded: isExpanded,
            iconColor: theme.chevronMuted,
            collapsedIconColor: theme.chevronMuted,
            title: Text(
              isSpanish ? item.questionEs : item.questionEn,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.valueText,
                fontSize: ProfileDesignSpec.px(context, 14),
              ),
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                expandedFaqId = expanded ? item.id : null;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSpanish ? item.answerEs : item.answerEn,
                      style: TextStyle(
                        color: theme.labelText,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppText(
                      AppStrings.profileFaqHelpful(strings),
                      variant: AppTextVariant.label,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: feedback == null
                              ? () => submitFeedback(item.id, true)
                              : null,
                          child: Text(AppStrings.profileFaqYes(strings)),
                        ),
                        TextButton(
                          onPressed: feedback == null
                              ? () => submitFeedback(item.id, false)
                              : null,
                          child: Text(AppStrings.profileFaqNo(strings)),
                        ),
                      ],
                    ),
                    if (feedback == false) ...[
                      const SizedBox(height: 4),
                      ProfileFaqContactShortcutsWidget(
                        contact: widget.contact,
                        sourceContext: 'FAQ',
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
