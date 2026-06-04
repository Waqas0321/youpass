import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfilePhotoPicker {
  ProfilePhotoPicker._();

  static final ImagePicker imagePicker = ImagePicker();

  static Future<File?> pickFromGallery() async {
    final picked = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );

    if (picked == null) {
      return null;
    }

    return File(picked.path);
  }
}
