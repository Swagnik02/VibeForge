import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:open_file/open_file.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/screens/local_song_screen.dart';

class NCSDownloads extends StatefulWidget {
  const NCSDownloads({Key? key}) : super(key: key);

  @override
  _NCSDownloadsState createState() => _NCSDownloadsState();
}

class _NCSDownloadsState extends State<NCSDownloads> {
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    try {
      // Get the external storage directory
      // Directory? externalDir = await getExternalStorageDirectory();

      // Append "Downloads" to the path
      // String downloadsPath = '${externalDir!.path}/Downloads';

      Directory dir = Directory(FilePath.ncsDownloads);
      List<FileSystemEntity> fileList = dir.listSync();
      setState(() {
        files = fileList;
      });
    } catch (e) {
      print("Error loading files: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads'),
        actions: [
          IconButton(
            onPressed: () {
              // Call the function to print files on button press
              for (var file in files) {
                print('File: ${file.uri.pathSegments.last}');
              }
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(22 / 7),
              child: const Icon(
                Icons.sort_rounded,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(files[index].uri.pathSegments.last),
            onTap: () async {
              Metadata metadata =
                  await MetadataGod.readMetadata(file: files[index].path);

              log(metadata.title ?? '');

// Extract image bytes from the metadata if available
              Uint8List? imageBytes;
              String? mimeType;
              if (metadata.picture != null) {
                imageBytes = metadata.picture!.data;
                mimeType = metadata.picture!.mimeType;
              }

              Song song = Song(
                title: metadata.title ?? '',
                description: metadata.artist ?? '',
                url: files[index].path,
                // Convert image bytes to base64 and use it as the coverUrl
                coverUrl: imageBytes != null
                    ? 'data:$mimeType;base64,${base64Encode(imageBytes)}'
                    : '',
              );

              // Get.toNamed('/localSong', arguments: song);
              Get.to(LocalSongScreen(song: song));
              // Open the file on tap
              // OpenFile.open(
              //   files[index].path,
              //   // type: 'audio/mp3', // Specify the MIME type
              // );
            },
          );
        },
      ),
    );
  }
}
