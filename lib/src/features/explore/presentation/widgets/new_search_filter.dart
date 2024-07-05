import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/explore/data/filter_notifier.dart';
import 'package:news_app/src/features/explore/presentation/widgets/gradient_buttom.dart';
import 'package:news_app/src/localization/extensions.dart';

void showFilterSheet(BuildContext context, ref, {required double maxWidth}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    ),
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 1400),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: 550,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FilterModel(
                enumValue: SortBy.values,
                title: 'sortBy',
              ),
              const FilterModel(
                enumValue: NewsCategory.values,
                title: 'Category',
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: maxWidth * 0.8,
                  child: GradientButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                    },
                    child: Text(
                      'Apply Filters',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

class FilterModel extends ConsumerWidget {
  const FilterModel({
    super.key,
    required this.enumValue,
    required this.title,
  });

  final List<dynamic> enumValue;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterList =
        enumValue.map((value) => value.toString().split('.').last).toList();
    var selectedValue = ref.watch(filterNotifierProvider);
    print('selectedValue: $selectedValue');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
        ),
        Consumer(builder: (context, ref, child) {
          return Wrap(
            children: filterList.map((value) {
              // print('selected: $selectedValue ');
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(
                    value.toCapitalized(),
                  ),
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: selectedValue.toString().contains(value)
                            ? Colors.white
                            : Colors.black54,
                      ),
                  selected: selectedValue.toString().contains(value),
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey.shade100,
                  onSelected: (selected) {
                    //TODO:: MAKE CHANGES ACCORDING TO FILTER
                    title == 'sortBy'
                        ? ref
                            .read(filterNotifierProvider.notifier)
                            .setFilterValues(
                              sortBy: value,
                            )
                        : ref
                            .read(filterNotifierProvider.notifier)
                            .setFilterValues(
                              category: value,
                            );
                  },
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
