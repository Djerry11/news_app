// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsApiResponse _$NewsApiResponseFromJson(Map<String, dynamic> json) {
  return _NewsApiResponse.fromJson(json);
}

/// @nodoc
mixin _$NewsApiResponse {
  String? get status => throw _privateConstructorUsedError;
  int? get totalResults => throw _privateConstructorUsedError;
  List<Articles>? get articles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsApiResponseCopyWith<NewsApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsApiResponseCopyWith<$Res> {
  factory $NewsApiResponseCopyWith(
          NewsApiResponse value, $Res Function(NewsApiResponse) then) =
      _$NewsApiResponseCopyWithImpl<$Res, NewsApiResponse>;
  @useResult
  $Res call({String? status, int? totalResults, List<Articles>? articles});
}

/// @nodoc
class _$NewsApiResponseCopyWithImpl<$Res, $Val extends NewsApiResponse>
    implements $NewsApiResponseCopyWith<$Res> {
  _$NewsApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      articles: freezed == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Articles>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsApiResponseImplCopyWith<$Res>
    implements $NewsApiResponseCopyWith<$Res> {
  factory _$$NewsApiResponseImplCopyWith(_$NewsApiResponseImpl value,
          $Res Function(_$NewsApiResponseImpl) then) =
      __$$NewsApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, int? totalResults, List<Articles>? articles});
}

/// @nodoc
class __$$NewsApiResponseImplCopyWithImpl<$Res>
    extends _$NewsApiResponseCopyWithImpl<$Res, _$NewsApiResponseImpl>
    implements _$$NewsApiResponseImplCopyWith<$Res> {
  __$$NewsApiResponseImplCopyWithImpl(
      _$NewsApiResponseImpl _value, $Res Function(_$NewsApiResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? totalResults = freezed,
    Object? articles = freezed,
  }) {
    return _then(_$NewsApiResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      articles: freezed == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<Articles>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsApiResponseImpl implements _NewsApiResponse {
  const _$NewsApiResponseImpl(
      {this.status, this.totalResults, final List<Articles>? articles})
      : _articles = articles;

  factory _$NewsApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsApiResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final int? totalResults;
  final List<Articles>? _articles;
  @override
  List<Articles>? get articles {
    final value = _articles;
    if (value == null) return null;
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NewsApiResponse(status: $status, totalResults: $totalResults, articles: $articles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsApiResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            const DeepCollectionEquality().equals(other._articles, _articles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, totalResults,
      const DeepCollectionEquality().hash(_articles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsApiResponseImplCopyWith<_$NewsApiResponseImpl> get copyWith =>
      __$$NewsApiResponseImplCopyWithImpl<_$NewsApiResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsApiResponseImplToJson(
      this,
    );
  }
}

abstract class _NewsApiResponse implements NewsApiResponse {
  const factory _NewsApiResponse(
      {final String? status,
      final int? totalResults,
      final List<Articles>? articles}) = _$NewsApiResponseImpl;

  factory _NewsApiResponse.fromJson(Map<String, dynamic> json) =
      _$NewsApiResponseImpl.fromJson;

  @override
  String? get status;
  @override
  int? get totalResults;
  @override
  List<Articles>? get articles;
  @override
  @JsonKey(ignore: true)
  _$$NewsApiResponseImplCopyWith<_$NewsApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
