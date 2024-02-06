import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:vibeforge/common/utils.dart';

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
            onTap: () {
              // Open the file on tap
              OpenFile.open(
                files[index].path,
                // type: 'audio/mp3', // Specify the MIME type
              );
            },
          );
        },
      ),
    );
  }
}
