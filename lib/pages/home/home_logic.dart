import 'package:get/get.dart';
import 'package:surgetv/dao/home_dao.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<void> _fetchData() async {
    var res = await HomeDao.home();
    if (res.result) {
      state.dataList.addAll(res.data);
      state.isLoading.value = false;
    }
  }
}
