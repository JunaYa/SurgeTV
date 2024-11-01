import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/components/EmptyView.dart';
import 'package:surgetv/components/PlayListBottomSheet.dart';
import 'package:surgetv/model/discover.dart';
import 'package:video_player/video_player.dart';

import 'video_player_full_logic.dart';

class VideoPlayerFullPage extends StatelessWidget {
  const VideoPlayerFullPage({super.key, required this.size, this.videoData});

  final Size size;
  final DiscoverVideo? videoData;

  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<VideoPlayerFullLogic>();
    final state = Bind.find<VideoPlayerFullLogic>().state;

    state.videoData = videoData;
    
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
          logic.onLikeClick(videoData);
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
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            )
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
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      );
    }

    // 标题和描述
    Widget _videoInfo(DiscoverVideo videoData) {
      return Expanded(
        child: SizedBox(
          height: 400,
          width: size.width,
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
                width: size.width,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2, // 轨道高度
                    trackShape:
                        const RoundedRectSliderTrackShape(), // 轨道形状，可以自定义
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
                    value: state.currentSliderValue,
                    min: 0.0,
                    max: logic.videoController.value.duration.inSeconds
                        .toDouble(),
                    onChanged: (value) {
                      state.currentSliderValue = value;
                      logic.videoController
                          .seekTo(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 右侧面板
    Widget rightPanel(
        BuildContext context, Size size, DiscoverVideo videoData) {
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

    return Container(
      color: Colors.grey,
      height: size.height,
      width: size.width,
      child: videoData == null
          ? const EmptyView()
          : GestureDetector(
              onTap: () {
                print('============>视频点击 ');
                logic.togglePlayPause();
              },
              child: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(color: Colors.black),
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: logic.videoController.value.aspectRatio,
                        child: VideoPlayer(logic.videoController),
                      ),
                    ),
                    Center(
                      child: !logic.videoController.value.isPlaying &&
                              !state.isInitPlaying
                          ? Image.network(
                              videoData!.img,
                              width: size.width,
                              height: size.height,
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
                                  videoData!,
                                ),
                                const SizedBox(width: 60),
                                rightPanel(
                                  context,
                                  size,
                                  videoData!,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _progressBar(),
                    // buffering loading
                    state.isBuffering ||
                            !logic.videoController.value.isInitialized
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
}
