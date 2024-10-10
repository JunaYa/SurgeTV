import 'package:dio/dio.dart';
import 'package:surgetv/api/api.dart';
import 'package:surgetv/dao/dao_result.dart';
import 'package:surgetv/model/home.dart';

class HomeDao {
  static home() async {
    var res = await httpManager.request(
      "http://8.141.13.174/api/v1/scene/home",
      null,
      null,
      Options(
        method: "post",
      ),
    );

    if (res != null && res.result) {
      List<Category> categoryList = [];
      for (var item in res.data['data']) {
        Category category = Category.fromJson(item);
        categoryList.add(category);
      }
      return DataResult(categoryList, true);
    } else {
      return DataResult(null, false);
    }
  }
}
