import 'package:get/get.dart';

class VersionCheckState {
  late RxString currentVersion;
  late RxString storeVersion;
  late RxString releaseNotes;

  VersionCheckState() {
    currentVersion = ''.obs;
    storeVersion = ''.obs;
    releaseNotes = ''.obs;
  }
}
