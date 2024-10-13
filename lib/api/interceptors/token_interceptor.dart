import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:surgetv/config/config.dart';
import 'package:surgetv/utils/local_storage.dart';

/// Token 拦截器
/// Created by Arjun
/// on 2024/9/30.
class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  void onRequest(RequestOptions options, handler) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers["token"] = _token;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, handler) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = 'token ${responseJson["token"]}';
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return super.onResponse(response, handler);
  }

  ///清除授权
  clearAuthorization() {
    _token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String? token = await LocalStorage.get(Config.TOKEN_KEY);
    // mock token
    token =
        "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJjM2NkYmEyYy05NTI0LTRlN2MtODk0My1mODEwZWQ4OGFiMmYiLCJpYXQiOjE3MjE4ODYwMDksInVzZXJJZCI6MTEzMn0.w9fiXZa5pl-wbvZLmNgPhKvt1mxzPxpA81sOqAKg9G0";
    // "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJjNWIwMWQ1MC0wZmQ5LTRhYjAtOTI3ZS00NWE3MzIxNGIzY2IiLCJpYXQiOjE3MjMxODU4OTEsInVzZXJJZCI6MTEzNH0.rFjIGXuRK99o-nAR40Epnz4ua9SaaRo23sNmUijonwc";
    _token = token;
    return token;
  }
}
