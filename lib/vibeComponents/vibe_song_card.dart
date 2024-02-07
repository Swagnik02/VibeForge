import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/SongScreen/vibe_song_screen.dart';

class VibeSongCard extends StatelessWidget {
  const VibeSongCard({
    super.key,
    required this.song,
    required this.musicSource,
  });

  final VibeSong song;
  final String musicSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () => Get.to(VibeSongScreen(
          song: song,
          musicSource: musicSource,
        )),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // cover image
            musicSource == MusicSource.apiNCS
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        song.imageUrl ?? '',
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                          song.imageUrl ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

            // title and artists
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          song.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          song.artists?.isNotEmpty == true
                              ? song.artists![0].name ?? "Unknown"
                              : "Unknown",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  // play button
                  const Icon(
                    Icons.play_circle,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
            // title
          ],
        ),
      ),
    );
  }
}
