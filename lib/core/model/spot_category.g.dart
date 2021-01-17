// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotCategory _$SpotCategoryFromJson(Map<String, dynamic> json) {
  return $checkedNew('SpotCategory', json, () {
    final val = SpotCategory();
    $checkedConvert(json, 'id', (v) => val.id = v as int);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(json, 'color', (v) => val.color = v as String);
    $checkedConvert(json, 'icon', (v) => val.icon = v as String);
    $checkedConvert(
        json,
        'tags',
        (v) => val.tags = (v as List)
            ?.map((e) =>
                e == null ? null : SpotTag.fromJson(e as Map<String, dynamic>))
            ?.toList());
    return val;
  });
}

Map<String, dynamic> _$SpotCategoryToJson(SpotCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
      'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
    };
