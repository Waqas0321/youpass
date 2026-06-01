import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/section_header_widget.dart';
import 'package:youpass/features/home/domain/entities/event_item_entity.dart';
import 'package:youpass/features/home/presentation/widgets/event_list_card_widget.dart';

class HomeEventsSectionWidget extends StatelessWidget {
  const HomeEventsSectionWidget({
    super.key,
    required this.events,
  });

  final List<EventItemEntity> events;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: AppStrings.eventsSectionTitle(l10n),
          actionLabel: AppStrings.seeAll(l10n),
          onActionTap: () {},
        ),
        SizedBox(height: layout.spacing(14)),
        ...events.map(
          (event) => Padding(
            padding: EdgeInsets.only(bottom: layout.spacing(12)),
            child: EventListCardWidget(event: event),
          ),
        ),
      ],
    );
  }
}
