import 'package:flutter/material.dart';
import 'package:youpass/staff_app/core/constants/app_colors.dart';

@immutable
class YouPassThemeExtension extends ThemeExtension<YouPassThemeExtension> {
  const YouPassThemeExtension({
    required this.cardBackground,
    required this.cardBorder,
    required this.chipSelectedBackground,
    required this.chipSelectedForeground,
    required this.chipUnselectedBackground,
    required this.chipUnselectedForeground,
    required this.chipUnselectedBorder,
    required this.searchFill,
    required this.searchBorder,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.drawerMenuTileBackground,
    required this.drawerMenuBorder,
    required this.drawerMenuTitle,
    required this.drawerInvitationsTileBackground,
    required this.drawerInvitationsBadgeBackground,
    required this.drawerInvitationsBadgeText,
    required this.drawerAvatarBackground,
    required this.profileCardBackground,
    required this.profileCardBorder,
    required this.profileRowDivider,
    required this.profileSectionDivider,
    required this.profileIconBadgeBackground,
    required this.outlineButtonFill,
    required this.outlineButtonBorder,
    required this.outlineButtonForeground,
    required this.inputFill,
    required this.authCurveAccent,
  });

  final Color cardBackground;
  final Color cardBorder;
  final Color chipSelectedBackground;
  final Color chipSelectedForeground;
  final Color chipUnselectedBackground;
  final Color chipUnselectedForeground;
  final Color chipUnselectedBorder;
  final Color searchFill;
  final Color searchBorder;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color drawerMenuTileBackground;
  final Color drawerMenuBorder;
  final Color drawerMenuTitle;
  final Color drawerInvitationsTileBackground;
  final Color drawerInvitationsBadgeBackground;
  final Color drawerInvitationsBadgeText;
  final Color drawerAvatarBackground;
  final Color profileCardBackground;
  final Color profileCardBorder;
  final Color profileRowDivider;
  final Color profileSectionDivider;
  final Color profileIconBadgeBackground;
  final Color outlineButtonFill;
  final Color outlineButtonBorder;
  final Color outlineButtonForeground;
  final Color inputFill;
  final Color authCurveAccent;

  static const Color invitationsTitle = AppColors.drawerGold;
  static const Color drawerGold = AppColors.drawerGold;

  static const light = YouPassThemeExtension(
    cardBackground: AppColors.backgroundWhite,
    cardBorder: AppColors.homeDividerGrey,
    chipSelectedBackground: AppColors.primaryMustard,
    chipSelectedForeground: AppColors.backgroundWhite,
    chipUnselectedBackground: AppColors.backgroundWhite,
    chipUnselectedForeground: AppColors.homeBlack,
    chipUnselectedBorder: AppColors.lightGreyBorder,
    searchFill: Color(0xFFF5F5F5),
    searchBorder: Color(0xFFE8E8E8),
    shimmerBase: Color(0xFFE8E8E8),
    shimmerHighlight: Color(0xFFF5F5F5),
    drawerMenuTileBackground: AppColors.backgroundWhite,
    drawerMenuBorder: AppColors.drawerMenuBorder,
    drawerMenuTitle: AppColors.homeBlack,
    drawerInvitationsTileBackground: AppColors.drawerMenuHighlight,
    drawerInvitationsBadgeBackground: AppColors.drawerGoldBadge,
    drawerInvitationsBadgeText: Color(0xFFE8873A),
    drawerAvatarBackground: AppColors.drawerAvatarFill,
    profileCardBackground: AppColors.drawerProfileBackground,
    profileCardBorder: Color(0xFFF5C878),
    profileRowDivider: Color(0xFFEEEEEE),
    profileSectionDivider: Color(0xFFFDE6B0),
    profileIconBadgeBackground: Color(0xFFFFF0D6),
    outlineButtonFill: AppColors.outlineButtonFill,
    outlineButtonBorder: AppColors.outlineButtonBorder,
    outlineButtonForeground: AppColors.outlineButtonForeground,
    inputFill: AppColors.backgroundWhite,
    authCurveAccent: AppColors.curveAccent,
  );

