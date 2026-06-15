import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/profile/presentation/utils/profile_photo_picker.dart';
import 'package:youpass/features/profile/presentation/utils/profile_photo_source_sheet.dart';

class ProfilePhotoActions {
  const ProfilePhotoActions(this.context);

  final BuildContext context;

  Future<void> pickAndUpload() async {
    final source = await ProfilePhotoSourceSheet.show(context);
    if (source == null || !context.mounted) {
      return;
    }

    final file = switch (source) {
      ProfilePhotoSource.camera => await ProfilePhotoPicker.pickFromCamera(),
      ProfilePhotoSource.gallery => await ProfilePhotoPicker.pickFromGallery(),
    };

    if (file == null || !context.mounted) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.uploadProfilePhoto(file.path);
    if (!context.mounted) {
      return;
    }

    final strings = context.l10n;
    if (success) {
      AppSnackBar.show(context, AppStrings.profilePhotoUpdated(strings));
      return;
    }

    final message =
        authProvider.localizedErrorMessage(strings) ?? strings.errorGeneric;
    AppSnackBar.show(context, message);
  }
}
