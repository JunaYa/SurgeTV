import 'package:surgetv/model/discover.dart';
import 'package:get/get.dart';

class DiscoverState {
  late RxInt currentPageIndex; //当前播放索引
  late RxInt currentIndex; //当前播放索引
  late RxList<DiscoverVideo> videoDataList; //视频数据列表

  DiscoverState() {
    // 初始化状态
    currentPageIndex = 0.obs;
    currentIndex = 0.obs;
    videoDataList = <DiscoverVideo>[].obs;
  }
}
