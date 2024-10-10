import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:surgetv/api/code.dart';
import 'package:surgetv/api/result_data.dart';

/// Response 拦截器
/// Created by Arjun
/// on 2024/9/30.
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response response, handler) async {
    RequestOptions option = response.requestOptions;
    dynamic value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString() + option.path);
      }
      value = ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    response.data = value;
    return handler.next(response);
  }
}
