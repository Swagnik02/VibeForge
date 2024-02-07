import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';

class AllSongsController extends GetxController {
  late TextEditingController searchController = TextEditingController();

  List<String> selectedFolders = [];
  List<FileSystemEntity> files = [];
  List<String> musicList = [
    "Song 0",
    "Song 1",
    "Song 2",
    "enrique taylor",
    "taylor",
    "enrique",
    "Song 0",
    "Song 1",
    "Song 2",
    "enrique taylor",
    "taylor",
    "enrique",
    "Song 0",
    "Song 1",
    "Song 2",
    "enrique taylor",
    "taylor",
    "enrique",
    "Song 0",
    "Song 1",
    "Song 2",
    "enrique taylor",
    "taylor",
    "enrique",
    "Song 0",
    "Song 1",
    "Song 2",
    "enrique taylor",
    "taylor",
    "enrique",
  ]; // Your actual music list
  List<String> filteredMusicList = []; // List to store filtered music

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    // Initialize filteredMusicList with the entire musicList initially
    filteredMusicList = List.from(musicList);
  }

  // Method to filter music list based on search input
  void filterMusicList(String searchQuery) {
    if (searchQuery.isEmpty) {
      // If search query is empty, show the entire list
      filteredMusicList = List.from(musicList);
    } else {
      // If search query is not empty, filter the list based on the query
      filteredMusicList = musicList
          .where(
              (song) => song.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    update(); // Notify the UI to update the displayed list
  }

  void resetSearch() {
    searchController.clear(); // Clear the search text
    filteredMusicList = List.from(musicList); // Reset the filtered list
    update(); // Notify the UI to update the displayed list
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
    Metadata metadata = await MetadataGod.readMetadata(file: files[index].path);

    log(metadata.title ?? '');

    Uint8List? imageBytes;
    String? mimeType;
    if (metadata.picture != null) {
      imageBytes = metadata.picture!.data;
      mimeType = metadata.picture!.mimeType;
    }

    VibeSong song = VibeSong(
      name: metadata.title ?? '',
      // artists: metadata.artist ?? '',
      songUrl: files[index].path,
      imageUrl: imageBytes != null
          ? 'data:$mimeType;base64,${base64Encode(imageBytes)}'
          : '',
    );

    Get.to(VibeSongScreen(
      song: song,
      musicSource: MusicSource.localDirectory,
    ));
  }
}
