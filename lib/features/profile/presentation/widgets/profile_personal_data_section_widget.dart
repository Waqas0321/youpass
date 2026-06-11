import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/models/profile_view_data.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/core/widgets/youpass_outline_button.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_info_row_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_personal_data_header_widget.dart';

class ProfilePersonalDataSectionWidget extends StatelessWidget {
  const ProfilePersonalDataSectionWidget({
    super.key,
    required this.data,
    this.onEditTap,
    this.onChangePhoneTap,
  });

  final ProfileViewData data;
  final VoidCallback? onEditTap;
  final VoidCallback? onChangePhoneTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfilePersonalDataHeaderWidget(
          title: AppStrings.profilePersonalData(strings),
        ),
        ProfileInfoRowWidget(
          icon: Icons.person_outline,
          label: AppStrings.profileFullName(strings),
          value: data.fullName,
          showIconCircle: true,
        ),
        if (data.phone.isNotEmpty)
          ProfileInfoRowWidget(
            icon: Icons.phone_outlined,
            label: AppStrings.profilePhone(strings),
            value: data.phone,
            showIconCircle: true,
          ),
        ProfileInfoRowWidget(
          icon: Icons.mail_outline,
          label: AppStrings.profileEmail(strings),
          value: data.email,
          showIconCircle: true,
        ),
        ProfileInfoRowWidget(
          icon: Icons.calendar_today_outlined,
          label: AppStrings.profileBirthDate(strings),
          value: data.birthDate,
          showIconCircle: true,
        ),
        ProfileInfoRowWidget(
          icon: Icons.wc_outlined,
          label: AppStrings.profileGender(strings),
          value: data.gender,
          showIconCircle: true,
        ),
        ProfileInfoRowWidget(
          icon: Icons.camera_alt_outlined,
          label: AppStrings.profileInstagram(strings),
          value: data.instagramHandle,
          useInstagramIcon: true,
          showIconCircle: true,
          showDivider: false,
        ),
        SizedBox(
          height: ProfileDesignSpec.px(
            context,
            ProfileDesignSpec.editButtonTopGap,
          ),
        ),
        if (onChangePhoneTap != null) ...[
          YouPassOutlineButton(
            label: AppStrings.profileChangePhone(strings),
            icon: Icons.swap_horiz,
            onPressed: onChangePhoneTap,
          ),
          SizedBox(
            height: ProfileDesignSpec.px(
              context,
              ProfileDesignSpec.editButtonTopGap,
            ),
          ),
        ],
        YouPassOutlineButton(
          label: AppStrings.profileEditData(strings),
          icon: Icons.edit_outlined,
          onPressed: onEditTap,
        ),
      ],
    );
  }
}
