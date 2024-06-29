// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsRepositoryHash() => r'8071db5be64a24262766332ff79748181dea2f8d';

/// See also [newsRepository].
@ProviderFor(newsRepository)
final newsRepositoryProvider = AutoDisposeProvider<NewsRepository>.internal(
  newsRepository,
  name: r'newsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NewsRepositoryRef = AutoDisposeProviderRef<NewsRepository>;
String _$fetchNewsHash() => r'29098047fe4c7922f2c1f81b632bbed1561af5eb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider to fetch paginated news data
///
/// Copied from [fetchNews].
@ProviderFor(fetchNews)
const fetchNewsProvider = FetchNewsFamily();

/// Provider to fetch paginated news data
///
/// Copied from [fetchNews].
class FetchNewsFamily extends Family<AsyncValue<NewsApiResponse>> {
  /// Provider to fetch paginated news data
  ///
  /// Copied from [fetchNews].
  const FetchNewsFamily();

  /// Provider to fetch paginated news data
  ///
  /// Copied from [fetchNews].
  FetchNewsProvider call({
    required ({
      String? category,
      int page,
      String query,
      String? sortBy
    }) queryData,
  }) {
    return FetchNewsProvider(
      queryData: queryData,
    );
  }

  @override
  FetchNewsProvider getProviderOverride(
    covariant FetchNewsProvider provider,
  ) {
    return call(
      queryData: provider.queryData,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchNewsProvider';
}

/// Provider to fetch paginated news data
///
/// Copied from [fetchNews].
class FetchNewsProvider extends AutoDisposeFutureProvider<NewsApiResponse> {
  /// Provider to fetch paginated news data
  ///
  /// Copied from [fetchNews].
  FetchNewsProvider({
    required ({
      String? category,
      int page,
      String query,
      String? sortBy
    }) queryData,
  }) : this._internal(
          (ref) => fetchNews(
            ref as FetchNewsRef,
            queryData: queryData,
          ),
          from: fetchNewsProvider,
          name: r'fetchNewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchNewsHash,
          dependencies: FetchNewsFamily._dependencies,
          allTransitiveDependencies: FetchNewsFamily._allTransitiveDependencies,
          queryData: queryData,
        );

  FetchNewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.queryData,
  }) : super.internal();

  final ({String? category, int page, String query, String? sortBy}) queryData;

  @override
  Override overrideWith(
    FutureOr<NewsApiResponse> Function(FetchNewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchNewsProvider._internal(
        (ref) => create(ref as FetchNewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        queryData: queryData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<NewsApiResponse> createElement() {
    return _FetchNewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchNewsProvider && other.queryData == queryData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, queryData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchNewsRef on AutoDisposeFutureProviderRef<NewsApiResponse> {
  /// The parameter `queryData` of this provider.
  ({String? category, int page, String query, String? sortBy}) get queryData;
}

class _FetchNewsProviderElement
    extends AutoDisposeFutureProviderElement<NewsApiResponse>
    with FetchNewsRef {
  _FetchNewsProviderElement(super.provider);

  @override
  ({String? category, int page, String query, String? sortBy}) get queryData =>
      (origin as FetchNewsProvider).queryData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
