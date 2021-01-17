// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotTag _$SpotTagFromJson(Map<String, dynamic> json) {
  return $checkedNew('SpotTag', json, () {
    final val = SpotTag();
    $checkedConvert(json, 'id', (v) => val.id = v as int);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    return val;
  });
}

Map<String, dynamic> _$SpotTagToJson(SpotTag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
