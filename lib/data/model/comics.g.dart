// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comics _$ComicsFromJson(Map<String, dynamic> json) => Comics(
      id: json['id'] as int?,
      title: json['title'] as String?,
      resourceURI: json['resourceURI'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ComicsToJson(Comics instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'resourceURI': instance.resourceURI,
      'thumbnail': instance.thumbnail?.toJson(),
      'description': instance.description,
    };
