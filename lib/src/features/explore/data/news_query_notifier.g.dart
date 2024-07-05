// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_query_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newsQueryNotifierHash() => r'fdd940c110d975523ce28d7ef055ca2f6c82349b';

/// A notifier class to keep track of the search query (with debouncing)
///
/// Copied from [NewsQueryNotifier].
@ProviderFor(NewsQueryNotifier)
final newsQueryNotifierProvider =
    AutoDisposeNotifierProvider<NewsQueryNotifier, String>.internal(
  NewsQueryNotifier.new,
  name: r'newsQueryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newsQueryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewsQueryNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
