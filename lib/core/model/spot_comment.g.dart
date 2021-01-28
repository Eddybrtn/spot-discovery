// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotComment _$SpotCommentFromJson(Map<String, dynamic> json) {
  return $checkedNew('SpotComment', json, () {
    final val = SpotComment();
    $checkedConvert(json, 'comment', (v) => val.comment = v as String);
    $checkedConvert(json, 'created_at', (v) => val.createdAt = v as int);
    return val;
  }, fieldKeyMap: const {'createdAt': 'created_at'});
}

Map<String, dynamic> _$SpotCommentToJson(SpotComment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'created_at': instance.createdAt,
    };
