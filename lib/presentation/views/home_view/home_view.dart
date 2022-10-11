import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/size_manager.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: AssetsManager.videosList.length,
      itemBuilder: (context, index) => VideoView(
        path: AssetsManager.videosList[index],
        onScrollStart: (controller) => controller.dispose(),
      ),
    );
  }
}

class VideoView extends StatefulHookConsumerWidget {
  const VideoView({Key? key, required this.path, required this.onScrollStart}) : super(key: key);

  final String path;
  final Function(VideoPlayerController) onScrollStart;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoViewState();
}

class _VideoViewState extends ConsumerState<VideoView> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.network("https://www.youtube.com/watch?v=4pcTUoS3yKQ");
    controller.addListener(() => setState(() {}));
    controller.initialize().then((_) => setState(() {}));
    Future.delayed(const Duration(milliseconds: 600)).then((_) => controller.play());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          if (controller.value.isPlaying) {
            await controller.pause();
          } else {
            await controller.play();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: VideoPlayer(controller),
            ),
            if (!controller.value.isPlaying) Icon(Icons.play_arrow, size: getHeight(context, 70), color: ColorManager.kWhite),
          ],
        ),
      ),
    );
  }
}
