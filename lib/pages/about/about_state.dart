import 'package:package_info_plus/package_info_plus.dart';

import 'package:get/get.dart';

class AboutState {
  late Rx<PackageInfo> packageInfo;

  AboutState() {
    packageInfo = Rx<PackageInfo>(PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
    ));
  }
}
