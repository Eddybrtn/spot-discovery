import 'package:json_annotation/json_annotation.dart';
import 'package:spot_discovery/core/model/spot_tag.dart';

part 'spot_category.g.dart';

@JsonSerializable(checked: true, explicitToJson: true)
class SpotCategory {
  int id;
  String name;
  String color;
  String icon;
  List<SpotTag> tags;

  SpotCategory();

  factory SpotCategory.fromJson(Map<String, dynamic> json) => _$SpotCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SpotCategoryToJson(this);
}
