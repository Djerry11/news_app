import 'package:freezed_annotation/freezed_annotation.dart';
part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class Article with _$Article {
  factory Article({
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
