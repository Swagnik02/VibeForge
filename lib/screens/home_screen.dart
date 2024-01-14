import 'package:flutter/material.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepPurple.shade800.withOpacity(0.8),
          Colors.deepPurple.shade200.withOpacity(0.8),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _CustomAppBar(),
        bottomNavigationBar: _CustomNavBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _DiscoverMusic(),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  bottom: 20,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: SectionHeader(title: "Trending Music"),
                    ),

                    // corousel
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          return SongCard(song: songs[index]);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
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

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepPurple.shade800,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_fill_outlined),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage(TestProfile.profilePic),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
