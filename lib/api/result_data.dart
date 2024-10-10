/// response data
/// Created by Arjun
/// on 2024/9/30.

class ResultData {
  // int? code;
  // dynamic data;
  // // string message
  // String message;

  // ResultData(this.data, this.code, this.message);

  dynamic data;
  bool result;
  int? code;
  dynamic headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}
