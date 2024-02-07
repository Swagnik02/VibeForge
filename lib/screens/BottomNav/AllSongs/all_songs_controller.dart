import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';
import 'package:vibeforge/vibeComponents/model_conversion.dart';

class AllSongsController extends GetxController {
  late TextEditingController searchController = TextEditingController();

  List<VibeSong> musicList = [];

  List<String> selectedFolders = [];
  List<FileSystemEntity> files = [];
  // List<Map<String, dynamic>> musicList = []; // List to store song details
  List<Map<String, dynamic>> filteredMusicList =
      []; // List to store filtered music

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    // Initialize filteredMusicList with the entire musicList initially
    filteredMusicList = List.from(musicList);
  }

  // Method to filter music list based on search input
  void filterMusicList(String searchQuery) {
    // if (searchQuery.isEmpty) {
    //   // If search query is empty, show the entire list
    //   filteredMusicList = List.from(musicList);
    // } else {
    //   // If search query is not empty, filter the list based on the query
    //   filteredMusicList = musicList
    //       .where((song) =>
    //           song['name'].toLowerCase().contains(searchQuery.toLowerCase()))
    //       .toList();
    // }
    update();
  }

  void resetSearch() {
    searchController.clear(); // Clear the search text
    filteredMusicList = List.from(musicList); // Reset the filtered list
    update();
  }

  void addFolder() async {
    final path = await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      return;
    }

    log(path);

    selectedFolders.add(path);
    update();
    await _loadFiles(path);
  }

  playAudioFile(VibeSong song) async {
    // VibeSong song = await createVibeSongFromMetadata(filepath);
    Get.to(VibeSongScreen(
      song: song,
      musicSource: MusicSource.localDirectory,
    ));
  }

  Future<void> _loadFiles(String path) async {
    try {
      Directory dir = Directory(path);
      List<FileSystemEntity> fileList = dir.listSync();

      List<VibeSong> tempMusicList = [];

      for (FileSystemEntity file in fileList) {
        if (file is File) {
          // Assuming createVibeSongFromMetadata returns a VibeSong object
          VibeSong song = await createVibeSongFromMetadata(file.path);

          tempMusicList.add(song);
        }
      }

      // Set the musicList to the temporary list after loading all files
      musicList = tempMusicList;

      // Update the UI
      update();
    } catch (e) {
      print("Error loading files: $e");
    }
  }
}
