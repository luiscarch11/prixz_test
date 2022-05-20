abstract class PersonNameOrSurnameFailure {
  const PersonNameOrSurnameFailure();
  const factory PersonNameOrSurnameFailure.empty() = _NameFailureEmpty;
  const factory PersonNameOrSurnameFailure.invalid() = _NameFailureInvalid;
  const factory PersonNameOrSurnameFailure.wrongLength(String value) = _NameFailureWrongLength;

  void when({
    required void Function(_NameFailureEmpty) empty,
    required void Function(_NameFailureInvalid) invalid,
    required void Function(_NameFailureWrongLength) wrongLength,
  }) {
    if (this is _NameFailureEmpty) {
      empty.call(this as _NameFailureEmpty);
    }

    if (this is _NameFailureInvalid) {
      invalid.call(this as _NameFailureInvalid);
    }

    if (this is _NameFailureWrongLength) {
      wrongLength.call(this as _NameFailureWrongLength);
    }

    empty.call(this as _NameFailureEmpty);
  }

  R map<R>({
    required R Function(_NameFailureEmpty) empty,
    required R Function(_NameFailureInvalid) invalid,
    required R Function(_NameFailureWrongLength) wrongLength,
  }) {
    if (this is _NameFailureEmpty) {
      return empty.call(this as _NameFailureEmpty);
    }

    if (this is _NameFailureInvalid) {
      return invalid.call(this as _NameFailureInvalid);
    }

    if (this is _NameFailureWrongLength) {
      return wrongLength.call(this as _NameFailureWrongLength);
    }

    return empty.call(this as _NameFailureEmpty);
  }

  void maybeWhen({
    void Function(_NameFailureEmpty)? empty,
    void Function(_NameFailureInvalid)? invalid,
    void Function(_NameFailureWrongLength)? wrongLength,
    required void Function() orElse,
  }) {
    if (this is _NameFailureEmpty && empty != null) {
      empty.call(this as _NameFailureEmpty);
    }

    if (this is _NameFailureInvalid && invalid != null) {
      invalid.call(this as _NameFailureInvalid);
    }

    if (this is _NameFailureWrongLength && wrongLength != null) {
      wrongLength.call(this as _NameFailureWrongLength);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_NameFailureEmpty)? empty,
    R Function(_NameFailureInvalid)? invalid,
    R Function(_NameFailureWrongLength)? wrongLength,
    required R Function() orElse,
  }) {
    if (this is _NameFailureEmpty && empty != null) {
      return empty.call(this as _NameFailureEmpty);
    }

    if (this is _NameFailureInvalid && invalid != null) {
      return invalid.call(this as _NameFailureInvalid);
    }

    if (this is _NameFailureWrongLength && wrongLength != null) {
      return wrongLength.call(this as _NameFailureWrongLength);
    }

    return orElse.call();
  }

  factory PersonNameOrSurnameFailure.fromString(String value) {
    if (value == 'empty') {
      return const PersonNameOrSurnameFailure.empty();
    }

    if (value == 'invalid') {
      return const PersonNameOrSurnameFailure.invalid();
    }

    return const PersonNameOrSurnameFailure.empty();
  }

  @override
  String toString() {
    if (this is _NameFailureEmpty) {
      return 'empty';
    }

    if (this is _NameFailureInvalid) {
      return 'invalid';
    }

    if (this is _NameFailureWrongLength) {
      return 'wrongLength';
    }

    return 'empty';
  }
}

class _NameFailureEmpty extends PersonNameOrSurnameFailure {
  const _NameFailureEmpty();
}

class _NameFailureInvalid extends PersonNameOrSurnameFailure {
  const _NameFailureInvalid();
}

class _NameFailureWrongLength extends PersonNameOrSurnameFailure {
  final String value;

  const _NameFailureWrongLength(this.value);
}
