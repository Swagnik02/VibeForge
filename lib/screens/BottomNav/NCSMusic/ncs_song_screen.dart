import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ncs_io/ncs_io.dart' as NCSDev;
import 'package:permission_handler/permission_handler.dart' as perms;
import 'package:permission_handler/permission_handler.dart';

import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:vibeforge/services/permission_service.dart';
import 'package:vibeforge/widgets/file_save_helper.dart';
import 'package:vibeforge/widgets/widgets.dart';
import 'package:dio/dio.dart' as DioDev;

class NCSSongScreen extends StatefulWidget {
  const NCSSongScreen({super.key});

  @override
  State<NCSSongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<NCSSongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  NCSDev.Song song = Get.arguments ?? '';

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(song.songUrl ?? ''),
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
            song.imageUrl ?? '',
            fit: BoxFit.cover,
          ),

          // fliter overlay
          const _BackgroundFilter(),

          // music control bar
          _MusicPlayer(
            song: song,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
          ),
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  const _MusicPlayer({
    super.key,
    required this.song,
    required Stream<SeekBarData> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream;

  final NCSDev.Song song;
  final Stream<SeekBarData> _seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            ],
          ),
          const SizedBox(height: 40),

          // seekBar
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
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
          PlayerButtons(audioPlayer: audioPlayer),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () async {
                  if (await requestPermission(Permission.storage) == true) {
                    log(song.songUrl ?? '');
                    _downloadSong(
                        song.songUrl.toString(), song.name.toString());
                  } else {
                    // Handle the case when storage permission is not granted
                    log('Storage permission not granted');
                  }
                },
                icon: const Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _downloadSong(String url, String fileName) async {
    DioDev.Dio dio = DioDev.Dio();

    try {
      DioDev.Response response = await dio.get(
        url,
        options: DioDev.Options(
          responseType: DioDev.ResponseType.bytes,
        ),
      );

      // Save the file to the device
      await FileSaveHelper.saveFile(fileName, response.data);

      // You can display a success message or perform any other action here
    } catch (e) {
      // Handle errors
      print('Error downloading song: $e');
    }
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
