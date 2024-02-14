import 'package:get/get.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/services/db.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';

class FavouriteSectionPageController extends GetxController {
  final String musicSource;
  final List<VibeSong> musicList;
  FavouriteSectionPageController({
    required this.musicSource,
    required this.musicList,
  });

  playAudioFile(VibeSong song) async {
    Get.to(VibeSongScreen(
      song: song,
      musicSource: musicSource,
    ));
  }

  removeFromFav(String songName) async {
    await AllSongsDatabaseService.instance.removeFromFav(musicSource, songName);
    musicList.removeWhere((song) => song.name == songName);
    update();
  }

  @override
  void onClose() {
    super.onClose();
    dispose();
  }
}
