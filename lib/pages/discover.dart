import 'package:flutter/material.dart';
import 'package:surgetv/components/EmptyView.dart';
import 'package:surgetv/components/PlayListBottomSheet.dart';
import 'package:surgetv/dao/discover_dao.dart';
import 'package:surgetv/model/discover.dart';
import 'package:video_player/video_player.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late PageController _pageController;
  int currentPageIndex = 0; //当前播放索引
  int currentIndex = 0; //当前播放索引
  List<DiscoverVideo> videoDataList = []; //视频数据列表

  @override
  void initState() {
    loadData(false);
    _pageController = PageController(initialPage: currentIndex);
    _pageController.addListener(_onPageScroll);
    super.initState();
  }

  void _onPageScroll() {
    final pageIndex = _pageController.page?.round();
    if (pageIndex != null && pageIndex != currentPageIndex) {
      currentPageIndex = pageIndex;
      print('=========> currentPageIndex: $currentPageIndex');
      if (currentPageIndex == videoDataList.length - 2) {
        loadData(true);
      }
    }
  }

  /// 视频数据 API请求
  Future<void> loadData(bool isLoadMore) async {
    // 延迟200ms 模拟网络请求
    var res = await DiscoverDao.getVideoList();
    if (res.result) {
      setState(() {
        videoDataList = res.data as List<DiscoverVideo>;
      });
    }
    if (isLoadMore) {
      print('=========> loadData');
      List<DiscoverVideo> newDiscoverVideoList = [];
      newDiscoverVideoList.clear();
      newDiscoverVideoList.addAll(videoDataList);
      setState(() {
        videoDataList = newDiscoverVideoList;
      });
    } else {
      setState(() {
        videoDataList = videoDataList;
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
          ],
        ));
  }
}

class VideoPlayerFullPage extends StatefulWidget {
  final DiscoverVideo? videoData;

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
  Future<void> onLikeClick(DiscoverVideo videoData) async {
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
                setState(() {
                  videoController.value.isPlaying
                      ? videoController.pause()
                      : videoController.play();
                });
              },
              child: Container(
                height: widget.size.height,
                width: widget.size.width,
                decoration: const BoxDecoration(color: Colors.black),
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController),
                      ),
                    ),
                    Center(
                      child: !videoController.value.isPlaying && !isInitPlaying
                          ? Image.network(
                              widget.videoData!.img,
                              width: widget.size.width,
                              height: widget.size.height,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 10, bottom: 0, right: 16),
                        child: SafeArea(
                          child: Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                _videoInfo(
                                  widget.videoData!,
                                ),
                                const SizedBox(width: 60),
                                rightPanel(
                                  context,
                                  widget.size,
                                  widget.videoData!,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _progressBar(),
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
                  ],
                ),
              ),
            ),
    );
  }

  // 右侧面板
  Widget rightPanel(BuildContext context, Size size, DiscoverVideo videoData) {
    return SizedBox(
      height: 400,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                getProfile(videoData),
                getLike(videoData, 25.0),
                getVideoList(videoData, 25.0),
                const SizedBox(height: 48),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 用户信息
  Widget getProfile(DiscoverVideo videoData) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(videoData.userImg ?? ""),
                fit: BoxFit.cover)),
      ),
    );
  }

  // 点赞
  Widget getLike(DiscoverVideo videoData, double size) {
    return GestureDetector(
      onTap: () {
        onLikeClick(videoData);
      },
      child: Column(
        children: <Widget>[
          // videoData.likeStatus == "1"
          "1" == "1"
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
          const Text(
            // videoData.likes,
            "111",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  // 选集视频列表
  Widget getVideoList(DiscoverVideo videoData, double size) {
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
          const Text(
            // videoData.likes,
            "选集",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  // 选集视频列表弹窗
  void showPlayListBottomSheet(
      BuildContext context, DiscoverVideo videoData) async {
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

  // 标题和描述
  Widget _videoInfo(DiscoverVideo videoData) {
    return Expanded(
      child: SizedBox(
        height: 400,
        width: widget.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                videoData.memo ?? "无题标题",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              videoData.stageMemo,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/icon_stage_list.png',
                        width: 18,
                        height: 18,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "第1集/共88集",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('=====> 点击了更多');
                  },
                  child: SizedBox(
                    width: 14,
                    child: Image.asset(
                      'assets/icons/icon_arrow_right.png',
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 进度条
  Widget _progressBar() {
    return Positioned(
      bottom: -2.5,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 10,
              width: widget.size.width,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2, // 轨道高度
                  trackShape: const RoundedRectSliderTrackShape(), // 轨道形状，可以自定义
                  activeTrackColor: const Color(0xFF444444), // 激活的轨道颜色
                  inactiveTrackColor: const Color(0x80444444), // 未激活的轨道颜色
                  thumbColor: const Color(0xFF999999), // 滑块颜色
                  thumbShape: const RoundSliderThumbShape(
                      //  滑块形状，可以自定义
                      enabledThumbRadius: 2 // 滑块大小
                      ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 2, // 设置滑块的覆盖层半径
                  ),
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0.0,
                  max: videoController.value.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentSliderValue = value;
                      videoController.seekTo(Duration(seconds: value.toInt()));
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
