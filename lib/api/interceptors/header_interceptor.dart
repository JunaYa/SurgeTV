import 'package:dio/dio.dart';

/// Header 拦截器
/// Created by Arjun
/// Date: 2024/9/30
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, handler) async {
    /// 超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    return super.onRequest(options, handler);
  }
}
