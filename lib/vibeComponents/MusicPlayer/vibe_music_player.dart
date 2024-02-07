import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/MusicPlayer/vibe_music_player_controller.dart';
import 'package:vibeforge/vibeComponents/MusicPlayer/vibe_player_buttons.dart';
import 'package:vibeforge/widgets/seek_bar_data.dart';

class VibeMusicPlayer extends StatelessWidget {
  final VibeMusicPlayerController controller =
      Get.put(VibeMusicPlayerController());
  final VibeSong song;
  final Stream<SeekBarData> seekBarDataStream;
  final AudioPlayer audioPlayer;

  VibeMusicPlayer({
    super.key,
    required this.song,
    required this.seekBarDataStream,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VibeMusicPlayerController>(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title and desc
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.name ?? '',
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                // artist names
                Wrap(
                  children: [
                    ...List.generate(
                        song.artists?.length ?? 0,
                        (index) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade600,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: const EdgeInsets.only(right: 3),
                              child: Text(song.artists?[index].name ?? ''),
                            ))
                  ],
                ),
                SizedBox(height: 5),

                Text(song.genre ?? '',
                    style: TextStyle(color: Colors.grey.shade400)),
              ],
            ),
            const SizedBox(height: 40),

            // seekBar
            StreamBuilder<SeekBarData>(
              stream: seekBarDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChanged: audioPlayer.seek,
                );
              },
            ),

            // control buttons
            VibePlayerButtons(audioPlayer: audioPlayer),

            // back and download button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () => Get.back(),
                ),
                IconButton(
                  iconSize: 35,
                  onPressed: () => controller.downloadSong(song),
                  icon: const Icon(
                    Icons.cloud_download,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
