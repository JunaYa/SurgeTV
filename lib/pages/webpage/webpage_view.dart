import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:get/get.dart';

import 'webpage_logic.dart';

class WebpagePage extends StatelessWidget {
  const WebpagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<WebpageLogic>();
    final state = Get.find<WebpageLogic>().state;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(state.title.value),
        ),
        body: WebViewWidget(
          controller: state.controller.value,
        ),
      ),
    );
  }
}
