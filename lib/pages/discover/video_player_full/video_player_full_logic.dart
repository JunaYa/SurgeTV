import 'package:get/get.dart';
import 'package:surgetv/model/discover.dart';
import 'package:video_player/video_player.dart';

import 'video_player_full_state.dart';

class VideoPlayerFullLogic extends GetxController {
  VideoPlayerFullLogic({this.videoData});

  final DiscoverVideo? videoData;

  final VideoPlayerFullState state = VideoPlayerFullState();

  late VideoPlayerController videoController;

  @override
  void onInit() {
    if (videoData == null) {
      return;
    }
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(videoData!.video))
          ..initialize().then((value) {
            videoController.play();
            videoController.setLooping(true);
            state.currentSliderValue = 0.0;
            state.isInitPlaying = true;
            state.videoWidth = videoController.value.size.width;
            state.videoHeight = videoController.value.size.height;
          });
    super.onInit();
  }

  @override
  void onReady() {
    videoController.addListener(videoListener);
    super.onReady();
  }

  void videoListener() {
    state.isBuffering = videoController.value.isBuffering;
    state.currentSliderValue =
        videoController.value.position.inSeconds.toDouble();
  }

  @override
  void onClose() {
    videoController.removeListener(videoListener);
    videoController.dispose();
    super.onClose();
  }

  ///点赞
  Future<void> onLikeClick(DiscoverVideo videoData) async {
    print('=====> 点击了点赞');
  }

  // toggle play pause
  void togglePlayPause() {
    videoController.value.isPlaying
        ? videoController.pause()
        : videoController.play();
  }
}
