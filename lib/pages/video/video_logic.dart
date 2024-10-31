import 'package:get/get.dart';
import 'package:surgetv/dao/video_dao.dart';
import 'package:surgetv/model/video_detail.dart';

import 'video_state.dart';

class VideoLogic extends GetxController {
  final VideoState state = VideoState();

  @override
  void onReady() {
    super.onReady();
    loadData(false);
    state.pageController.addListener(onPageScroll);
  }

  @override
  void onClose() {
    state.pageController.removeListener(onPageScroll);
    state.pageController.dispose();
    super.onClose();
  }

  void onPageScroll() {
    final pageIndex = state.pageController.page?.round();
    if (pageIndex != null && pageIndex != state.currentPageIndex) {
      state.currentPageIndex = pageIndex;
      print('=========> currentPageIndex: $state.currentPageIndex');
      if (state.currentPageIndex == state.videoDataList.length - 2) {
        loadData(true);
      }
    }
  }

  /// 视频数据 API请求
  Future<void> loadData(bool isLoadMore) async {
    // 延迟200ms 模拟网络请求
    var res = await VideoDao.getVideoDetail(Get.arguments['videoId']);
    if (res.result) {
      state.videoDataList.clear();
      state.videoDataList.addAll(res.data);
    }
    if (isLoadMore) {
      print('=========> loadData');
      List<VideoData> newVideoDataList = [];
      newVideoDataList.clear();
      newVideoDataList.addAll(state.videoDataList);
      newVideoDataList.addAll(testVideoData);
      state.videoDataList = newVideoDataList;
    } else {
      state.videoDataList = testVideoData;
    }
  }
}

// 视频分集展示
List<VideoData> testVideoData = [
  VideoData(
    id: 1,
    video: "https://www.runoob.com/try/demo_source/movie.mp4",
    albumImg: "http://8.141.13.174/v/x01.png",
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