  static const dark = YouPassThemeExtension(
    cardBackground: Color(0xFF1A1A1A),
    cardBorder: Color(0xFF2A2A2A),
    chipSelectedBackground: AppColors.homeAccentYellow,
    chipSelectedForeground: AppColors.homeBlack,
    chipUnselectedBackground: Color(0xFF2A2A2A),
    chipUnselectedForeground: AppColors.backgroundWhite,
    chipUnselectedBorder: Color(0xFF3A3A3A),
    searchFill: Color(0xFF252525),
    searchBorder: Color(0xFF3A3A3A),
    shimmerBase: Color(0xFF2A2A2A),
    shimmerHighlight: Color(0xFF3A3A3A),
    drawerMenuTileBackground: Color(0xFF1A1A1A),
    drawerMenuBorder: Color(0xFF2A2A2A),
    drawerMenuTitle: AppColors.backgroundWhite,
    drawerInvitationsTileBackground: Color(0xFF2A2210),
    drawerInvitationsBadgeBackground: Color(0xFF3D3018),
    drawerInvitationsBadgeText: AppColors.homeAccentYellow,
    drawerAvatarBackground: Color(0xFF2A2A2A),
    profileCardBackground: AppColors.drawerProfileBackground,
    profileCardBorder: Color(0xFFF5C878),
    profileRowDivider: Color(0xFF2A2A2A),
    profileSectionDivider: Color(0xFF2A2A2A),
    profileIconBadgeBackground: Color(0xFF2A2210),
    outlineButtonFill: Color(0xFF1A1A1A),
    outlineButtonBorder: AppColors.homeAccentYellow,
    outlineButtonForeground: AppColors.homeAccentYellow,
    inputFill: Color(0xFF1A1A1A),
    authCurveAccent: Color(0xFF2A2210),
  );

  static YouPassThemeExtension of(BuildContext context) {
    return Theme.of(context).extension<YouPassThemeExtension>() ?? light;
  }

  @override
  YouPassThemeExtension copyWith({
    Color? cardBackground,
    Color? cardBorder,
    Color? chipSelectedBackground,
    Color? chipSelectedForeground,
    Color? chipUnselectedBackground,
    Color? chipUnselectedForeground,
    Color? chipUnselectedBorder,
    Color? searchFill,
    Color? searchBorder,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? drawerMenuTileBackground,
    Color? drawerMenuBorder,
    Color? drawerMenuTitle,
    Color? drawerInvitationsTileBackground,
    Color? drawerInvitationsBadgeBackground,
    Color? drawerInvitationsBadgeText,
    Color? drawerAvatarBackground,
    Color? profileCardBackground,
    Color? profileCardBorder,
    Color? profileRowDivider,
    Color? profileSectionDivider,
    Color? profileIconBadgeBackground,
    Color? outlineButtonFill,
    Color? outlineButtonBorder,
    Color? outlineButtonForeground,
    Color? inputFill,
    Color? authCurveAccent,
  }) {
    return YouPassThemeExtension(
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      chipSelectedBackground:
          chipSelectedBackground ?? this.chipSelectedBackground,
      chipSelectedForeground:
          chipSelectedForeground ?? this.chipSelectedForeground,
      chipUnselectedBackground:
          chipUnselectedBackground ?? this.chipUnselectedBackground,
      chipUnselectedForeground:
          chipUnselectedForeground ?? this.chipUnselectedForeground,
      chipUnselectedBorder: chipUnselectedBorder ?? this.chipUnselectedBorder,
      searchFill: searchFill ?? this.searchFill,
      searchBorder: searchBorder ?? this.searchBorder,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      drawerMenuTileBackground:
          drawerMenuTileBackground ?? this.drawerMenuTileBackground,
      drawerMenuBorder: drawerMenuBorder ?? this.drawerMenuBorder,
      drawerMenuTitle: drawerMenuTitle ?? this.drawerMenuTitle,
      drawerInvitationsTileBackground: drawerInvitationsTileBackground ??
          this.drawerInvitationsTileBackground,
      drawerInvitationsBadgeBackground: drawerInvitationsBadgeBackground ??
          this.drawerInvitationsBadgeBackground,
      drawerInvitationsBadgeText:
          drawerInvitationsBadgeText ?? this.drawerInvitationsBadgeText,
      drawerAvatarBackground:
          drawerAvatarBackground ?? this.drawerAvatarBackground,
      profileCardBackground:
          profileCardBackground ?? this.profileCardBackground,
      profileCardBorder: profileCardBorder ?? this.profileCardBorder,
      profileRowDivider: profileRowDivider ?? this.profileRowDivider,
      profileSectionDivider:
          profileSectionDivider ?? this.profileSectionDivider,
      profileIconBadgeBackground:
          profileIconBadgeBackground ?? this.profileIconBadgeBackground,
      outlineButtonFill: outlineButtonFill ?? this.outlineButtonFill,
      outlineButtonBorder: outlineButtonBorder ?? this.outlineButtonBorder,
      outlineButtonForeground:
          outlineButtonForeground ?? this.outlineButtonForeground,
      inputFill: inputFill ?? this.inputFill,
      authCurveAccent: authCurveAccent ?? this.authCurveAccent,
    );
  }

