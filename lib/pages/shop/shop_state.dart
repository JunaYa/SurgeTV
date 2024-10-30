import 'package:get/get.dart';
import 'package:surgetv/model/shop.dart';

class ShopState {
  late RxInt currentSelect;
  // loading
  late RxBool loading;
  // 商品列表
  late RxList<Product> productList;

  ShopState() {
    currentSelect = 0.obs;
    loading = false.obs;
    productList = <Product>[].obs;
  }
}
