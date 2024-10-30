import 'package:get/get.dart';
import 'package:surgetv/dao/shop_dao.dart';

import 'shop_state.dart';

class ShopLogic extends GetxController {
  final state = ShopState();

  @override
  void onReady() {
    getProductList();
    super.onReady();
  }

  void getProductList() async {
    state.loading.value = true;
    var res = await ShopDao.getProductList();
    if (res.result) {
      state.productList.value = res.data;
    }
    state.loading.value = false;
  }
}
