import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState =
                  (playerState! as PlayerState).processingState;
              // if (processingState == ProcessingState.loading ||
              //     processingState == ProcessingState.buffering) {
              //   return Container(
              //     width: 64.0,
              //     height: 64.0,
              //     margin: const EdgeInsets.all(10),
              //     child: const CircularProgressIndicator(),
              //   );
              // } else
              if (!audioPlayer.playing) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  iconSize: 75,
                  color: Colors.white,
                  icon: Icon(Icons.play_circle),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: audioPlayer.pause,
                  iconSize: 75,
                  color: Colors.white,
                  icon: Icon(Icons.pause_circle),
                );
              } else {
                return IconButton(
                  onPressed: () => audioPlayer.seek(Duration.zero,
                      index: audioPlayer.effectiveIndices!.first),
                  iconSize: 75,
                  color: Colors.white,
                  icon: Icon(Icons.replay_circle_filled_outlined),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}
