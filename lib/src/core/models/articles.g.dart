// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticlesImpl _$$ArticlesImplFromJson(Map<String, dynamic> json) =>
    _$ArticlesImpl(
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$$ArticlesImplToJson(_$ArticlesImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'isBookmarked': instance.isBookmarked,
    };
