import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:surgetv/pages/discover/video_player_full/video_player_full_view.dart';

import 'discover_logic.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<DiscoverLogic>();
    final state = Bind.find<DiscoverLogic>().state;
    final i18n = AppLocalizations.of(context)!;
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false, //很重要,不加键盘弹出视频会被挤压
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.videoDataList.value.length,
              controller: logic.pageController,
              onPageChanged: (currentPage) {
                //页面发生改变的回调
              },
              itemBuilder: (context, index) {
                return VideoPlayerFullPage(
                  size: size,
                  videoData: state.videoDataList.value[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
