import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:vibeforge/models/song_model.dart';
import 'all_songs_controller.dart';

class AllSongs extends StatelessWidget {
  AllSongs({super.key});

  final AllSongsController controller = Get.put(AllSongsController());
  final TextEditingController searchControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.searchController = searchControl;
    return GetBuilder<AllSongsController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _searchBox(context),
            Expanded(
              child: _buildMusicList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBox(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SearchBarAnimation(
              durationInMilliSeconds: 500,
              onPressButton: (isOpen) {
                controller.searchController.clear();
                FocusScope.of(context).unfocus();
                controller.resetSearch();
              },
              isOriginalAnimation: false,
              buttonBorderColour: Colors.black45,
              onFieldSubmitted: (String value) =>
                  controller.filterMusicList(value),
              textEditingController: searchControl,
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
          ),
        ],
      ),
    );
  }

  Widget _buildMusicList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: controller.filteredMusicList.length,
      itemBuilder: (context, index) {
        VibeSong song = controller.filteredMusicList[index];

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
