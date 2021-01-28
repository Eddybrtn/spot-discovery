import 'package:json_annotation/json_annotation.dart';
import 'package:spot_discovery/core/model/spot_category.dart';
import 'package:spot_discovery/core/model/spot_comment.dart';

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
  String description;
  List<String> imagesCollection;
  @JsonKey(name: "comments")
  Map<String, dynamic> commentsMap;
  @JsonKey(ignore: true)
  List<SpotComment> _commentList;

  Spot();

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);

  Map<String, dynamic> toJson() => _$SpotToJson(this);

  String mainCategoryName() => mainCategory?.name ?? tagsCategory[0].name;

  List<SpotComment> get comments => _commentList ?? parseComments();

  List<SpotComment> parseComments() {
    _commentList = List();
    commentsMap?.forEach((key, value) {
      _commentList.add(SpotComment.fromJson(value));
    });
    _commentList.sort((SpotComment a, SpotComment b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return _commentList;
  }
}
