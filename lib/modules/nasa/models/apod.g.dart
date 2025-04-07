// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apod _$ApodFromJson(Map<String, dynamic> json) => Apod(
      title: json['title'] as String,
      explanation: json['explanation'] as String,
      date: DateTime.parse(json['date'] as String),
      url: json['url'] as String,
      mediaType: $enumDecode(_$MediaTypeEnumMap, json['media_type']),
      thumbnail: json['thumbnail_url'] as String?,
    );

Map<String, dynamic> _$ApodToJson(Apod instance) => <String, dynamic>{
      'title': instance.title,
      'explanation': instance.explanation,
      'date': instance.date.toIso8601String(),
      'url': instance.url,
      'media_type': _$MediaTypeEnumMap[instance.mediaType]!,
      'thumbnail_url': instance.thumbnail,
    };

const _$MediaTypeEnumMap = {
  MediaType.image: 'image',
  MediaType.video: 'video',
};
