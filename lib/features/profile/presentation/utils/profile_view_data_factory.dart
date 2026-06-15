import 'package:youpass/core/auth/gender_api_mapper.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/profile/presentation/models/profile_view_data.dart';
import 'package:youpass/l10n/app_localizations.dart';

class ProfileViewDataFactory {
  ProfileViewDataFactory._();

  static ProfileViewData build(
    AppLocalizations l10n, {
    UserEntity? user,
    UserProfileEntity? profile,
  }) {
    if (profile != null) {
      return ProfileViewData(
        fullName: profile.fullName,
        phone: profile.phoneDisplay,
        email: profile.email,
        birthDate: formatBirthdate(profile.birthdate),
        gender: GenderApiMapper.toDisplayLabel(profile.gender, l10n),
        instagramHandle: formatInstagram(
          profile.instagramUsername,
          notAddedLabel: AppStrings.profileNotAdded(l10n),
        ),
        profilePhotoUrl: profile.profilePhotoUrl,
        membershipCategory: profile.category,
      );
    }

    final name = _resolveName(user);

    return ProfileViewData(
      fullName: name,
      phone: '',
      email: user?.email ?? '',
      birthDate: '',
      gender: '',
      instagramHandle: '',
    );
  }

  static String formatBirthdate(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    final parsed = DateTime.tryParse(trimmed);
    if (parsed != null) {
      final local = parsed.toLocal();
      final day = local.day.toString().padLeft(2, '0');
      final month = local.month.toString().padLeft(2, '0');
      final year = local.year.toString();
      return '$day / $month / $year';
    }

    final dateOnly = trimmed.length >= 10 ? trimmed.substring(0, 10) : trimmed;
    final parts = dateOnly.split('-');
    if (parts.length == 3) {
      return '${parts[2]} / ${parts[1]} / ${parts[0]}';
    }

    return trimmed;
  }

  static String formatInstagram(String? username, {String notAddedLabel = ''}) {
    if (username == null || username.isEmpty) {
      return notAddedLabel;
    }

    return username.startsWith('@') ? username : '@$username';
  }

  static String _resolveName(UserEntity? user) {
    final raw = user?.name.trim();
    if (raw == null || raw.isEmpty) {
      return '';
    }

    return raw;
  }

}
