import 'package:package_info_plus/package_info_plus.dart';

class AboutState {
  late PackageInfo packageInfo;

  AboutState() {
    packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
    );
  }
}
