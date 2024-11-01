import 'package:surgetv/model/discover.dart';

class VideoPlayerFullState {
  late bool isInitPlaying;
  late bool isBuffering;
  late double videoWidth;
  late double videoHeight;
  late double currentSliderValue;
  late DiscoverVideo? videoData;

  VideoPlayerFullState() {
    isInitPlaying = false;
    isBuffering = false;
    videoWidth = 0;
    videoHeight = 0;
    currentSliderValue = 0.0;
    videoData = null;
  }
}
