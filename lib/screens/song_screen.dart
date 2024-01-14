import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/widgets/seek_bar_data.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    Song song = Song.songs[0];

    @override
    void initState() {
      super.initState();
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse('asset:///${song.url}'),
        ),
      );
    }

    @override
    void dispose() {
      audioPlayer.dispose();
      super.dispose();
    }
    // Stream <SeekBarData> get _seekBarDataSream =>

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // cover image
          Image.asset(
            song.coverUrl,
            fit: BoxFit.cover,
          ),

          // fliter overlay
          _BackgroundFilter()
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
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
      ),
    );
  }
}
