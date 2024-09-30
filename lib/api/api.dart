import 'package:dio/dio.dart';
import 'package:surgetv/api/interceptors/error_interceptor.dart';
import 'package:surgetv/api/interceptors/header_interceptor.dart';
import 'package:surgetv/api/interceptors/log_interceptor.dart';
import 'package:surgetv/api/interceptors/response_interceptor.dart';
import 'package:surgetv/api/interceptors/token_interceptor.dart';

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

  Dio get dio => _dio;
}
