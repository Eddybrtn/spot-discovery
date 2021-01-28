import 'package:json_annotation/json_annotation.dart';

part 'spot_comment.g.dart';

@JsonSerializable(checked: true, fieldRename: FieldRename.snake)
class SpotComment {
  String comment;
  int createdAt;

  SpotComment();

  factory SpotComment.fromJson(Map<String, dynamic> json) =>
      _$SpotCommentFromJson(json);

  Map<String, dynamic> toJson() => _$SpotCommentToJson(this);
}
