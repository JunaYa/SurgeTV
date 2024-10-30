import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebpageState {
  late Rx<String> title;
  late Rx<WebViewController> controller;

  WebpageState() {
    title = Rx<String>('');
    controller = Rx<WebViewController>(WebViewController());
  }
}
