import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ncs_io/ncs_io.dart' as NCSDev;

class NCSMusicController extends GetxController {
  bool isSearchBody = false;
  bool isDataFetched = false;
  bool isSearching = false;
  List<NCSDev.Song> songs = [NCSDev.Song(name: 'abc')];

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void updateIsSearchBody() {
    isSearchBody = !isSearchBody;
    update();
  }

  void updateIsSearching() {
    isSearching = !isSearching;
    update();
  }

  void updateIsDataFetched() {
    isDataFetched = !isDataFetched;
    update();
  }

  void backToAllSongs() {
    updateIsSearchBody();
    songs.clear();
    searchController.clear();
  }

  // search song
  void searchSong() async {
    if (!isSearchBody) {
      updateIsSearchBody();
    }
    songs.clear();
    updateIsSearching();
    updateIsDataFetched();
    update();
    songs.addAll(
        await NCSDev.NCS.searchMusic(search: searchController.text.trim()) ??
            []);
    updateIsSearching();
    updateIsDataFetched();
  }
}
