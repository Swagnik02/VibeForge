import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileSaveHelper {
  static Future<void> saveFile(String fileName, Uint8List data) async {
    try {
      // Get the external storage directory
      Directory? externalDir = await getExternalStorageDirectory();

      // Append "Downloads" to the path
      String downloadsPath = '${externalDir!.path}/Downloads';

      // Check if the Downloads directory exists, create it if not
      Directory downloadsDir = Directory(downloadsPath);
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }

      String filePath = '$downloadsPath/$fileName';

      // Write the file
      File file = File(filePath);
      await file.writeAsBytes(data);

      print('File saved at: $filePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  }
}