  @override
  YouPassThemeExtension lerp(
    covariant ThemeExtension<YouPassThemeExtension>? other,
    double t,
  ) {
    if (other is! YouPassThemeExtension) {
      return this;
    }

    Color blend(Color a, Color b) => Color.lerp(a, b, t)!;

    return YouPassThemeExtension(
      cardBackground: blend(cardBackground, other.cardBackground),
      cardBorder: blend(cardBorder, other.cardBorder),
      chipSelectedBackground:
          blend(chipSelectedBackground, other.chipSelectedBackground),
      chipSelectedForeground:
          blend(chipSelectedForeground, other.chipSelectedForeground),
      chipUnselectedBackground:
          blend(chipUnselectedBackground, other.chipUnselectedBackground),
      chipUnselectedForeground:
          blend(chipUnselectedForeground, other.chipUnselectedForeground),
      chipUnselectedBorder: blend(chipUnselectedBorder, other.chipUnselectedBorder),
      searchFill: blend(searchFill, other.searchFill),
      searchBorder: blend(searchBorder, other.searchBorder),
      shimmerBase: blend(shimmerBase, other.shimmerBase),
      shimmerHighlight: blend(shimmerHighlight, other.shimmerHighlight),
      drawerMenuTileBackground:
          blend(drawerMenuTileBackground, other.drawerMenuTileBackground),
      drawerMenuBorder: blend(drawerMenuBorder, other.drawerMenuBorder),
      drawerMenuTitle: blend(drawerMenuTitle, other.drawerMenuTitle),
      drawerInvitationsTileBackground: blend(
        drawerInvitationsTileBackground,
        other.drawerInvitationsTileBackground,
      ),
      drawerInvitationsBadgeBackground: blend(
        drawerInvitationsBadgeBackground,
        other.drawerInvitationsBadgeBackground,
      ),
      drawerInvitationsBadgeText:
          blend(drawerInvitationsBadgeText, other.drawerInvitationsBadgeText),
      drawerAvatarBackground:
          blend(drawerAvatarBackground, other.drawerAvatarBackground),
      profileCardBackground:
          blend(profileCardBackground, other.profileCardBackground),
      profileCardBorder: blend(profileCardBorder, other.profileCardBorder),
      profileRowDivider: blend(profileRowDivider, other.profileRowDivider),
      profileSectionDivider:
          blend(profileSectionDivider, other.profileSectionDivider),
      profileIconBadgeBackground: blend(
        profileIconBadgeBackground,
        other.profileIconBadgeBackground,
      ),
      outlineButtonFill: blend(outlineButtonFill, other.outlineButtonFill),
      outlineButtonBorder:
          blend(outlineButtonBorder, other.outlineButtonBorder),
      outlineButtonForeground:
          blend(outlineButtonForeground, other.outlineButtonForeground),
      inputFill: blend(inputFill, other.inputFill),
      authCurveAccent: blend(authCurveAccent, other.authCurveAccent),
    );
  }
}
