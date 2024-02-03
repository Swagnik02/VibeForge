import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllSongsController extends GetxController {
  late TextEditingController searchController = TextEditingController();
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
}
