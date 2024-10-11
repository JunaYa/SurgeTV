import 'package:json_annotation/json_annotation.dart';

part 'video_detail.g.dart';

@JsonSerializable()
class VideoDetail {
  final Stage stage;
  final List<VideoData> itemList;

  VideoDetail({required this.stage, required this.itemList});

  factory VideoDetail.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDetailToJson(this);
}

@JsonSerializable()
class Stage {
  final int dataStatus;
  final int id;
  final String? img;
  final String? memo;
  final String name;
  final int sort;
  final int topFlag;
  final String? userId;

  Stage({
    required this.dataStatus,
    required this.id,
    this.img,
    this.memo,
    required this.name,
    required this.sort,
    required this.topFlag,
    this.userId,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);
}

@JsonSerializable()
class VideoData {
  final int buyFlag;
  final String? code;
  final String createTime;
  final int dataStatus;
  final int feeType;
  final int id;
  final String? img;
  final String? memo;
  final int price;
  final int sort;
  final int stageId;
  final String subject;
  final int topFlag;
  final String updateTime;
  final String? userId;
  final String video;
  final int vipFlag;
  final String albumImg;
  final String likes; //视频点赞数
  final String likeStatus; //0未点赞 1 已点赞

  VideoData({
    required this.buyFlag,
    this.code,
    required this.createTime,
    required this.dataStatus,
    required this.feeType,
    required this.id,
    this.img,
    this.memo,
    required this.price,
    required this.sort,
    required this.stageId,
    required this.subject,
    required this.topFlag,
    required this.updateTime,
    this.userId,
    required this.video,
    required this.vipFlag,
    required this.albumImg,
    required this.likes,
    required this.likeStatus,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => _$VideoDataFromJson(json);
  Map<String, dynamic> toJson() => _$VideoDataToJson(this);
}
