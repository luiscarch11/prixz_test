abstract class YearFailure {
  const YearFailure();
  const factory YearFailure.biggerThanCurrent(int year) = _YearFailureBiggerThanCurrent;

  void when({
    required void Function(_YearFailureBiggerThanCurrent) biggerThanCurrent,
  }) {
    if (this is _YearFailureBiggerThanCurrent) {
      biggerThanCurrent.call(this as _YearFailureBiggerThanCurrent);
    }

    biggerThanCurrent.call(this as _YearFailureBiggerThanCurrent);
  }

  R map<R>({
    required R Function(_YearFailureBiggerThanCurrent) biggerThanCurrent,
  }) {
    if (this is _YearFailureBiggerThanCurrent) {
      return biggerThanCurrent.call(this as _YearFailureBiggerThanCurrent);
    }

    return biggerThanCurrent.call(this as _YearFailureBiggerThanCurrent);
  }

  void maybeWhen({
    void Function(_YearFailureBiggerThanCurrent)? biggerThanCurrent,
    required void Function() orElse,
  }) {
    if (this is _YearFailureBiggerThanCurrent && biggerThanCurrent != null) {
      biggerThanCurrent.call(this as _YearFailureBiggerThanCurrent);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_YearFailureBiggerThanCurrent)? biggerThanCurrent,
    required R Function() orElse,
  }) {
    if (this is _YearFailureBiggerThanCurrent && biggerThanCurrent != null) {
      return biggerThanCurrent.call(this as _YearFailureBiggerThanCurrent);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _YearFailureBiggerThanCurrent) {
      return 'biggerThanCurrent';
    }

    return 'biggerThanCurrent';
  }
}

class _YearFailureBiggerThanCurrent extends YearFailure {
  final int value;
  const _YearFailureBiggerThanCurrent(this.value);
}
