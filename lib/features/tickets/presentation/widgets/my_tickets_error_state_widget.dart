import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class MyTicketsErrorStateWidget extends StatelessWidget {
  const MyTicketsErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              message,
              variant: AppTextVariant.body,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: TicketsDesignSpec.px(context, 16)),
            FilledButton(
              onPressed: onRetry,
              child: Text(AppStrings.ticketsRetry(strings)),
            ),
          ],
        ),
      ),
    );
  }
}
