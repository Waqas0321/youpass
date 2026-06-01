import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              context.l10n.helloUser(user.name),
              variant: AppTextVariant.listTitle,
            ),
            const SizedBox(height: 8),
            AppText(user.email, variant: AppTextVariant.body),
          ],
        ),
      ),
    );
  }
}
