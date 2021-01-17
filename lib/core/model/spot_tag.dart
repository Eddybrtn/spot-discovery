import 'package:json_annotation/json_annotation.dart';

part 'spot_tag.g.dart';

@JsonSerializable(checked: true)
class SpotTag {
  int id;
  String name;

  SpotTag();

  factory SpotTag.fromJson(Map<String, dynamic> json) => _$SpotTagFromJson(json);

  Map<String, dynamic> toJson() => _$SpotTagToJson(this);
}