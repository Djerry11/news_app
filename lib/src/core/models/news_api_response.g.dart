// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsApiResponseImpl _$$NewsApiResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NewsApiResponseImpl(
      status: json['status'] as String?,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Articles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NewsApiResponseImplToJson(
        _$NewsApiResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
