import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ncs_io/ncs_io.dart' as NCSDev;
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/screens/BottomNav/NCSMusic/ncs_music_controller.dart';
import 'package:vibeforge/widgets/song_card.dart';

class NCSMusic extends StatelessWidget {
  NCSMusic({super.key});

  final NCSMusicController controller = Get.put(NCSMusicController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NCSMusicController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // Search Text field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _searchBox(controller: controller),
            ),
            controller.isSearchBody
                ? _searchBody(controller: controller)
                : Expanded(child: _futureNCS()),
          ],
        ),
      ),
    );
  }

  // all ncs songs
  FutureBuilder<List<NCSDev.Song>?> _futureNCS() {
    return FutureBuilder<List<NCSDev.Song>?>(
      future: NCSDev.NCS.getMusic(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200),
            shrinkWrap: true,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              NCSDev.Song? song = snapshot.data?[index];
              Song ncsSong = Song(
                title: song!.name.toString(),
                description: song.artists.toString(),
                url: song.songUrl.toString(),
                coverUrl: song.imageUrl.toString(),
              );
              return SongCardNCS(song: song);
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(LocalAssets.loadingAnim),
          );
        }
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }
}

class _searchBox extends StatelessWidget {
  final NCSMusicController controller;
  _searchBox({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.searchController,
      style: const TextStyle(
        color: Colors.deepPurple,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey.shade400),
        suffixIcon: InkWell(
            onTap: () => controller.searchSong(),
            child: const Icon(
              Icons.search,
              size: 35,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _searchBody extends StatelessWidget {
  final NCSMusicController controller;

  const _searchBody({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Visibility(
        //     visible: !controller.isDataFetched & !controller.isSearching,
        //     child: const Center(
        //       child: Text('Search results appear here'),
        //     )),
        Visibility(
          visible: !controller.isDataFetched & controller.isSearching,
          child: Center(
            child: Lottie.asset(LocalAssets.loadingAnim),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount: controller.songs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NCSDev.Song song = controller.songs[index];

                return InkWell(
                  onTap: () {
                    Get.toNamed('/NCSsong', arguments: song);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(song.imageUrl ?? '',
                                width: 60, height: 60)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(song.name ?? '',
                                  style: Theme.of(context).textTheme.bodyText1),

                              // artist names
                              Wrap(
                                children: [
                                  Icon(Icons.person,
                                      color: Colors.deepPurple.shade400),
                                  ...List.generate(
                                      song.artists?.length ?? 0,
                                      (index) => Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade600,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.all(3),
                                            margin:
                                                const EdgeInsets.only(right: 3),
                                            child: Text(
                                                song.artists?[index].name ??
                                                    ''),
                                          ))
                                ],
                              ),

                              // genres
                              Wrap(
                                children: [
                                  Icon(Icons.tag, color: Colors.black),
                                  ...List.generate(
                                      song.tags?.length ?? 0,
                                      (index) => Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade600,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.all(3),
                                            margin:
                                                const EdgeInsets.only(right: 3),
                                            child: Text(
                                                song.tags?[index].name ?? ''),
                                          ))
                                ],
                              ),
                              Text(song.genre ?? '',
                                  style: const TextStyle(color: Colors.grey))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 10, color: Colors.transparent),
            )),
      ],
    );
  }
}
