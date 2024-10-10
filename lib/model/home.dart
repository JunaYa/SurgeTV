import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final List<VideoItem> data;

  Category({required this.id, required this.name, required this.data});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class VideoItem {
  final int id;
  final int stageId;
  final String subject;
  final String video;
  final int topFlag;
  final int sort;
  final int dataStatus;
  final String updateTime;
  final String createTime;

  VideoItem({
    required this.id,
    required this.stageId,
    required this.subject,
    required this.video,
    required this.topFlag,
    required this.sort,
    required this.dataStatus,
    required this.updateTime,
    required this.createTime,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) =>
      _$VideoItemFromJson(json);

  Map<String, dynamic> toJson() => _$VideoItemToJson(this);
}
