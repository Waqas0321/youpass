import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class MyTicketsEmptyStateWidget extends StatelessWidget {
  const MyTicketsEmptyStateWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding),
        ),
        child: AppText(
          message,
          variant: AppTextVariant.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
