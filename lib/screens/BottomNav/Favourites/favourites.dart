import 'package:flutter/material.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/screens/BottomNav/Favourites/favourites_controller.dart';
import 'package:vibeforge/vibeComponents/vibe_song_card.dart';
import 'package:vibeforge/widgets/section_header.dart';
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
        _sectionLocalAssets(),
        _sectionAllSongs(),
        _sectionNCS(),
      ],
    );
  }

  Widget _sectionLocalAssets() {
    return Column(
      children: [
        const SectionHeader(title: 'Local'),
        _corousel(controller.localAssetsFavMusicList, MusicSource.localAssets),
      ],
    );
  }

  Widget _sectionAllSongs() {
    return Column(
      children: [
        const SectionHeader(title: 'AllSongs'),
        _corousel(controller.allSongsFavMusicList, MusicSource.localDirectory),
      ],
    );
  }

  Widget _sectionNCS() {
    return Column(
      children: [
        const SectionHeader(title: 'NCS Songs'),
        _corousel(controller.ncsFavMusicList, MusicSource.apiNCS),
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
