// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsVO _$NewsVOFromJson(Map<String, dynamic> json) {
  return NewsVO(
    json['id'] as int,
    json['title'] as String,
    json['shortDescription'] as String,
    json['url'] as String,
    json['image'] as String,
    json['mobileImage'] as bool? ?? false,
    json['alt'] as String,
    json['date'] as String,
    json['tags'] as String,
    json['external'] as bool? ?? false,
    json['externalTitle'] as String,
    json['externalClass'] as bool? ?? false,
  );
}

Map<String, dynamic> _$NewsVOToJson(NewsVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'shortDescription': instance.shortDescription,
      'url': instance.url,
      'image': instance.image,
      'mobileImage': instance.mobileImage,
      'alt': instance.alt,
      'date': instance.date,
      'tags': instance.tags,
      'external': instance.external,
      'externalTitle': instance.externalTitle,
      'externalClass': instance.externalClass,
    };
