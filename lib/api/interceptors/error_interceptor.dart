import 'package:dio/dio.dart';

/// Error 拦截器
/// Created by Arjun
/// on 2024/9/30.
class ErrorInterceptors extends InterceptorsWrapper {
  @override
  Future onError(DioException err, handler) async {
    return handler.next(err);
  }
}
