import 'package:json_annotation/json_annotation.dart';

part 'discover.g.dart';

@JsonSerializable()
class Discover {
  final List<DiscoverVideo> list;

  Discover({required this.list});

  factory Discover.fromJson(Map<String, dynamic> json) =>
      _$DiscoverFromJson(json);
  Map<String, dynamic> toJson() => _$DiscoverToJson(this);
}

@JsonSerializable()
class DiscoverVideo {
  final int id;
  final String? code;
  final int stageId;
  final String subject;
  final String img;
  final String video;
  final int topFlag;
  final int feeType;
  final int price;
  final String? memo;
  final int sort;
  final String? userId;
  final int dataStatus;
  final String updateTime;
  final String createTime;
  final String stageMemo;
  final String stageImg;
  final String nickName;
  final String? userImg;
  final int focusFlag;
  final int pubUserId;
  // final String likes; //视频点赞数
  // final String likeStatus; //0未点赞 1 已点赞

  DiscoverVideo({
    required this.id,
    required this.code,
    required this.stageId,
    required this.subject,
    required this.img,
    required this.video,
    required this.topFlag,
    required this.feeType,
    required this.price,
    required this.memo,
    required this.sort,
    required this.userId,
    required this.dataStatus,
    required this.updateTime,
    required this.createTime,
    required this.stageMemo,
    required this.stageImg,
    required this.nickName,
    required this.userImg,
    required this.focusFlag,
    required this.pubUserId,
    // required this.likes,
    // required this.likeStatus,
  });

  factory DiscoverVideo.fromJson(Map<String, dynamic> json) =>
      _$DiscoverVideoFromJson(json);
  Map<String, dynamic> toJson() => _$DiscoverVideoToJson(this);
}
