import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

class FileSaveHelper {
  static Future<void> saveFile(
      String downloadsPath, String fileName, Uint8List data) async {
    try {
      // Get the external storage directory
      // Directory? externalDir = await getExternalStorageDirectory();

      // Check if the Downloads directory exists, create it if not
      Directory downloadsDir = Directory(downloadsPath);
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }

      // Concatenate the file extension '.mp3' to the file name
      String filePath = '$downloadsPath/$fileName.mp3';

      // Write the file
      File file = File(filePath);
      await file.writeAsBytes(data);

      log('File saved at: $filePath');
    } catch (e) {
      log('Error saving file: $e');
    }
  }
}
