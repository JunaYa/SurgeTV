import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:surgetv/api/code.dart';
import 'package:surgetv/api/interceptors/error_interceptor.dart';
import 'package:surgetv/api/interceptors/header_interceptor.dart';
import 'package:surgetv/api/interceptors/log_interceptor.dart';
import 'package:surgetv/api/interceptors/response_interceptor.dart';
import 'package:surgetv/api/interceptors/token_interceptor.dart';
import 'package:surgetv/api/result_data.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  final Dio _dio = Dio(); // 使用默认配置

  final TokenInterceptors _tokenInterceptors = TokenInterceptors();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptors());

    _dio.interceptors.add(_tokenInterceptors);

    _dio.interceptors.add(LogsInterceptors());

    _dio.interceptors.add(ErrorInterceptors());

    _dio.interceptors.add(ResponseInterceptors());
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  Future<ResultData?> request(
      url, params, Map<String, dynamic>? header, Options? option,
      {noTip = false}) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "post");
      option.headers = headers;
    }

    resultError(DioException e) {
      Response? errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(
            statusCode: 666, requestOptions: RequestOptions(path: url));
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorResponse!.statusCode = Code.NETWORK_TIMEOUT;
      }
      return ResultData(
        errorResponse!.data,
        errorResponse.statusCode,
        Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
      );
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioException catch (e) {
      return resultError(e);
    }
    if (response.data is DioException) {
      return resultError(response.data);
    }
    return response.data;
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = HttpManager();
