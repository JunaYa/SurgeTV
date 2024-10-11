import 'package:flutter/material.dart';
import 'package:surgetv/components/FullScreenVideo.dart';
import 'package:surgetv/dao/video_dao.dart';
import 'package:surgetv/model/home.dart';
import 'package:surgetv/model/video_detail.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key, required this.videoItem});

  final VideoItem videoItem;

  @override
  State createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late PageController _pageController;
  int currentPageIndex = 0; //当前播放索引
  int currentIndex = 0; //当前播放索引
  List<VideoData> videoDataList = []; //视频数据列表

  @override
  void initState() {
    print('video item =====: ${widget.videoItem}');
    loadData(false);
    _pageController = PageController(initialPage: currentIndex);
    _pageController.addListener(_onPageScroll);
    super.initState();
  }

  void _onPageScroll() {
    final pageIndex = _pageController.page?.round();
    if (pageIndex != null && pageIndex != currentPageIndex) {
      currentPageIndex = pageIndex;
      print('=========> currentPageIndex: ${currentPageIndex}');
      if (currentPageIndex == videoDataList.length - 2) {
        loadData(true);
      }
    }
  }

  /// 视频数据 API请求
  Future<void> loadData(bool isLoadMore) async {
    // 延迟200ms 模拟网络请求
    var res = await VideoDao.getVideoDetail(widget.videoItem.id);
    print("------$res");
    if (res.result) {
      setState(() {});
    }
    if (isLoadMore) {
      print('=========> loadData');
      List<VideoData> newVideoDataList = [];
      newVideoDataList.clear();
      newVideoDataList.addAll(videoDataList);
      newVideoDataList.addAll(testVideoData);
      setState(() {
        videoDataList = newVideoDataList;
      });
    } else {
      setState(() {
        videoDataList = testVideoData;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false, //很重要,不加键盘弹出视频会被挤压
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videoDataList.length,
              controller: _pageController,
              onPageChanged: (currentPage) {
                //页面发生改变的回调
              },
              itemBuilder: (context, index) {
                return VideoPlayerFullPage(
                  size: size,
                  videoData: videoDataList[index],
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
                    }),
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

  ///分享
  Future<void> onShareClick(VideoData videoData) async {
    print('=====> 点击了分享');
  }

  Widget _EmptyView() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0x80444444),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.error_outline,
            size: 50,
          ),
          SizedBox(
            height: 70,
          ),
          Text(
            '无数据',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: widget.size.height,
      width: widget.size.width,
      child: widget.videoData == null
          ? _EmptyView()
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
      builder: (_) => PlayListBottomSheet(
        videoData: videoData,
      ),
    );
  }
}

// 视频分集展示
class PlayListBottomSheet extends StatefulWidget {
  final VideoData videoData;

  const PlayListBottomSheet({
    super.key,
    required this.videoData,
  });

  @override
  State<PlayListBottomSheet> createState() => _PlayListBottomSheetState();
}

class _PlayListBottomSheetState extends State<PlayListBottomSheet> {
  VideoData? videoData;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    videoData = widget.videoData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          // 评论列表
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 70),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3, // 分集接口
              itemBuilder: (BuildContext context, int index) {
                return Text("data");
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<VideoData> testVideoData = [
  VideoData(
    id: 1,
    video: "https://www.runoob.com/try/demo_source/movie.mp4",
    albumImg: "https://via.placeholder.com/350x150",
    likes: "100",
    likeStatus: "1",
    buyFlag: 1,
    vipFlag: 1,
    code: "1",
    createTime: "2021-09-01 12:00:00",
    dataStatus: 1,
    feeType: 1,
    img: "https://via.placeholder.com/350x150",
    memo: "这是一个视频",
    price: 10,
    sort: 1,
    stageId: 1,
    subject: "视频标题",
    topFlag: 1,
    updateTime: "2021-09-01 12:00:00",
  ),
];
