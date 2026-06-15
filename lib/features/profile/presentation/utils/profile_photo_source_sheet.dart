import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/ios_action_bottom_sheet.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

enum ProfilePhotoSource { camera, gallery }

class ProfilePhotoSourceSheet {
  ProfilePhotoSourceSheet._();

  static Future<ProfilePhotoSource?> show(BuildContext context) {
    final strings = context.l10n;

    return IosActionBottomSheet.show<ProfilePhotoSource>(
      context: context,
      child: IosActionBottomSheet.body(
        children: [
          IosActionGroup(
            children: [
              IosSheetTitle(
                title: AppStrings.profilePhotoChooseSource(strings),
              ),
              const IosSheetDivider(),
              IosSheetAction(
                label: AppStrings.profilePhotoTake(strings),
                icon: Icons.photo_camera_outlined,
                color: ProfileDesignSpec.primary,
                fontWeight: FontWeight.w500,
                onTap: () => Navigator.of(context).pop(ProfilePhotoSource.camera),
              ),
              const IosSheetDivider(),
              IosSheetAction(
                label: AppStrings.profilePhotoGallery(strings),
                icon: Icons.photo_library_outlined,
                color: ProfileDesignSpec.primary,
                fontWeight: FontWeight.w500,
                onTap: () => Navigator.of(context).pop(ProfilePhotoSource.gallery),
              ),
            ],
          ),
          IosActionBottomSheet.gap(),
          IosActionGroup(
            children: [
              IosSheetCancelButton(
                label: AppStrings.confirmDialogCancel(strings),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
