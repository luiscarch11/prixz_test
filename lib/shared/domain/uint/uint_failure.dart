abstract class UintFailure {
  const UintFailure();
  factory UintFailure.invalid(String value) = _UintFailureInvalid;
  factory UintFailure.negative(int value) = _UintFailureNegative;

  void when({
    required void Function(_UintFailureInvalid) invalid,
    required void Function(_UintFailureNegative) negative,
  }) {
    if (this is _UintFailureInvalid) {
      invalid.call(this as _UintFailureInvalid);
    }

    if (this is _UintFailureNegative) {
      negative.call(this as _UintFailureNegative);
    }

    invalid.call(this as _UintFailureInvalid);
  }

  R map<R>({
    required R Function(_UintFailureInvalid) invalid,
    required R Function(_UintFailureNegative) negative,
  }) {
    if (this is _UintFailureInvalid) {
      return invalid.call(this as _UintFailureInvalid);
    }

    if (this is _UintFailureNegative) {
      return negative.call(this as _UintFailureNegative);
    }

    return invalid.call(this as _UintFailureInvalid);
  }

  void maybeWhen({
    void Function(_UintFailureInvalid)? invalid,
    void Function(_UintFailureNegative)? negative,
    required void Function() orElse,
  }) {
    if (this is _UintFailureInvalid && invalid != null) {
      invalid.call(this as _UintFailureInvalid);
    }

    if (this is _UintFailureNegative && negative != null) {
      negative.call(this as _UintFailureNegative);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_UintFailureInvalid)? invalid,
    R Function(_UintFailureNegative)? negative,
    required R Function() orElse,
  }) {
    if (this is _UintFailureInvalid && invalid != null) {
      return invalid.call(this as _UintFailureInvalid);
    }

    if (this is _UintFailureNegative && negative != null) {
      return negative.call(this as _UintFailureNegative);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _UintFailureInvalid) {
      return 'invalid';
    }

    if (this is _UintFailureNegative) {
      return 'negative';
    }

    return 'invalid';
  }
}

class _UintFailureInvalid extends UintFailure {
  final String value;

  _UintFailureInvalid(this.value);
}

class _UintFailureNegative extends UintFailure {
  final int value;

  _UintFailureNegative(this.value);
}
