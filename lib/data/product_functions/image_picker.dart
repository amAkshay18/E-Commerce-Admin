import 'package:image_picker/image_picker.dart';

Future<String?> takeImg() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

  return pickedImage?.path;
}
