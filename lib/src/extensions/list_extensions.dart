import 'dart:async';

extension IterableExtensions<T> on Iterable<T> {
  T? get firstOrNull {
    return isEmpty ? null : first;
  }

  T? get lastOrNull {
    return isEmpty ? null : last;
  }

  bool isIn(Iterable<T> other) {
    for (final value in this) {
      if (!other.contains(value)) return false;
    }
    return true;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    return fold(<K, List<T>>{}, (previousValue, element) {
      final key = keyFunction(element);
      final list = previousValue[key] ?? [];
      list.add(element);
      previousValue[key] = list;
      return previousValue;
    });
  }
}

extension NullableIterableExtensions<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrNotEmpty => this != null && this!.isNotEmpty;
}

extension ListFirstWhereExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension IndexedIterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E element, int index) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }

  Future<void> futureForEach(FutureOr Function(E element, int index) f) async {
    var i = 0;
    await Future.forEach(this, (e) async => await f(e, i++));
  }
}
