// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsRepositoryHash() => r'1e2b87e90ecfc839b5bb95cbb9f9b84401c086e9';

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
String _$fetchNewsHash() => r'1f4e8ca1df06751efac570c26705943ff3b2322c';

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

/// Provider to fetch news articles, either top headlines or search results, with pagination.
///
/// Copied from [fetchNews].
@ProviderFor(fetchNews)
const fetchNewsProvider = FetchNewsFamily();

/// Provider to fetch news articles, either top headlines or search results, with pagination.
///
/// Copied from [fetchNews].
class FetchNewsFamily extends Family<AsyncValue<List<Articles>>> {
  /// Provider to fetch news articles, either top headlines or search results, with pagination.
  ///
  /// Copied from [fetchNews].
  const FetchNewsFamily();

  /// Provider to fetch news articles, either top headlines or search results, with pagination.
  ///
  /// Copied from [fetchNews].
  FetchNewsProvider call({
    int page = 1,
    String? sortBy,
    String country = 'us',
    String? category,
    int pageSize = 20,
  }) {
    return FetchNewsProvider(
      page: page,
      sortBy: sortBy,
      country: country,
      category: category,
      pageSize: pageSize,
    );
  }

  @override
  FetchNewsProvider getProviderOverride(
    covariant FetchNewsProvider provider,
  ) {
    return call(
      page: provider.page,
      sortBy: provider.sortBy,
      country: provider.country,
      category: provider.category,
      pageSize: provider.pageSize,
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

/// Provider to fetch news articles, either top headlines or search results, with pagination.
///
/// Copied from [fetchNews].
class FetchNewsProvider extends AutoDisposeFutureProvider<List<Articles>> {
  /// Provider to fetch news articles, either top headlines or search results, with pagination.
  ///
  /// Copied from [fetchNews].
  FetchNewsProvider({
    int page = 1,
    String? sortBy,
    String country = 'us',
    String? category,
    int pageSize = 20,
  }) : this._internal(
          (ref) => fetchNews(
            ref as FetchNewsRef,
            page: page,
            sortBy: sortBy,
            country: country,
            category: category,
            pageSize: pageSize,
          ),
          from: fetchNewsProvider,
          name: r'fetchNewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchNewsHash,
          dependencies: FetchNewsFamily._dependencies,
          allTransitiveDependencies: FetchNewsFamily._allTransitiveDependencies,
          page: page,
          sortBy: sortBy,
          country: country,
          category: category,
          pageSize: pageSize,
        );

  FetchNewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.sortBy,
    required this.country,
    required this.category,
    required this.pageSize,
  }) : super.internal();

  final int page;
  final String? sortBy;
  final String country;
  final String? category;
  final int pageSize;

  @override
  Override overrideWith(
    FutureOr<List<Articles>> Function(FetchNewsRef provider) create,
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
        page: page,
        sortBy: sortBy,
        country: country,
        category: category,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Articles>> createElement() {
    return _FetchNewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchNewsProvider &&
        other.page == page &&
        other.sortBy == sortBy &&
        other.country == country &&
        other.category == category &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, sortBy.hashCode);
    hash = _SystemHash.combine(hash, country.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchNewsRef on AutoDisposeFutureProviderRef<List<Articles>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `sortBy` of this provider.
  String? get sortBy;

  /// The parameter `country` of this provider.
  String get country;

  /// The parameter `category` of this provider.
  String? get category;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _FetchNewsProviderElement
    extends AutoDisposeFutureProviderElement<List<Articles>> with FetchNewsRef {
  _FetchNewsProviderElement(super.provider);

  @override
  int get page => (origin as FetchNewsProvider).page;
  @override
  String? get sortBy => (origin as FetchNewsProvider).sortBy;
  @override
  String get country => (origin as FetchNewsProvider).country;
  @override
  String? get category => (origin as FetchNewsProvider).category;
  @override
  int get pageSize => (origin as FetchNewsProvider).pageSize;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
