import 'package:flutter/material.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/screens/BottomNav/Favourites/favourite_section_page.dart';
import 'package:vibeforge/screens/BottomNav/Favourites/favourites_controller.dart';
import 'package:vibeforge/screens/BottomNav/Favourites/test.dart';
import 'package:vibeforge/vibeComponents/vibe_song_card.dart';
import 'package:get/get.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});
  final List<VibeSong> songs = VibeSong.songs;
  final FavourtiesScreenController controller =
      Get.put(FavourtiesScreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavourtiesScreenController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: _mainBody(),
          ),
        ),
      ),
    );
  }

  Widget _mainBody() {
    return Column(
      children: [
        _Section(
          sectionName: 'Local Assets',
          icon: Icons.audio_file_sharp,
          musicSource: MusicSource.localAssets,
          musicList: controller.localAssetsFavMusicList,
        ),
        _Section(
          sectionName: 'All Songs',
          icon: Icons.music_note_outlined,
          musicSource: MusicSource.localDirectory,
          musicList: controller.allSongsFavMusicList,
        ),
        _Section(
          sectionName: 'No Copyright Songs',
          icon: LocalAssets.ncsLogo,
          musicSource: MusicSource.apiNCS,
          musicList: controller.ncsFavMusicList,
        ),
        TextButton(onPressed: () => Get.to(LottieLearn()), child: Text('Test')),
      ],
    );
  }

  Widget _corousel(List<VibeSong> songs, String musicSource) {
    return SizedBox(
      height: Get.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return VibeSongCard(
            song: songs[index],
            musicSource: musicSource,
          );
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String musicSource;
  final String sectionName;
  final List<VibeSong> musicList;

  final dynamic icon;

  const _Section({
    this.icon,
    required this.sectionName,
    required this.musicSource,
    required this.musicList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => Get.to(() => FavouriteSectionPage(
              musicSource: musicSource,
              title: sectionName,
              musicList: musicList,
            )),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            // color: Colors.purpleAccent,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.purpleAccent.shade400,
                Colors.purpleAccent.shade100,
                Colors.purpleAccent.shade400,
              ],
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.themeColour),
                  child: Center(
                    child: icon is IconData // Check if the icon is IconData
                        ? Icon(
                            icon,
                            size: 30,
                            color: Colors
                                .purpleAccent, // Adjust the icon color if needed
                          )
                        : Image.asset(
                            icon,
                            width: 30,
                            height: 30,
                            color: Colors
                                .purpleAccent, // Adjust the image color if needed
                          ),
                  ),
                ),
              ),
              Text(
                sectionName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.themeColour,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
