// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spot _$SpotFromJson(Map<String, dynamic> json) {
  return $checkedNew('Spot', json, () {
    final val = Spot();
    $checkedConvert(json, 'id', (v) => val.id = v as int);
    $checkedConvert(json, 'title', (v) => val.title = v as String);
    $checkedConvert(
        json, 'train_station', (v) => val.trainStation = v as String);
    $checkedConvert(json, 'address', (v) => val.address = v as String);
    $checkedConvert(
        json, 'latitude', (v) => val.latitude = (v as num)?.toDouble());
    $checkedConvert(
        json, 'longitude', (v) => val.longitude = (v as num)?.toDouble());
    $checkedConvert(
        json, 'image_fullsize', (v) => val.imageFullsize = v as String);
    $checkedConvert(
        json, 'image_thumbnail', (v) => val.imageThumbnail = v as String);
    $checkedConvert(
        json, 'is_recommended', (v) => val.isRecommended = v as bool);
    $checkedConvert(json, 'is_closed', (v) => val.isClosed = v as bool);
    $checkedConvert(
        json,
        'main_category',
        (v) => val.mainCategory = v == null
            ? null
            : SpotCategory.fromJson(v as Map<String, dynamic>));
    $checkedConvert(
        json,
        'tags_category',
        (v) => val.tagsCategory = (v as List)
            ?.map((e) => e == null
                ? null
                : SpotCategory.fromJson(e as Map<String, dynamic>))
            ?.toList());
    $checkedConvert(json, 'description', (v) => val.description = v as String);
    $checkedConvert(
        json,
        'images_collection',
        (v) => val.imagesCollection =
            (v as List)?.map((e) => e as String)?.toList());
    $checkedConvert(
        json, 'comments', (v) => val.commentsMap = v as Map<String, dynamic>);
    return val;
  }, fieldKeyMap: const {
    'trainStation': 'train_station',
    'imageFullsize': 'image_fullsize',
    'imageThumbnail': 'image_thumbnail',
    'isRecommended': 'is_recommended',
    'isClosed': 'is_closed',
    'mainCategory': 'main_category',
    'tagsCategory': 'tags_category',
    'imagesCollection': 'images_collection',
    'commentsMap': 'comments'
  });
}

Map<String, dynamic> _$SpotToJson(Spot instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'train_station': instance.trainStation,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'image_fullsize': instance.imageFullsize,
      'image_thumbnail': instance.imageThumbnail,
      'is_recommended': instance.isRecommended,
      'is_closed': instance.isClosed,
      'main_category': instance.mainCategory?.toJson(),
      'tags_category': instance.tagsCategory?.map((e) => e?.toJson())?.toList(),
      'description': instance.description,
      'images_collection': instance.imagesCollection,
      'comments': instance.commentsMap,
    };
