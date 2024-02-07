import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:vibeforge/models/song_model.dart';
import 'all_songs_controller.dart';

class AllSongs extends StatelessWidget {
  AllSongs({super.key});

  final AllSongsController controller = Get.put(AllSongsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSongsController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _searchBox(),
            Expanded(
              child: _buildMusicList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    TextEditingController searchController = TextEditingController();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: SearchBarAnimation(
              // searchBoxWidth: Get.width,
              durationInMilliSeconds: 500,
              onPressButton: (isOpen) {
                searchController.clear();
                controller.resetSearch();
              },
              isOriginalAnimation: false,
              buttonBorderColour: Colors.black45,
              onFieldSubmitted: (String value) {
                debugPrint('onFieldSubmitted value $value');
                // You may want to filter the list based on the search value
                controller.filterMusicList(value);
              },
              textEditingController: searchController,
              trailingWidget: const Icon(Icons.music_note_outlined),
              secondaryButtonWidget:
                  const Icon(Icons.arrow_back_ios_new_rounded),
              buttonWidget: const Icon(Icons.search),
            ),
          ),
          const Text(
            'All Songs here',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          IconButton(
            onPressed: controller.addFolder,
            icon: const Icon(
              Icons.add,
              color: Colors.purpleAccent,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMusicList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: controller.musicList.length,
      itemBuilder: (context, index) {
        VibeSong song = controller.musicList[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                MemoryImage(base64Decode(song.imageUrl!.split(',').last)),
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
