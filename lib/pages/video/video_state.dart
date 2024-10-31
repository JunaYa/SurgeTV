import 'package:flutter/material.dart';
import 'package:surgetv/model/video_detail.dart';

class VideoState {
  late PageController pageController;
  late int currentPageIndex; //当前播放索引
  late int currentIndex; //当前播放索引
  late List<VideoData> videoDataList; //视频数据列表

  VideoState() {
    currentPageIndex = 0;
    currentIndex = 0;
    videoDataList = [];
    pageController = PageController(initialPage: currentIndex);
  }
}
