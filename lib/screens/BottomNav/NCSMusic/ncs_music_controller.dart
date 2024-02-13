import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ncs_io/ncs_io.dart' as NCSDev;

class NCSMusicController extends GetxController {
  bool isSearchBody = false;
  bool isDataFetched = false;
  bool isSearching = false;
  List<NCSDev.Song> songs = [NCSDev.Song(name: 'abc')];
  TextEditingController searchController = TextEditingController();

  var connectivityResult = ConnectivityResult.none.obs;
  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectivityResult.value = result;
    });
  }

  Future<void> checkConnectivity() async {
    var connectivity = await Connectivity().checkConnectivity();
    connectivityResult.value = connectivity;
    update();
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
    FocusScope.of(Get.context!).unfocus();
    if (!isSearchBody) {
      updateIsSearchBody();
    }
    songs.clear();
    updateIsSearching();
    updateIsDataFetched();
    songs.addAll(
        await NCSDev.NCS.searchMusic(search: searchController.text.trim()));
    updateIsSearching();
    updateIsDataFetched();
  }
}
