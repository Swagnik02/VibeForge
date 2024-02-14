import 'package:get/get.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';

class FavouriteSectionPageController extends GetxController {
  final String musicSource;
  FavouriteSectionPageController({
    required this.musicSource,
  });

  playAudioFile(VibeSong song) async {
    Get.to(VibeSongScreen(
      song: song,
      musicSource: musicSource,
    ));
  }

  @override
  void onClose() {
    super.onClose();
    dispose();
  }
}
