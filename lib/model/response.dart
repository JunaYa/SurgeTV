/// response data
/// Created by Arjun
/// on 2024/10/8.
library;
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ResponseWrapper {
  int code;
  dynamic data;
  // string message
  String message;

  ResponseWrapper(this.data, this.code, this.message);

  factory ResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$ResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseWrapperToJson(this);
}
