import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_style.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_type_badge_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_event_image_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_secondary_actions_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_meta_row_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_status_icon_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_status_line_widget.dart';

class InvitationCardWidget extends StatelessWidget {
  const InvitationCardWidget({
    super.key,
    required this.invitation,
    this.isWaitingForConfirmation = false,
    this.onOpenDetail,
    this.onConfirm,
    this.onReject,
    this.onCancel,
    this.onViewQr,
    this.isConfirmLoading = false,
    this.isRejectLoading = false,
    this.isCancelLoading = false,
    this.isViewQrLoading = false,
  });

  final InvitationEntity invitation;
  final bool isWaitingForConfirmation;
  final VoidCallback? onOpenDetail;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final VoidCallback? onCancel;
  final VoidCallback? onViewQr;
  final bool isConfirmLoading;
  final bool isRejectLoading;
  final bool isCancelLoading;
  final bool isViewQrLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final isPending = invitation.status.isPending;
    final isConfirmed = invitation.status.isAccepted;
    final showViewQr = isConfirmed || invitation.canFetchQrFromApi;
    final typeColor =
        InvitationsProductKindStyle.parseHexColor(invitation.typeColorHex) ??
            InvitationsProductKindStyle.colorFor(
              InvitationsProductKindResolver.resolve(invitation),
            );
    final imageWidth = InvitationsDesignSpec.px(
      context,
      InvitationsDesignSpec.cardImageWidth,
    );
    final imageGap = InvitationsDesignSpec.px(context, 12);
    final radius = InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardRadius);
    final qrCountdown = InvitationsTextFactory.qrAvailabilityLabel(strings, invitation);

    return Container(
      margin: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: theme.cardBorder),
        boxShadow: InvitationsScreenTheme.cardShadow(context),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border(
            left: BorderSide(
              color: typeColor,
              width: InvitationsDesignSpec.px(context, 4),
            ),
          ),
        ),
        padding: EdgeInsets.only(left: InvitationsDesignSpec.px(context, 8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onOpenDetail,
                borderRadius: BorderRadius.circular(radius),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: imageWidth + imageGap),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  invitation.eventTitle,
                                  style: TextStyle(
                                    fontSize: InvitationsDesignSpec.px(context, 15),
                                    fontWeight: FontWeight.w700,
                                    color: InvitationsScreenTheme.title(context),
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              SizedBox(width: InvitationsDesignSpec.px(context, 8)),
                              InvitationStatusIconWidget(status: invitation.status),
                            ],
                          ),
                          SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                          InvitationMetaRowWidget(
                            icon: Icons.location_on_outlined,
                            label: invitation.locationLabel,
                          ),
                          InvitationMetaRowWidget(
                            icon: Icons.calendar_today_outlined,
                            label: invitation.dateTimeLabel,
                          ),
                          InvitationMetaRowWidget(
                            icon: Icons.diamond_outlined,
                            label: InvitationsTextFactory.tierLabel(strings, invitation),
                          ),
                          SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                          InvitationTypeBadgeWidget(invitation: invitation),
                          if (InvitationsTextFactory.acceptByLabel(strings, invitation) !=
                              null) ...[
                            SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                            InvitationMetaRowWidget(
                              icon: Icons.timer_outlined,
                              label: InvitationsTextFactory.acceptByLabel(
                                strings,
                                invitation,
                              )!,
                              emphasize: true,
                            ),
                          ],
                          if (qrCountdown != null) ...[
                            SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                            InvitationMetaRowWidget(
                              icon: Icons.qr_code_2_outlined,
                              label: qrCountdown,
                              emphasize: true,
                            ),
                          ],
                          InvitationStatusLineWidget(status: invitation.status),
                          SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      width: imageWidth,
                      child: InvitationCardEventImageWidget(invitation: invitation),
                    ),
                  ],
                ),
              ),
            ),
            if (isWaitingForConfirmation) ...[
              Divider(height: 1, thickness: 1, color: theme.cardBorder),
              SizedBox(height: InvitationsDesignSpec.px(context, 14)),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                    SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                    Text(
                      AppStrings.invitationsWaitingConfirmation(strings),
                      style: TextStyle(
                        fontSize: InvitationsDesignSpec.px(context, 13),
                        color: InvitationsScreenTheme.body(context),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Divider(height: 1, thickness: 1, color: theme.cardBorder),
              SizedBox(height: InvitationsDesignSpec.px(context, 10)),
              if (isPending) ...[
                InvitationFilledActionButtonWidget(
                  label: AppStrings.invitationsConfirmAttendance(strings),
                  onPressed: onConfirm,
                  isLoading: isConfirmLoading,
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                InvitationCardSecondaryActionsWidget(
                  leftLabel: AppStrings.invitationsReject(strings),
                  onLeftPressed: onReject,
                  onViewQr: showViewQr ? onViewQr : null,
                  isLeftLoading: isRejectLoading,
                  isViewQrLoading: isViewQrLoading,
                  isQrAvailable: invitation.canFetchQrFromApi,
                  leftIsReject: true,
                ),
              ],
              if (isConfirmed) ...[
                InvitationFilledActionButtonWidget(
                  label: AppStrings.invitationsAttendanceConfirmed(strings),
                  enabled: false,
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                if (!invitation.canCancel)
                  Padding(
                    padding: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 8)),
                    child: Text(
                      AppStrings.invitationsCancellationDeadlinePassed(strings),
                      style: TextStyle(
                        fontSize: InvitationsDesignSpec.px(context, 12),
                        color: InvitationsScreenTheme.body(context),
                      ),
                    ),
                  ),
                InvitationCardSecondaryActionsWidget(
                  leftLabel: invitation.canCancel && onCancel != null
                      ? AppStrings.invitationsCancel(strings)
                      : null,
                  onLeftPressed: invitation.canCancel ? onCancel : null,
                  onViewQr: onViewQr,
                  isLeftLoading: isCancelLoading,
                  isViewQrLoading: isViewQrLoading,
                  isQrAvailable: invitation.canFetchQrFromApi,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
