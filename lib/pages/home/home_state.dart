import 'package:get/get.dart';
import 'package:surgetv/model/home.dart';

class HomeState {
  late RxList<Category> dataList;
  late RxBool isLoading;

  HomeState() {
    ///Initialize variables
    dataList = <Category>[].obs;
    isLoading = true.obs;
  }
}
