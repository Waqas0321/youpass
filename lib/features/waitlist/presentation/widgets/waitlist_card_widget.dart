import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_meta_row_widget.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';

class WaitlistCardWidget extends StatelessWidget {
  const WaitlistCardWidget({
    super.key,
    required this.entry,
    this.onLeave,
    this.onClaim,
    this.isLoading = false,
  });

  final WaitlistEntryEntity entry;
  final VoidCallback? onLeave;
  final VoidCallback? onClaim;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final radius = InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardRadius);
    final imageWidth = InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardImageWidth);
    final imageGap = InvitationsDesignSpec.px(context, 12);
    final accent = entry.isUrgent
        ? InvitationsScreenTheme.accent(context)
        : InvitationsScreenTheme.accent(context).withValues(alpha: 0.85);

    return Container(
      margin: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: entry.isUrgent
            ? InvitationsScreenTheme.accent(context).withValues(alpha: 0.08)
            : theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: entry.isUrgent
              ? InvitationsScreenTheme.accent(context)
              : theme.cardBorder,
          width: entry.isUrgent ? 1.5 : 1,
        ),
        boxShadow: InvitationsScreenTheme.cardShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  InvitationsDesignSpec.px(context, InvitationsDesignSpec.imageRadius),
                ),
                child: SizedBox(
                  width: imageWidth,
                  height: imageWidth,
                  child: EventNetworkImage(
                    imageUrl: entry.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: imageGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: InvitationsDesignSpec.px(context, 8),
                        vertical: InvitationsDesignSpec.px(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        entry.badge,
                        style: TextStyle(
                          fontSize: InvitationsDesignSpec.px(context, 10),
                          fontWeight: FontWeight.w700,
                          color: accent,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                    Text(
                      entry.eventTitle,
                      style: TextStyle(
                        fontSize: InvitationsDesignSpec.px(context, 14),
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                    InvitationMetaRowWidget(
                      icon: Icons.calendar_today_outlined,
                      label: entry.dateTimeLabel,
                    ),
                    InvitationMetaRowWidget(
                      icon: Icons.location_on_outlined,
                      label: entry.locationLabel,
                    ),
                    SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                    Text(
                      entry.statusLabel,
                      style: TextStyle(
                        fontSize: InvitationsDesignSpec.px(context, 12),
                        color: entry.isUrgent ? accent : InvitationsScreenTheme.body(context),
                        fontWeight: entry.isUrgent ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 12)),
          if (entry.canClaim)
            InvitationFilledActionButtonWidget(
              label: AppStrings.waitlistClaimSlot(strings),
              onPressed: isLoading ? null : onClaim,
              isLoading: isLoading,
            )
          else if (entry.canLeave)
            OutlinedButton(
              onPressed: isLoading ? null : onLeave,
              child: Text(AppStrings.waitlistLeave(strings)),
            ),
        ],
      ),
    );
  }
}
