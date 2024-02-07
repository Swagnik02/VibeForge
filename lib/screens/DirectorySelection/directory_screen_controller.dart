import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/services/permission_service.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';
import 'package:vibeforge/vibeComponents/model_conversion.dart';

class DirectoryScreenController extends GetxController {
  List<String> selectedFolders = [];
  List<FileSystemEntity> files = [];

  void addFolder() async {
    if (await requestPermission(Permission.storage) == true) {
      final path = await FilePicker.platform.getDirectoryPath();
      if (path == null) {
        return;
      }

      log(path);

      selectedFolders.add(path);
      update();
      await _loadFiles(path);
    } else {
      // Handle the case when storage permission is not granted
      log('Storage permission not granted');
    }
  }

  Future<void> _loadFiles(String path) async {
    try {
      Directory dir = Directory(path);
      List<FileSystemEntity> fileList = dir.listSync();

      files = fileList;
      update();
    } catch (e) {
      print("Error loading files: $e");
    }
  }

  playAudioFile(int index) async {
    VibeSong song = await createVibeSongFromMetadata(files[index].path);
    Get.to(VibeSongScreen(
      song: song,
      musicSource: MusicSource.localDirectory,
    ));
  }
}
