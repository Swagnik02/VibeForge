import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/screens/DirectorySelection/directory_screen_controller.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';

class DirectoryScreen extends StatelessWidget {
  DirectoryScreen({super.key});

  final DirectoryScreenController controller =
      Get.put(DirectoryScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectoryScreenController>(
      builder: (_) => Container(
        decoration: boxDecor(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Scan Media',
              style: TextStyle(
                color: Colors.purpleAccent.shade400,
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: Get.back,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.purpleAccent.shade400,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: _mainBody(),
        ),
      ),
    );
  }

  // Background Gradient Colour

  BoxDecoration boxDecor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorConstants.themeColourShade3,
          ColorConstants.themeColourShade2,
          ColorConstants.themeColourShade1,
        ],
      ),
    );
  }

  Widget _mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => controller.addFolder(),
          child: Text('Add Folder'),
        ),

        // Display the added folders
        Text('Display the added folders'),
        for (String folder in controller.selectedFolders)
          ListTile(
            title: Text(folder),
          ),

        Expanded(
          child: ListView.builder(
            itemCount: controller.files.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.files[index].uri.pathSegments.last),
                onTap: () async {
                  Metadata metadata = await MetadataGod.readMetadata(
                      file: controller.files[index].path);

                  log(metadata.title ?? '');

// Extract image bytes from the metadata if available
                  Uint8List? imageBytes;
                  String? mimeType;
                  if (metadata.picture != null) {
                    imageBytes = metadata.picture!.data;
                    mimeType = metadata.picture!.mimeType;
                  }

                  VibeSong song = VibeSong(
                    name: metadata.title ?? '',
                    // artists: metadata.artist ?? '',
                    songUrl: controller.files[index].path,
                    // Convert image bytes to base64 and use it as the coverUrl
                    imageUrl: imageBytes != null
                        ? 'data:$mimeType;base64,${base64Encode(imageBytes)}'
                        : '',
                  );

                  // Get.toNamed('/localSong', arguments: song);
                  Get.to(VibeSongScreen(
                    song: song,
                    musicSource: MusicSource.localDirectory,
                  ));

                  // // Open the file on tap
                  // OpenFile.open(
                  //   controller.files[index].path,
                  //   // type: 'audio/mp3', // Specify the MIME type
                  // );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
