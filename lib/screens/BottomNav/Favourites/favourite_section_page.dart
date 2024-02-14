import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/screens/BottomNav/Favourites/favourite_section_page_controller.dart';

class FavouriteSectionPage extends StatelessWidget {
  final FavouriteSectionPageController controller;
  final String title;
  final String musicSource;
  final List<VibeSong> musicList;

  FavouriteSectionPage({
    super.key,
    required this.musicSource,
    required this.title,
    required this.musicList,
  }) : controller =
            Get.put(FavouriteSectionPageController(musicSource: musicSource));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteSectionPageController>(
      builder: (_) => Container(
        decoration: boxDecor(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(
                color: Colors.purpleAccent.shade400,
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: Get.back,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.purpleAccent.shade400,
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: _mainBody(),
        ),
      ),
    );
  }

  // Background Gradient Colour

  BoxDecoration boxDecor() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorConstants.themeColourShade3,
          ColorConstants.themeColourShade2,
          ColorConstants.themeColourShade1,
        ],
      ),
    );
  }

  Widget _mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildMusicList(),
        )
      ],
    );
  }

  Widget _buildMusicList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: musicList.length,
      itemBuilder: (context, index) {
        VibeSong song = musicList[index];
        ImageProvider? backgroundImage;

        switch (musicSource) {
          case MusicSource.localAssets:
            backgroundImage = AssetImage(song.imageUrl ?? '');
            break;
          case MusicSource.localDirectory:
            backgroundImage =
                MemoryImage(base64Decode(song.imageUrl!.split(',').last));
            break;
          case MusicSource.apiNCS:
            backgroundImage = NetworkImage(song.imageUrl ?? '');
            break;
          default:
            backgroundImage = null;
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: backgroundImage,
          ),
          title: Text(
            song.name ?? '',
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(song.artists!.map((artist) => artist.name).join(', ')),
          subtitleTextStyle: TextStyle(color: Colors.purpleAccent.shade200),
          onTap: () => controller.playAudioFile(song),
        );
      },
    );
  }
}
