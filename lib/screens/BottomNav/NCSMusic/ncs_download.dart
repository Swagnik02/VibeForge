import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/services/permission_service.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';
import 'package:vibeforge/vibeComponents/model_conversion.dart';

class NCSDownloads extends StatefulWidget {
  const NCSDownloads({super.key});

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
    if (await requestPermission(Permission.storage) == true) {
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
    } else {
      // Handle the case when storage permission is not granted
      log('Storage permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
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
              VibeSong song =
                  await createVibeSongFromMetadata(files[index].path);

              Get.to(VibeSongScreen(
                song: song,
                musicSource: MusicSource.downloadedNCS,
              ));
            },
          );
        },
      ),
    );
  }
}
