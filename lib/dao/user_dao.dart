import 'package:dio/dio.dart';
import 'package:surgetv/api/api.dart';
import 'package:surgetv/api/result_data.dart';

class UserDao {
  static Future<String> login() async {
    // use httpManager to request
    // return token
    ResultData? ret = await httpManager.request(
      "http://8.141.13.174/api/v1/user/login",
      {"userName": "testuser"},
      null,
      Options(
        method: "post",
      ),
    );

    return "token";
  }
}
