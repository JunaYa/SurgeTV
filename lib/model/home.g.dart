// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => VideoItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'data': instance.data,
    };

VideoItem _$VideoItemFromJson(Map<String, dynamic> json) => VideoItem(
      id: (json['id'] as num).toInt(),
      stageId: (json['stageId'] as num).toInt(),
      subject: json['subject'] as String,
      video: json['video'] as String,
      topFlag: (json['topFlag'] as num).toInt(),
      sort: (json['sort'] as num).toInt(),
      dataStatus: (json['dataStatus'] as num).toInt(),
      updateTime: json['updateTime'] as String,
      createTime: json['createTime'] as String,
    );

Map<String, dynamic> _$VideoItemToJson(VideoItem instance) => <String, dynamic>{
      'id': instance.id,
      'stageId': instance.stageId,
      'subject': instance.subject,
      'video': instance.video,
      'topFlag': instance.topFlag,
      'sort': instance.sort,
      'dataStatus': instance.dataStatus,
      'updateTime': instance.updateTime,
      'createTime': instance.createTime,
    };
