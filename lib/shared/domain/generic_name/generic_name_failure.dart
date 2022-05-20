abstract class GenericNameFailure {
  const GenericNameFailure();
  const factory GenericNameFailure.invalidLength(String value) = _GenericNameFailureTooLong;

  void when({
    required void Function(_GenericNameFailureTooLong) invalidLength,
  }) {
    if (this is _GenericNameFailureTooLong) {
      invalidLength.call(this as _GenericNameFailureTooLong);
    }

    invalidLength.call(this as _GenericNameFailureTooLong);
  }

  R map<R>({
    required R Function(_GenericNameFailureTooLong) invalidLength,
  }) {
    if (this is _GenericNameFailureTooLong) {
      return invalidLength.call(this as _GenericNameFailureTooLong);
    }

    return invalidLength.call(this as _GenericNameFailureTooLong);
  }

  void maybeWhen({
    void Function(_GenericNameFailureTooLong)? invalidLength,
    required void Function() orElse,
  }) {
    if (this is _GenericNameFailureTooLong && invalidLength != null) {
      invalidLength.call(this as _GenericNameFailureTooLong);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_GenericNameFailureTooLong)? invalidLength,
    required R Function() orElse,
  }) {
    if (this is _GenericNameFailureTooLong && invalidLength != null) {
      return invalidLength.call(this as _GenericNameFailureTooLong);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _GenericNameFailureTooLong) {
      return 'invalidLength';
    }

    return 'invalidLength';
  }
}

class _GenericNameFailureTooLong extends GenericNameFailure {
  final String value;

  const _GenericNameFailureTooLong(this.value);
}
