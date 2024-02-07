import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:metadata_god/metadata_god.dart';
import 'package:mime/mime.dart';
import 'package:vibeforge/models/song_model.dart';

class FileSaveHelper {
  static Future<void> saveFile(
      String downloadsPath, VibeSong song, Uint8List data) async {
    String fileName = song.name ?? '';

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

      print('File saved at: $filePath');

      // Download the image from the URL
      http.Response response = await http.get(Uri.parse(song.imageUrl ?? ''));
      Uint8List imageBytes = response.bodyBytes;

      // Determine the MIME type of the downloaded image
      String mimeType = response.headers['content-type'] ??
          lookupMimeType(song.imageUrl ?? '') ??
          '';

      // Add metadata to the saved file
      await MetadataGod.writeMetadata(
        file: filePath,
        metadata: Metadata(
          title: song.name,
          artist: song.artists?.map((artist) => artist.name).join(', '),
          genre: song.genre,
          fileSize: file.lengthSync(),
          picture: Picture(
            data: imageBytes,
            mimeType: mimeType,
          ),
        ),
      );

      log('Metadata added to the file: $filePath');
    } catch (e) {
      log('Error saving file or adding metadata: $e');
    }
  }
}
