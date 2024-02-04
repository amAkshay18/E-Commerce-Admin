import 'package:image_picker/image_picker.dart';
import 'dart:io';

File? pickedImageFile;
Future<File> takeImg() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    null;
  }
  return File(pickedImage!.path);
}
