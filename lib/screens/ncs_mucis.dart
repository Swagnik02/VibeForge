import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncs_io/ncs_io.dart' as NCSDev;

class NCSMusic extends StatefulWidget {
  const NCSMusic({super.key});

  @override
  State<NCSMusic> createState() => _NCSMusicState();
}

class _NCSMusicState extends State<NCSMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<NCSDev.Song>?>(
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

                return Container(
                  width: 150,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          song?.imageUrl ?? '',
                        ),
                        onError: (exception, stackTrace) => const Center(
                          child: FlutterLogo(style: FlutterLogoStyle.markOnly),
                        ),
                      )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<NCSDev.Song> songs = [];

  bool isSearching = false;
  bool isDataFetched = false;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
            title: TextField(
          controller: searchController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search sound',
              filled: true,
              suffixIcon: InkWell(
                  onTap: () async {
                    setState(() {
                      isSearching = false;
                      isDataFetched = false;
                    });
                    songs.clear();
                    setState(() => isSearching = true);
                    songs.addAll(await NCSDev.NCS.searchMusic(
                            search: searchController.text.trim()) ??
                        []);
                    setState(() {
                      isDataFetched = true;
                      isSearching = false;
                    });
                  },
                  child: const Icon(Icons.search))),
        )),
        body: Stack(
          children: [
            Visibility(
                visible: !isDataFetched & !isSearching,
                child: const Center(
                  child: Text('Search results appear here'),
                )),
            Visibility(
                visible: !isDataFetched & isSearching,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoActivityIndicator(color: Colors.deepPurple),
                      Text('Searching...'),
                    ],
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: songs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    NCSDev.Song song = songs[index];
                    return InkWell(
                      onTap: () {
                        // Got single instance of music here
                        // You can use this instance, in which you will get song url to play music
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Wrap(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.deepPurple.shade400),
                                      ...List.generate(
                                          song.artists?.length ?? 0,
                                          (index) => Container(
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepPurple.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(
                                                    right: 3),
                                                child: Text(
                                                    song.artists?[index].name ??
                                                        ''),
                                              ))
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Icon(Icons.tag,
                                          color: Colors.green.shade400),
                                      ...List.generate(
                                          song.tags?.length ?? 0,
                                          (index) => Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(
                                                    right: 3),
                                                child: Text(
                                                    song.tags?[index].name ??
                                                        ''),
                                              ))
                                    ],
                                  ),
                                  Text(song.genre ?? '',
                                      style:
                                          const TextStyle(color: Colors.grey))
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
        ),
      ),
    );
  }
}
