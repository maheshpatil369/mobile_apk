import 'dart:io';
import 'package:image_picker/image_picker.dart';

// A utility class to handle image picking from camera or gallery.
// This keeps the image picking logic separate and reusable.
class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      // Handle potential platform exceptions (e.g., permissions denied)
      print("Failed to pick image: $e");
    }
    return null;
  }
}
