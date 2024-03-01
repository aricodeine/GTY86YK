import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<String?> pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    return returnedImage?.path;
  }
}
