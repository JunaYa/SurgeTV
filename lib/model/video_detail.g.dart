// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetail _$VideoDetailFromJson(Map<String, dynamic> json) => VideoDetail(
      stage: Stage.fromJson(json['stage'] as Map<String, dynamic>),
      itemList: (json['itemList'] as List<dynamic>)
          .map((e) => VideoData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoDetailToJson(VideoDetail instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'itemList': instance.itemList,
    };

Stage _$StageFromJson(Map<String, dynamic> json) => Stage(
      dataStatus: (json['dataStatus'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      img: json['img'] as String?,
      memo: json['memo'] as String?,
      name: json['name'] as String,
      sort: (json['sort'] as num).toInt(),
      topFlag: (json['topFlag'] as num).toInt(),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$StageToJson(Stage instance) => <String, dynamic>{
      'dataStatus': instance.dataStatus,
      'id': instance.id,
      'img': instance.img,
      'memo': instance.memo,
      'name': instance.name,
      'sort': instance.sort,
      'topFlag': instance.topFlag,
      'userId': instance.userId,
    };

VideoData _$VideoDataFromJson(Map<String, dynamic> json) => VideoData(
      buyFlag: (json['buyFlag'] as num).toInt(),
      code: json['code'] as String?,
      createTime: json['createTime'] as String,
      dataStatus: (json['dataStatus'] as num).toInt(),
      feeType: (json['feeType'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      img: json['img'] as String?,
      memo: json['memo'] as String?,
      price: (json['price'] as num).toInt(),
      sort: (json['sort'] as num).toInt(),
      stageId: (json['stageId'] as num).toInt(),
      subject: json['subject'] as String,
      topFlag: (json['topFlag'] as num).toInt(),
      updateTime: json['updateTime'] as String,
      userId: json['userId'] as String?,
      video: json['video'] as String,
      vipFlag: (json['vipFlag'] as num).toInt(),
      albumImg: json['albumImg'] as String,
      likes: json['likes'] as String,
      likeStatus: json['likeStatus'] as String,
    );

Map<String, dynamic> _$VideoDataToJson(VideoData instance) => <String, dynamic>{
      'buyFlag': instance.buyFlag,
      'code': instance.code,
      'createTime': instance.createTime,
      'dataStatus': instance.dataStatus,
      'feeType': instance.feeType,
      'id': instance.id,
      'img': instance.img,
      'memo': instance.memo,
      'price': instance.price,
      'sort': instance.sort,
      'stageId': instance.stageId,
      'subject': instance.subject,
      'topFlag': instance.topFlag,
      'updateTime': instance.updateTime,
      'userId': instance.userId,
      'video': instance.video,
      'vipFlag': instance.vipFlag,
      'albumImg': instance.albumImg,
      'likes': instance.likes,
      'likeStatus': instance.likeStatus,
    };
