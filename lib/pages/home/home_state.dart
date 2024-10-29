import 'package:get/get.dart';

class HomeState {
  late RxList<dynamic> dataList;
  late RxBool isLoading;

  HomeState() {
    ///Initialize variables
    dataList = RxList<dynamic>();
    isLoading = RxBool(true);
  }
}
