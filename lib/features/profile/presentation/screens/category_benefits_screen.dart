import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class CategoryBenefitsScreen extends StatefulWidget {
  const CategoryBenefitsScreen({super.key});

  @override
  State<CategoryBenefitsScreen> createState() => _CategoryBenefitsScreenState();
}

class _CategoryBenefitsScreenState extends State<CategoryBenefitsScreen> {
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

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isSpanish = Localizations.localeOf(context).languageCode == 'es';
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);

    final payload = data;
    final title = isSpanish
        ? (payload?['title_es'] as String? ?? '')
        : (payload?['title_en'] as String? ?? '');
    final benefitsRaw = payload == null
        ? null
        : (isSpanish ? payload['benefits_es'] : payload['benefits_en']);
    final benefits = benefitsRaw is List ? benefitsRaw : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profileCategoryBenefits(strings)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                    color: ProfileDesignSpec.primary,
                  ),
                ),
                const SizedBox(height: 16),
                ...?benefits?.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: ProfileDesignSpec.primary,
                          size: ProfileDesignSpec.px(context, 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text('$item')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
