import 'package:json_annotation/json_annotation.dart';
import 'package:marvel_app/data/model/thumbnail.dart';

part 'comics.g.dart';

@JsonSerializable(explicitToJson: true)
class Comics {
  int? id;
  String? title;
  String? resourceURI;
  Thumbnail? thumbnail;
  String? description;

  Comics({this.id, this.title, this.resourceURI, this.thumbnail, this.description});

  factory Comics.fromJson(Map<String, dynamic> json) =>
      _$ComicsFromJson(json);

  Map<String, dynamic> toJson() => _$ComicsToJson(this);
}
