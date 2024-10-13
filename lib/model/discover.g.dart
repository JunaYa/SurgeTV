// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discover _$DiscoverFromJson(Map<String, dynamic> json) => Discover(
      list: (json['list'] as List<dynamic>)
          .map((e) => DiscoverVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscoverToJson(Discover instance) => <String, dynamic>{
      'list': instance.list,
    };

DiscoverVideo _$DiscoverVideoFromJson(Map<String, dynamic> json) =>
    DiscoverVideo(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String?,
      stageId: (json['stageId'] as num).toInt(),
      subject: json['subject'] as String,
      img: json['img'] as String,
      video: json['video'] as String,
      topFlag: (json['topFlag'] as num).toInt(),
      feeType: (json['feeType'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      memo: json['memo'] as String?,
      sort: (json['sort'] as num).toInt(),
      userId: json['userId'] as String?,
      dataStatus: (json['dataStatus'] as num).toInt(),
      updateTime: json['updateTime'] as String,
      createTime: json['createTime'] as String,
      stageMemo: json['stageMemo'] as String,
      stageImg: json['stageImg'] as String,
      nickName: json['nickName'] as String,
      userImg: json['userImg'] as String?,
      focusFlag: (json['focusFlag'] as num).toInt(),
      pubUserId: (json['pubUserId'] as num).toInt(),
    );

Map<String, dynamic> _$DiscoverVideoToJson(DiscoverVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'stageId': instance.stageId,
      'subject': instance.subject,
      'img': instance.img,
      'video': instance.video,
      'topFlag': instance.topFlag,
      'feeType': instance.feeType,
      'price': instance.price,
      'memo': instance.memo,
      'sort': instance.sort,
      'userId': instance.userId,
      'dataStatus': instance.dataStatus,
      'updateTime': instance.updateTime,
      'createTime': instance.createTime,
      'stageMemo': instance.stageMemo,
      'stageImg': instance.stageImg,
      'nickName': instance.nickName,
      'userImg': instance.userImg,
      'focusFlag': instance.focusFlag,
      'pubUserId': instance.pubUserId,
    };
