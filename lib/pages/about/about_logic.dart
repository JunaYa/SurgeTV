import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'about_state.dart';

class AboutLogic extends GetxController {
  final AboutState state = AboutState();

  @override
  void onReady() {
    _initPackageInfo();
    super.onReady();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    state.packageInfo = info;
  }
}
