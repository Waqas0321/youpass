import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class JoinWaitlistScreen extends StatefulWidget {
  const JoinWaitlistScreen({
    super.key,
    required this.eventId,
    required this.eventTitle,
  });

  final String eventId;
  final String eventTitle;

  @override
  State<JoinWaitlistScreen> createState() => _JoinWaitlistScreenState();
}

class _JoinWaitlistScreenState extends State<JoinWaitlistScreen> {
  final InvitationsRepository _repository = sl<InvitationsRepository>();
  Map<String, dynamic>? preview;
  bool loading = true;
  bool joining = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  Future<void> _loadPreview() async {
    try {
      final data = await _repository.fetchWaitlistJoinPreview(widget.eventId);
      if (!mounted) return;
      setState(() {
        preview = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<void> _confirmJoin() async {
    setState(() => joining = true);
    try {
      final result = await _repository.joinWaitlist(widget.eventId);
      if (!mounted) return;
      final strings = context.l10n;
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          content: AppText(
            result['message']?.toString() ??
                AppStrings.waitlistJoinSuccess(strings, widget.eventTitle),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText(AppStrings.invitationsQrGotIt(strings)),
            ),
          ],
        ),
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        joining = false;
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      appBar: AppBar(title: AppText(AppStrings.waitlistJoinTitle(strings))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : error != null
                ? Center(child: AppText(error!))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppText(
                        preview?['event_title']?.toString() ?? widget.eventTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppText(preview?['event_date_label']?.toString() ?? ''),
                      const SizedBox(height: 20),
                      AppText(preview?['message']?.toString() ?? ''),
                      const SizedBox(height: 16),
                      AppText(
                        AppStrings.waitlistEstimatedPosition(
                          strings,
                          preview?['estimated_position']?.toString() ?? '—',
                        ),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: joining ? null : _confirmJoin,
                        child: joining
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : AppText(AppStrings.waitlistJoinConfirm(strings)),
                      ),
                    ],
                  ),
      ),
    );
  }
}
