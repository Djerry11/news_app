import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filter_notifier.g.dart';

typedef FilterValues = ({
  String? sortBy,
  String? category,
});

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  FilterValues build() {
    return (
      sortBy: 'relevancy',
      category: 'general',
    );
  }

  void setFilterValues({
    String? sortBy,
    String? category,
  }) {
    state = (
      sortBy: sortBy ?? state.sortBy,
      category: category ?? state.category,
    );
  }
}
