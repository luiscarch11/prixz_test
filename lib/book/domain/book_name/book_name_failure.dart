abstract class BookNameFailure {
  const BookNameFailure();
  const factory BookNameFailure.empty() = _BookNameFailureEmpty;
  const factory BookNameFailure.tooLong(String value) = _BookNameFailureTooLong;

  void when({
    required void Function(_BookNameFailureEmpty) empty,
    required void Function(_BookNameFailureTooLong) tooLong,
  }) {
    if (this is _BookNameFailureEmpty) {
      empty.call(this as _BookNameFailureEmpty);
    }

    if (this is _BookNameFailureTooLong) {
      tooLong.call(this as _BookNameFailureTooLong);
    }

    empty.call(this as _BookNameFailureEmpty);
  }

  R map<R>({
    required R Function(_BookNameFailureEmpty) empty,
    required R Function(_BookNameFailureTooLong) tooLong,
  }) {
    if (this is _BookNameFailureEmpty) {
      return empty.call(this as _BookNameFailureEmpty);
    }

    if (this is _BookNameFailureTooLong) {
      return tooLong.call(this as _BookNameFailureTooLong);
    }

    return empty.call(this as _BookNameFailureEmpty);
  }

  void maybeWhen({
    void Function(_BookNameFailureEmpty)? empty,
    void Function(_BookNameFailureTooLong)? tooLong,
    required void Function() orElse,
  }) {
    if (this is _BookNameFailureEmpty && empty != null) {
      empty.call(this as _BookNameFailureEmpty);
    }

    if (this is _BookNameFailureTooLong && tooLong != null) {
      tooLong.call(this as _BookNameFailureTooLong);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_BookNameFailureEmpty)? empty,
    R Function(_BookNameFailureTooLong)? tooLong,
    required R Function() orElse,
  }) {
    if (this is _BookNameFailureEmpty && empty != null) {
      return empty.call(this as _BookNameFailureEmpty);
    }

    if (this is _BookNameFailureTooLong && tooLong != null) {
      return tooLong.call(this as _BookNameFailureTooLong);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _BookNameFailureEmpty) {
      return 'empty';
    }

    if (this is _BookNameFailureTooLong) {
      return 'tooLong';
    }

    return 'empty';
  }
}

class _BookNameFailureEmpty extends BookNameFailure {
  const _BookNameFailureEmpty();
}

class _BookNameFailureTooLong extends BookNameFailure {
  final String value;

  const _BookNameFailureTooLong(this.value);
}
