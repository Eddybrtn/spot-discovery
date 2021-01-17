import 'package:json_annotation/json_annotation.dart';
import 'package:spot_discovery/core/model/spot_category.dart';

part 'spot.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Spot {
  int id;
  String title;
  String trainStation;
  String address;
  double latitude;
  double longitude;
  String imageFullsize;
  String imageThumbnail;
  bool isRecommended;
  bool isClosed;
  SpotCategory mainCategory;
  List<SpotCategory> tagsCategory;

  Spot();

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);

  Map<String, dynamic> toJson() => _$SpotToJson(this);
}
