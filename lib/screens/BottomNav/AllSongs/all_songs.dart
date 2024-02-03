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
          )
        ],
      ),
    );
  }

  Widget _buildMusicList() {
    return ListView.builder(
      itemCount: controller.filteredMusicList.length,
      itemBuilder: (BuildContext context, int index) {
        // Replace with your music list item UI
        return ListTile(
          leading: const Icon(
            Icons.music_note,
            color: Colors.white,
          ),
          title: Text(
            controller.filteredMusicList[index],
            style: const TextStyle(color: Colors.white),
          ),
          // Add more details or customize as needed
        );
      },
    );
  }
}
