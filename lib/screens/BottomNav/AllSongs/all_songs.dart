import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:searchbar_animation/searchbar_animation.dart';
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
      itemCount: controller.files.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.music_note,
            color: Colors.white,
          ),
          title: Text(
            controller.files[index].uri.pathSegments.last,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () => controller.playAudioFile(index),
        );
      },
    );
  }
}
