import 'dart:developer';

import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/services/db.dart';

class FavourtiesScreenController extends GetxController {
  List<VibeSong> localAssetsFavMusicList = [];
  List<VibeSong> allSongsFavMusicList = [];
  List<VibeSong> ncsFavMusicList = [];

  @override
  void onInit() async {
    super.onInit();
    localAssetsFavMusicList = await AllSongsDatabaseService.instance
        .populateFavLists(MusicSource.localAssets);
    allSongsFavMusicList = await AllSongsDatabaseService.instance
        .populateFavLists(MusicSource.localDirectory);
    ncsFavMusicList = await AllSongsDatabaseService.instance
        .populateFavLists(MusicSource.apiNCS);
    update();
  }

  void logMusicList(List<VibeSong> musicList) {
    for (int i = 0; i < musicList.length; i++) {
      log('Song: ${musicList[i].name}');
      log('Song: ${musicList[i].artists}');
    }
  }
}
