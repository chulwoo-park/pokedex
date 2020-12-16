import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/news/entity.dart';

part 'model.g.dart';

@JsonSerializable()
class NewsVO {
  const NewsVO(
    this.id,
    this.title,
    this.shortDescription,
    this.url,
    this.image,
    // ignore: avoid_positional_boolean_parameters
    this.mobileImage,
    this.alt,
    this.date,
    this.tags,
    this.external,
    this.externalTitle,
    this.externalClass,
  );

  final int id;
  final String title;
  final String shortDescription;
  final String url;
  final String image;
  @JsonKey(defaultValue: false)
  final bool mobileImage;
  final String alt;
  final String date; // format: "December 09, 2020"
  final String tags;
  @JsonKey(defaultValue: false)
  final bool external;
  final String externalTitle;
  @JsonKey(defaultValue: false)
  final bool externalClass;

  factory NewsVO.fromJson(Map<String, dynamic> json) => _$NewsVOFromJson(json);

  Map<String, dynamic> toJson() => _$NewsVOToJson(this);

  News toEntity() {
    var createdAt;
    try {
      createdAt = DateFormat('MMM dd, yyyy').parse(date);
    } on Exception {}

    return News(
      id: id,
      title: title,
      thumbnailUrl: image,
      summary: shortDescription,
      createdAt: createdAt,
    );
  }
}
