import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/MusicPlayer/vibe_music_player.dart';
import 'package:vibeforge/widgets/widgets.dart';

class VibeSongScreen extends StatefulWidget {
  const VibeSongScreen({super.key, required this.song});
  final VibeSong song;
  @override
  State<VibeSongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<VibeSongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(widget.song.songUrl ?? ''),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position: position,
          duration: duration ?? Duration.zero,
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // cover image
          Image.network(
            widget.song.imageUrl ?? '',
            fit: BoxFit.cover,
          ),

          // fliter overlay
          const _BackgroundFilter(),

          // music control bar
          VibeMusicPlayer(
            song: widget.song,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(1.0),
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            stops: [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade800,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }
}
