import 'package:dio/dio.dart';

/// Response 拦截器
/// Created by Arjun
/// on 2024/9/30.
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response response, handler) async {
    return handler.next(response);
  }
}
