import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../resources/color_manager.dart';
import '../resources/size_manager.dart';

class MusicPlayer extends StatefulHookConsumerWidget {
  const MusicPlayer({
    Key? key,
    // required this.onPressed,
  }) : super(key: key);

  // final VoidCallback onPressed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends ConsumerState<MusicPlayer> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isFirstTimePlaying = true;
  Duration duration = const Duration(minutes: 5, seconds: 6);
  Duration position = const Duration(seconds: 0);
  late Timer timer;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context, 430),
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 40)),
      child: Column(
        children: [
          ProgressBar(
            progress: position,
            total: duration,
            onSeek: (value) {
              setState(() {
                audioPlayer.seek(value);
                position = value;
              });
            },
            onDragStart: (details) => setState(() => audioPlayer.seek(details.timeStamp)),
            progressBarColor: const Color(0xFF986A50),
            thumbColor: const Color(0xFF986A50),
          ),
          CircleAvatar(
            backgroundColor: const Color(0xFF986A50),
            foregroundColor: ColorManager.kWhite,
            child: IconButton(
              onPressed: () async {
                if (!isPlaying) {
                  setState(() => isPlaying = true);
                  await audioPlayer.play(AssetSource("audios/dragonstone.mp3"));
                } else {
                  setState(() => isPlaying = false);
                  await audioPlayer.pause();
                }
              },
              icon: Icon(!isPlaying ? Icons.play_arrow : Icons.pause),
            ),
          )
        ],
      ),
    );
  }
}
