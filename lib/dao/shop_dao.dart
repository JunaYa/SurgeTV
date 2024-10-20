import 'package:dio/dio.dart';
import 'package:surgetv/api/api.dart';
import 'package:surgetv/dao/dao_result.dart';
import 'package:surgetv/model/shop.dart';

class ShopDao {
  static getProductList() async {
    var res = await httpManager.request(
      "http://8.141.13.174/api/v1/fee/productList",
      {},
      null,
      Options(
        method: "post",
      ),
    );

    if (res != null && res.result) {
      ProductList data = ProductList.fromJson(res.data['data']);
      return DataResult(data.productList, true);
    } else {
      return DataResult(null, false);
    }
  }
}
