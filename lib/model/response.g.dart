// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseWrapper _$ResponseWrapperFromJson(Map<String, dynamic> json) =>
    ResponseWrapper(
      json['data'],
      (json['code'] as num).toInt(),
      json['message'] as String,
    );

Map<String, dynamic> _$ResponseWrapperToJson(ResponseWrapper instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
