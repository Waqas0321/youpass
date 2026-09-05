import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';
import 'package:youpass/routes/app_routes.dart';

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
  String? errorMessage;
  String? errorCode;

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
        errorMessage = null;
        errorCode = null;
      });
    } catch (e) {
      if (!mounted) return;
      final strings = context.l10n;
      setState(() {
        loading = false;
        if (e is ApiException) {
          errorCode = e.code;
          errorMessage = AppMessageLocalizer.fromApiError(
            strings,
            code: e.code,
            fallbackMessage: e.message,
          );
        } else {
          errorCode = null;
          errorMessage = AppMessageLocalizer.fromError(strings, e);
        }
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
      final strings = context.l10n;
      setState(() {
        joining = false;
        if (e is ApiException) {
          errorCode = e.code;
          errorMessage = AppMessageLocalizer.fromApiError(
            strings,
            code: e.code,
            fallbackMessage: e.message,
          );
        } else {
          errorCode = null;
          errorMessage = AppMessageLocalizer.fromError(strings, e);
        }
      });
    }
  }

  void _openInvitations() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.myInvitations,
      (route) => route.isFirst || route.settings.name == AppRoutes.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.homeAccentYellow,
            size: 20,
          ),
        ),
        title: AppText(
          AppStrings.waitlistJoinTitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? _WaitlistStatusBody(
                    title: AppStrings.waitlistStatusTitle(strings),
                    message: errorMessage!,
                    hint: errorCode == 'ALREADY_HAS_COURTESY'
                        ? AppStrings.waitlistAlreadyHasCourtesyHint(strings)
                        : null,
                    icon: errorCode == 'ALREADY_HAS_COURTESY'
                        ? Icons.mail_outline_rounded
                        : Icons.info_outline_rounded,
                    primaryLabel: errorCode == 'ALREADY_HAS_COURTESY'
                        ? AppStrings.waitlistViewInvitations(strings)
                        : null,
                    onPrimary: errorCode == 'ALREADY_HAS_COURTESY'
                        ? _openInvitations
                        : null,
                    secondaryLabel: AppStrings.backButton(strings),
                    onSecondary: () => Navigator.of(context).pop(),
                    accentColor: theme.colorScheme.primary,
                  )
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
                        style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: joining
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : AppText(
                                AppStrings.waitlistJoinConfirm(strings),
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class _WaitlistStatusBody extends StatelessWidget {
  const _WaitlistStatusBody({
    required this.title,
    required this.message,
    required this.icon,
    required this.secondaryLabel,
    required this.onSecondary,
    required this.accentColor,
    this.hint,
    this.primaryLabel,
    this.onPrimary,
  });

  final String title;
  final String message;
  final String? hint;
  final IconData icon;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final String secondaryLabel;
  final VoidCallback onSecondary;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accentColor.withValues(alpha: 0.18)),
          ),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 34, color: accentColor),
              ),
              const SizedBox(height: 20),
              AppText(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              AppText(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
              if (hint != null) ...[
                const SizedBox(height: 12),
                AppText(
                  hint!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ],
          ),
        ),
        const Spacer(),
        if (primaryLabel != null && onPrimary != null) ...[
          FilledButton(
            onPressed: onPrimary,
            style: FilledButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: AppText(
              primaryLabel!,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
        ],
        OutlinedButton(
          onPressed: onSecondary,
          child: AppText(secondaryLabel),
        ),
      ],
    );
  }
}
