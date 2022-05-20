abstract class EmailFailure {
  const EmailFailure();
  factory EmailFailure.invalid(String value) = _EmailFailureInvalid;
  const factory EmailFailure.empty() = _EmailFailureEmpty;

  void when({
    required void Function(_EmailFailureInvalid) invalid,
    required void Function(_EmailFailureEmpty) empty,
  }) {
    if (this is _EmailFailureInvalid) {
      invalid.call(this as _EmailFailureInvalid);
    }

    if (this is _EmailFailureEmpty) {
      empty.call(this as _EmailFailureEmpty);
    }

    invalid.call(this as _EmailFailureInvalid);
  }

  R map<R>({
    required R Function(_EmailFailureInvalid) invalid,
    required R Function(_EmailFailureEmpty) empty,
  }) {
    if (this is _EmailFailureInvalid) {
      return invalid.call(this as _EmailFailureInvalid);
    }

    if (this is _EmailFailureEmpty) {
      return empty.call(this as _EmailFailureEmpty);
    }

    return invalid.call(this as _EmailFailureInvalid);
  }

  void maybeWhen({
    void Function(_EmailFailureInvalid)? invalid,
    void Function(_EmailFailureEmpty)? empty,
    required void Function() orElse,
  }) {
    if (this is _EmailFailureInvalid && invalid != null) {
      invalid.call(this as _EmailFailureInvalid);
    }

    if (this is _EmailFailureEmpty && empty != null) {
      empty.call(this as _EmailFailureEmpty);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_EmailFailureInvalid)? invalid,
    R Function(_EmailFailureEmpty)? empty,
    required R Function() orElse,
  }) {
    if (this is _EmailFailureInvalid && invalid != null) {
      return invalid.call(this as _EmailFailureInvalid);
    }

    if (this is _EmailFailureEmpty && empty != null) {
      return empty.call(this as _EmailFailureEmpty);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _EmailFailureInvalid) {
      return 'invalid';
    }

    if (this is _EmailFailureEmpty) {
      return 'empty';
    }

    return 'invalid';
  }
}

class _EmailFailureInvalid extends EmailFailure {
  const _EmailFailureInvalid(this.value);
  final String value;
}

class _EmailFailureEmpty extends EmailFailure {
  const _EmailFailureEmpty();
}
