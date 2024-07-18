import 'package:json_annotation/json_annotation.dart';

part 'news_headlines_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsHeadlinesModel {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsHeadlinesModel(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

 factory NewsHeadlinesModel.fromJson(Map<String, dynamic> json) => _$NewsHeadlinesModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsHeadlinesModelToJson(this);
}

@JsonSerializable()
class Source {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
