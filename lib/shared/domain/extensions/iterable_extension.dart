extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }

    return null;
  }

  bool containsWhere(bool Function(T element) test) {
    return firstWhereOrNull(test) != null;
  }

  List<T> removeOrAdd(T element) {
    final newList = List<T>.from(this);
    final wasInTheList = newList.remove(element);
    if (!wasInTheList) newList.add(element);
    return newList;
  }
}
