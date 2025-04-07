import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'media_type.dart';

part 'apod.g.dart';

@JsonSerializable()
class Apod extends Equatable {
  final String title;
  final String explanation;
  final DateTime date;
  final String url;

  @JsonKey(name: 'media_type')
  final MediaType mediaType;

  @JsonKey(name: 'thumbnail_url')
  final String? thumbnail;

  const Apod({
    required this.title,
    required this.explanation,
    required this.date,
    required this.url,
    required this.mediaType,
    this.thumbnail,
  });

  factory Apod.fromJson(Map<String, dynamic> json) => _$ApodFromJson(json);

  Map<String, dynamic> toJson() => _$ApodToJson(this);

  @override
  List<Object?> get props => [
        title,
        explanation,
        date,
        url,
        mediaType,
        thumbnail,
      ];
}
