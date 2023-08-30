import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';

import 'category_item.dart';

/// Finds the index of deleted element. Prev must be larger than next
int getDeletedIndex({
  required List<Category> prev,
  required List<Category> next,
}) {
  if (next.isEmpty) return 0;
  var lastNextIdx = next.length - 1;
  for (var i = 0; i <= lastNextIdx; i++) {
    if (prev[i].uuid != next[i].uuid) return i;
  }
  // last element of prev was deleted
  return lastNextIdx + 1;
}

/// Finds the index of added element. Prev must be shorter than next
int getAddedIndex({
  required List<Category> prev,
  required List<Category> next,
}) {
  if (prev.isEmpty) return 0;
  var lastPrevIdx = prev.length - 1;
  for (var i = 0; i <= lastPrevIdx; i++) {
    if (prev[i].uuid != next[i].uuid) return i;
  }
  // element was addet at the end of the list
  return lastPrevIdx + 1;
}

class AnimatedCategoryList extends ConsumerStatefulWidget {
  const AnimatedCategoryList({super.key, required this.categories});
  final List<Category> categories;

  @override
  AnimatedCategoryListState createState() => AnimatedCategoryListState();
}

class AnimatedCategoryListState extends ConsumerState<AnimatedCategoryList> {
  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      categoriesProv,
      (previous, next) {
        if (previous == null) return;
        if (previous.length == next.length) return;
        if (previous.length > next.length) {
          // Item was deleted
          var deletedIdx = getDeletedIndex(prev: previous, next: next);
          _listKey.currentState!.removeItem(
            deletedIdx,
            (BuildContext context, Animation<double> animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: CategoryItem(category: previous[deletedIdx]),
              );
            },
          );
        } else {
          // Item was added
          var addedIdx = getAddedIndex(prev: previous, next: next);
          _listKey.currentState!.insertItem(addedIdx);
        }
      },
    );

    return AnimatedList(
      key: _listKey,
      initialItemCount: widget.categories.length,
      padding: const EdgeInsets.only(bottom: 80),
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: CategoryItem(category: widget.categories[index]),
        );
      },
    );
  }
}
