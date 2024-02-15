import 'package:flutter/material.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/playlist_model.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/vibe_song_card.dart';
import '../../../widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<VibeSong> songs = VibeSong.songs;
    List<Playlist> playlists = Playlist.playlists;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const _DiscoverMusic(),
            _CreatorsChoice(songs: songs),
            _Playlists(playlists: playlists),
            _craftedWithLove(),
            // Lottie.asset(LocalAssets.owl),
          ],
        ),
      ),
    );
  }

  Widget _craftedWithLove() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Music',
            style: TextStyle(fontFamily: Fonts.monoton, fontSize: 50),
          ),
          Text(
            'heals!',
            style: TextStyle(fontFamily: Fonts.monoton, fontSize: 50),
          ),
          Row(
            children: [
              Text('Crafted with',
                  style: TextStyle(fontFamily: Fonts.asul, fontSize: 18)),
              Icon(
                Icons.favorite_rounded,
                color: Colors.red,
                size: 50,
              ),
              Text('for Anusha',
                  style: TextStyle(fontFamily: Fonts.asul, fontSize: 18)),
            ],
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}

class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            'Enjoy your favourite music',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Search Text field
          TextFormField(
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
              prefixIcon: const Icon(
                Icons.search,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreatorsChoice extends StatelessWidget {
  const _CreatorsChoice({
    super.key,
    required this.songs,
  });

  final List<VibeSong> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 20,
        top: 20,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20, bottom: 15),
            child: SectionHeader(title: "Creators Choice"),
          ),

          // corousel
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return VibeSongCard(
                  song: songs[index],
                  musicSource: MusicSource.localAssets,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Playlists extends StatelessWidget {
  const _Playlists({
    super.key,
    required this.playlists,
  });

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SectionHeader(title: 'Playlists'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: playlists.length,
            itemBuilder: ((context, index) {
              return PlayListCard(playlist: playlists[index]);
            }),
          ),
        ],
      ),
    );
  }
}
