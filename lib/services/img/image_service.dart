import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageService {
  static const String cloudName = 'dkxjsiq62'; // Cloudinary cloud name
  static const String uploadPreset = 'image_upload'; // Your unsigned preset

  /// Upload image to Cloudinary, return image URL
  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final data = json.decode(resStr);
      return data['secure_url'];
    } else {
      print("❌ Upload failed with status: ${response.statusCode}");
      return null;
    }
  }

  /// Select image from gallery, return Cloudinary image URL
  static Future<String?> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print("❌ No image selected");
      return null;
    }

    final file = File(pickedFile.path);
    return await uploadImageToCloudinary(file);
  }
}
