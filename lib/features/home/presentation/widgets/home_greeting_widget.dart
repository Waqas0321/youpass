import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class HomeGreetingWidget extends StatelessWidget {
  const HomeGreetingWidget({
    super.key,
    this.greetingText,
  });

  final String? greetingText;

  @override
  Widget build(BuildContext context) {
    final resolvedGreeting = greetingText?.trim();
    if (resolvedGreeting == null || resolvedGreeting.isEmpty) {
      return const SizedBox.shrink();
    }

    return AppText(
      resolvedGreeting,
      variant: AppTextVariant.headline,
      fontWeight: FontWeight.w800,
    );
  }
}
