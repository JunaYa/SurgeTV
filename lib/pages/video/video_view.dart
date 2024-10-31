import 'package:flutter/material.dart';
import 'package:surgetv/components/EmptyView.dart';
import 'package:surgetv/components/FullScreenVideo.dart';
import 'package:surgetv/components/PlayListBottomSheet.dart';
import 'package:surgetv/model/video_detail.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import 'video_logic.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final logic = Get.find<VideoLogic>();
    final state = Get.find<VideoLogic>().state;

    return Scaffold(
        resizeToAvoidBottomInset: false, //很重要,不加键盘弹出视频会被挤压
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.videoDataList.length,
              controller: state.pageController,
              onPageChanged: (currentPage) {
                //页面发生改变的回调
              },
              itemBuilder: (context, index) {
                return VideoPlayerFullPage(
                  size: size,
                  videoData: state.videoDataList[index],
                );
              },
            ),
            header(
              context,
            ),
          ],
        ));
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerFullPage extends StatefulWidget {
  final VideoData? videoData;

  const VideoPlayerFullPage({
    super.key,
    required this.size,
    required this.videoData,
  });

  final Size size;

  @override
  State createState() => _VideoPlayerFullPageState();
}

class _VideoPlayerFullPageState extends State<VideoPlayerFullPage> {
  late VideoPlayerController videoController;
  bool isInitPlaying = false;
  bool isBuffering = false;
  double videoWidth = 0;
  double videoHeight = 0;
  double _currentSliderValue = 0.0;

  @override
  void initState() {
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoData!.video))
          ..initialize().then((value) {
            videoController.play();
            videoController.setLooping(true);
            setState(() {
              _currentSliderValue = 0.0;
              isInitPlaying = true;
              videoWidth = videoController.value.size.width;
              videoHeight = videoController.value.size.height;
            });
          });
    videoController.addListener(videoListener);
    super.initState();
  }

  void videoListener() {
    setState(() {
      isBuffering = videoController.value.isBuffering;
      _currentSliderValue = videoController.value.position.inSeconds.toDouble();
    });
  }

  @override
  void dispose() {
    videoController.removeListener(videoListener);
    videoController.dispose();
    super.dispose();
  }

  ///点赞
  Future<void> onLikeClick(VideoData videoData) async {
    print('=====> 点击了点赞');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: widget.size.height,
      width: widget.size.width,
      child: widget.videoData == null
          ? const EmptyView()
          : GestureDetector(
              onTap: () {
                print('============>视频点击 ');
              },
              child: Container(
                height: widget.size.height,
                width: widget.size.width,
                decoration: const BoxDecoration(color: Colors.black),
                child: Stack(
                  children: <Widget>[
                    videoWidth > videoHeight
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: videoController.value.aspectRatio,
                              child: VideoPlayer(videoController),
                            ),
                          )
                        : AspectRatio(
                            aspectRatio: videoController.value.aspectRatio,
                            child: VideoPlayer(videoController),
                          ),
                    Center(
                      child: !videoController.value.isPlaying && !isInitPlaying
                          ? Image.network(
                              widget.videoData!.albumImg,
                              width: widget.size.width,
                              height: widget.size.height,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                    rightPanel(
                      context,
                      widget.size,
                      widget.videoData!,
                    ),
                    // buffering loading
                    isBuffering || !videoController.value.isInitialized
                        ? const Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                color: Color(0xFF69DCE5),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _buttonTogglePlay(),
                              SizedBox(
                                height: 10,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 3, // 轨道高度
                                    trackShape:
                                        const RoundedRectSliderTrackShape(), // 轨道形状，可以自定义
                                    activeTrackColor:
                                        const Color(0xFF444444), // 激活的轨道颜色
                                    inactiveTrackColor:
                                        const Color(0x80444444), // 未激活的轨道颜色
                                    thumbColor: const Color(0xFF999999), // 滑块颜色
                                    thumbShape: const RoundSliderThumbShape(
                                        //  滑块形状，可以自定义
                                        enabledThumbRadius: 4 // 滑块大小
                                        ),
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 10, // 设置滑块的覆盖层半径
                                    ),
                                  ),
                                  child: Slider(
                                    value: _currentSliderValue,
                                    min: 0.0,
                                    max: videoController
                                        .value.duration.inSeconds
                                        .toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        _currentSliderValue = value;
                                        videoController.seekTo(
                                            Duration(seconds: value.toInt()));
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buttonTogglePlay() {
    if (videoController.value.isInitialized) {
      return GestureDetector(
        onTap: () => {
          setState(() {
            videoController.value.isPlaying
                ? videoController.pause()
                : videoController.play();
          })
        },
        child: videoController.value.isPlaying
            ? Image.asset(
                'assets/icons/icon_btn_pause.png',
                width: 48,
                height: 48,
              )
            : Image.asset(
                'assets/icons/icon_btn_play.png',
                width: 48,
                height: 48,
              ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget rightPanel(BuildContext context, Size size, VideoData videoData) {
    return Positioned(
      right: 16,
      bottom: 0,
      child: SizedBox(
        height: size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.4,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getLike(videoData, 25.0),
                getVideoList(videoData, 25.0),
                const SizedBox(
                  height: 60,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget getLike(VideoData videoData, double size) {
    return GestureDetector(
      onTap: () {
        onLikeClick(videoData);
      },
      child: Column(
        children: <Widget>[
          videoData.likeStatus == "1"
              ?
              //已点赞
              Image.asset(
                  'assets/icons/icon_like.png',
                  width: size,
                  height: size,
                )
              //未点赞
              : Image.asset(
                  'assets/icons/icon_like.png',
                  width: size,
                  height: size,
                ),
          const SizedBox(
            height: 5,
          ),
          Text(
            videoData.likes,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget toggleFullScreen() {
    return videoWidth > videoHeight
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FullScreenVideoPage(videoController: videoController)),
              );
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 500, left: 150),
                child: SizedBox(
                  width: 110,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0x80444444),
                    ),
                    child: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    ),
                  ),
                )))
        : const SizedBox();
  }

  Widget getVideoList(VideoData videoData, double size) {
    return GestureDetector(
      onTap: () {
        print('=====> 点击了视频列表');
        showPlayListBottomSheet(context, videoData);
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/icons/icon_play_list.png',
            width: size,
            height: size,
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }

  void showPlayListBottomSheet(
      BuildContext context, VideoData videoData) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) => const PlayListBottomSheet(
        list: [],
      ),
    );
  }
}
