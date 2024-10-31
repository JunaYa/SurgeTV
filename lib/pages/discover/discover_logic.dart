import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/dao/discover_dao.dart';
import 'package:surgetv/model/discover.dart';

import 'discover_state.dart';

class DiscoverLogic extends GetxController {
  final DiscoverState state = DiscoverState();

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: state.currentIndex.value);
    super.onInit();
  }

  @override
  void onReady() {
    loadData(false);
    pageController.addListener(onPageScroll);
    super.onReady();
  }

  @override
  void onClose() {
    pageController.removeListener(onPageScroll);
    pageController.dispose();
    super.onClose();
  }

  void onPageScroll() {
    final pageIndex = pageController.page?.round();
    if (pageIndex != null && pageIndex != state.currentPageIndex.value) {
      state.currentPageIndex.value = pageIndex;
      print('=========> currentPageIndex: $state.currentPageIndex');
      if (state.currentPageIndex.value == state.videoDataList.value.length - 2) {
        loadData(true);
      }
    }
  }

  /// 视频数据 API请求
  Future<void> loadData(bool isLoadMore) async {
    // 延迟200ms 模拟网络请求
    var res = await DiscoverDao.getVideoList();
    if (res.result) {
      state.videoDataList.value = res.data;
    }
    if (isLoadMore) {
      print('=========> loadData');
      RxList<DiscoverVideo> newDiscoverVideoList = <DiscoverVideo>[].obs;
      newDiscoverVideoList.clear();
      newDiscoverVideoList.addAll(state.videoDataList.value);
      state.videoDataList.value = newDiscoverVideoList;
    } else {
      state.videoDataList.value = state.videoDataList.value;
    }
  }
}
