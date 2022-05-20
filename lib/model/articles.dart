import 'package:news_update_3_0_0_app/model/source.dart';

class Article {
  Source source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJason(json['source']),
      author: json['author'] == null ? " " : json['author'] as String,
      title: json['title'] == null ? " " : json['title'] as String,
      description:
          json['description'] == null ? " " : json['description'] as String,
      url: json['url'] == null ? " " : json['url'] as String,
      urlToImage:
          json['urlToImage'] == null ? " " : json['urlToImage'] as String,
      publishedAt:
          json['publishedAt'] == null ? " " : json['publishedAt'] as String,
      content: json['content'] == null ? " " : json['content'] as String,
    );
  }
}
