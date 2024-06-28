import 'package:freezed_annotation/freezed_annotation.dart';
import 'articles.dart';

part 'news_api_response.freezed.dart';
part 'news_api_response.g.dart';

@freezed
class NewsApiResponse with _$NewsApiResponse {
  const factory NewsApiResponse({
    String? status,
    int? totalResults,
    List<Articles>? articles,
  }) = _NewsApiResponse;

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsApiResponseFromJson(json);
}
