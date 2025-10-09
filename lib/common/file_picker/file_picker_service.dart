import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
  // Pick single file
  static Future<File?> pickFile({
    List<String>? allowedExtensions,
    FileType type = FileType.any,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }

  // Pick multiple files
  static Future<List<File>?> pickMultipleFiles({
    List<String>? allowedExtensions,
    FileType type = FileType.any,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowMultiple: true,
        allowedExtensions: allowedExtensions,
      );

      if (result != null) {
        return result.paths
            .where((path) => path != null)
            .map((path) => File(path!))
            .toList();
      }
      return null;
    } catch (e) {
      print('Error picking files: $e');
      return null;
    }
  }

  // Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  // Pick image from camera
  static Future<File?> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      print('Error taking photo: $e');
      return null;
    }
  }

  // Pick video
  static Future<File?> pickVideo() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        return File(video.path);
      }
      return null;
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

  // Pick PDF file
  static Future<File?> pickPDF() async {
    return await pickFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  }

  // Pick image (jpg, png, jpeg)
  static Future<File?> pickImage() async {
    return await pickFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
  }

  // Pick document (pdf, doc, docx)
  static Future<File?> pickDocument() async {
    return await pickFile(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
  }

  // Get file size in KB
  static String getFileSize(File file) {
    int bytes = file.lengthSync();
    double kb = bytes / 1024;
    return '${kb.toStringAsFixed(2)} KB';
  }

  // Get file extension
  static String getFileExtension(File file) {
    return file.path.split('.').last;
  }

  // Get file name
  static String getFileName(File file) {
    return file.path.split('/').last;
  }
}

// =========== Usage Examples: =================
class FilePickerExamples {
  // Example 1: Pick any file
  Future<void> pickAnyFile() async {
    File? file = await FilePickerService.pickFile();
    if (file != null) {
      print('File picked: ${FilePickerService.getFileName(file)}');
      print('File size: ${FilePickerService.getFileSize(file)}');
    }
  }

  // Example 2: Pick PDF only
  Future<void> pickPDFFile() async {
    File? file = await FilePickerService.pickPDF();
    if (file != null) {
      print('PDF picked: ${file.path}');
    }
  }

  // Example 3: Pick image from gallery
  Future<void> pickImageFromGallery() async {
    File? image = await FilePickerService.pickImageFromGallery();
    if (image != null) {
      print('Image picked: ${image.path}');
    }
  }

  // Example 4: Pick multiple files
  Future<void> pickMultipleFiles() async {
    List<File>? files = await FilePickerService.pickMultipleFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );
    if (files != null) {
      print('${files.length} files picked');
      for (var file in files) {
        print('- ${FilePickerService.getFileName(file)}');
      }
    }
  }

  // Example 5: Pick image with choice (camera or gallery)
  Future<void> pickImageWithChoice(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                File? image = await FilePickerService.pickImageFromCamera();
                if (image != null) {
                  print('Photo taken: ${image.path}');
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                File? image = await FilePickerService.pickImageFromGallery();
                if (image != null) {
                  print('Image selected: ${image.path}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
Add these dependencies to pubspec.yaml:

dependencies:
  file_picker: ^8.1.4
  image_picker: ^1.1.2

For Android, add to AndroidManifest.xml:
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.CAMERA"/>

For iOS, add to Info.plist:
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera</string>
*/