import 'dart:developer';

import 'package:dio/dio.dart' as DioDev;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/services/db.dart';
import 'package:vibeforge/services/permission_service.dart';
import 'package:vibeforge/widgets/file_save_helper.dart';

class VibeMusicPlayerController extends GetxController
    implements TickerProvider {
  final String musicSource;
  final VibeSong song;
  VibeMusicPlayerController({
    required this.musicSource,
    required this.song,
  });
  final Rx<VibeSong> _currentSong = Rx<VibeSong>(VibeSong());
  final Rx<Duration> _position = Rx<Duration>(Duration.zero);
  final Rx<Duration> _duration = Rx<Duration>(Duration.zero);
  late AnimationController favoriteController;
  VibeSong get currentSong => _currentSong.value;
  Duration get position => _position.value;
  Duration get duration => _duration.value;
  bool isFavourite = false;

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  @override
  void onInit() {
    super.onInit();
    checkIsAddedToFav(song.name ?? '');
    favoriteController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    log(isFavourite.toString());

    update();
  }

  @override
  void onClose() {
    favoriteController.dispose();
    super.onClose();
  }

  void setCurrentSong(VibeSong song) {
    _currentSong.value = song;
  }

  void updatePosition(Duration newPosition) {
    _position.value = newPosition;
  }

  void updateDuration(Duration newDuration) {
    _duration.value = newDuration;
  }

  Future<void> downloadSong(VibeSong song) async {
    if (await requestPermission(Permission.storage) == true) {
      log(song.songUrl ?? '');
      log(song.imageUrl ?? '');
      _downloadSong(song);
    } else {
      // Handle the case when storage permission is not granted
      log('Storage permission not granted');
    }
  }

  Future<void> _downloadSong(VibeSong song) async {
    DioDev.Dio dio = DioDev.Dio();

    String url = song.songUrl ?? '';

    try {
      DioDev.Response response = await dio.get(
        url,
        options: DioDev.Options(
          responseType: DioDev.ResponseType.bytes,
        ),
      );

      // Save the file to the device
      await FileSaveHelper.saveFile(FilePath.ncsDownloads, song, response.data);
    } catch (e) {
      // Handle errors
      log('Error downloading song: $e');
    }
  }

  void checkIsAddedToFav(String songName) async {
    isFavourite =
        await AllSongsDatabaseService.instance.checkIsAddedToFav(songName);
    isFavourite ? favoriteController.forward() : null;
    update();
  }

  void addToFav() async {
    await AllSongsDatabaseService.instance.addToFav(musicSource, song);
    favoriteController.forward();
    checkIsAddedToFav(song.name ?? '');
    update();
  }

  void removeFromFav() async {
    await favoriteController.animateTo(isFavourite ? 1 : 0);
    await AllSongsDatabaseService.instance
        .removeFromFav(musicSource, song.name ?? '');
    favoriteController.reverse();
    await Future.delayed(Duration(seconds: 1));
    checkIsAddedToFav(song.name ?? '');
    update();
  }
}
