import 'package:dio/dio.dart';
import 'package:surgetv/api/api.dart';
import 'package:surgetv/dao/dao_result.dart';
import 'package:surgetv/model/discover.dart';

class DiscoverDao {
  static getVideoList() async {
    var res = await httpManager.request(
      "http://8.141.13.174/api/v1/scene/fresh",
      {},
      null,
      Options(
        method: "post",
      ),
    );

    if (res != null && res.result) {
      Discover data = Discover.fromJson(res.data['data']);
      return DataResult(data.list, true);
    } else {
      return DataResult(null, false);
    }
  }
}
