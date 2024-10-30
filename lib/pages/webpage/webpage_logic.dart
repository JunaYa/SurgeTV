import 'package:get/get.dart';

import 'webpage_state.dart';

class WebpageLogic extends GetxController {
  final WebpageState state = WebpageState();

  @override
  void onReady() {
    state.title.value = Get.arguments['title'];
    state.controller.value
        .loadFlutterAsset('assets/www/${Get.arguments['url']}');
    super.onReady();
  }
}
