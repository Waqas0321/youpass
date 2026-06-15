import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/shimmer/event_list_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/presentation/widgets/event_list_card_widget.dart';

class HomeSearchResultsPanelWidget extends StatelessWidget {
  const HomeSearchResultsPanelWidget({
    super.key,
    required this.isFocused,
    required this.searchQuery,
    required this.isLoading,
    required this.results,
    required this.history,
    required this.suggestions,
    required this.emptyMessage,
    required this.onHistoryTap,
    required this.onSuggestionTap,
    required this.onClearHistory,
    this.onEventTap,
    this.onJoinWaitlist,
    this.onLeaveWaitlist,
  });

  final bool isFocused;
  final String searchQuery;
  final bool isLoading;
  final List<EventEntity> results;
  final List<String> history;
  final List<String> suggestions;
  final String emptyMessage;
  final ValueChanged<String> onHistoryTap;
  final ValueChanged<String> onSuggestionTap;
  final VoidCallback onClearHistory;
  final ValueChanged<EventEntity>? onEventTap;
  final ValueChanged<EventEntity>? onJoinWaitlist;
  final ValueChanged<EventEntity>? onLeaveWaitlist;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final query = searchQuery.trim();

    if (!isFocused && query.isEmpty) {
      return const SizedBox.shrink();
    }

    if (isLoading) {
      return const YouPassShimmer(
        child: Column(
          children: [
            EventListCardShimmer(),
            EventListCardShimmer(),
          ],
        ),
      );
    }

    if (query.isEmpty && isFocused) {
      return _HistoryPanel(
        history: history,
        title: AppStrings.homeSearchRecentTitle(l10n),
        clearLabel: AppStrings.homeSearchClearHistory(l10n),
        onHistoryTap: onHistoryTap,
        onClearHistory: onClearHistory,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (suggestions.isNotEmpty) ...[
          _SuggestionsPanel(
            suggestions: suggestions,
            title: AppStrings.homeSearchSuggestionsTitle(l10n),
            onSuggestionTap: onSuggestionTap,
          ),
          SizedBox(height: layout.spacing(12)),
        ],
        if (results.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
            child: Center(
              child: Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: layout.fontSize(14),
                ),
              ),
            ),
          )
        else
          ...results.map(
            (event) => Padding(
              padding: EdgeInsets.only(bottom: layout.spacing(14)),
              child: EventListCardWidget(
                event: event,
                onEventTap: onEventTap == null ? null : () => onEventTap!(event),
                onJoinWaitlist: onJoinWaitlist == null
                    ? null
                    : () => onJoinWaitlist!(event),
                onLeaveWaitlist: onLeaveWaitlist == null
                    ? null
                    : () => onLeaveWaitlist!(event),
              ),
            ),
          ),
      ],
    );
  }
}

class _HistoryPanel extends StatelessWidget {
  const _HistoryPanel({
    required this.history,
    required this.title,
    required this.clearLabel,
    required this.onHistoryTap,
    required this.onClearHistory,
  });

  final List<String> history;
  final String title;
  final String clearLabel;
  final ValueChanged<String> onHistoryTap;
  final VoidCallback onClearHistory;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    if (history.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(title, variant: AppTextVariant.label),
            ),
            TextButton(
              onPressed: onClearHistory,
              child: Text(clearLabel),
            ),
          ],
        ),
        SizedBox(height: layout.spacing(8)),
        ...history.map(
          (term) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.history, size: 20),
            title: Text(term),
            onTap: () => onHistoryTap(term),
          ),
        ),
      ],
    );
  }
}

class _SuggestionsPanel extends StatelessWidget {
  const _SuggestionsPanel({
    required this.suggestions,
    required this.title,
    required this.onSuggestionTap,
  });

  final List<String> suggestions;
  final String title;
  final ValueChanged<String> onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(title, variant: AppTextVariant.label),
        SizedBox(height: layout.spacing(8)),
        ...suggestions.map(
          (term) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.search, size: 18),
            title: Text(term),
            onTap: () => onSuggestionTap(term),
          ),
        ),
      ],
    );
  }
}
