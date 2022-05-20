abstract class PhoneNumberFailure {
  const PhoneNumberFailure();
  const factory PhoneNumberFailure.invalidCharactersCount() = _PhoneNumberFailureInvalidCharactersCount;
  const factory PhoneNumberFailure.invalidFormat() = _PhoneNumberFailureInvalidFormat;

  void when({
    required void Function(_PhoneNumberFailureInvalidCharactersCount) invalidCharactersCount,
    required void Function(_PhoneNumberFailureInvalidFormat) invalidFormat,
  }) {
    if (this is _PhoneNumberFailureInvalidCharactersCount) {
      invalidCharactersCount.call(this as _PhoneNumberFailureInvalidCharactersCount);
    }

    if (this is _PhoneNumberFailureInvalidFormat) {
      invalidFormat.call(this as _PhoneNumberFailureInvalidFormat);
    }

    invalidCharactersCount.call(this as _PhoneNumberFailureInvalidCharactersCount);
  }

  R map<R>({
    required R Function(_PhoneNumberFailureInvalidCharactersCount) invalidCharactersCount,
    required R Function(_PhoneNumberFailureInvalidFormat) invalidFormat,
  }) {
    if (this is _PhoneNumberFailureInvalidCharactersCount) {
      return invalidCharactersCount.call(this as _PhoneNumberFailureInvalidCharactersCount);
    }

    if (this is _PhoneNumberFailureInvalidFormat) {
      return invalidFormat.call(this as _PhoneNumberFailureInvalidFormat);
    }

    return invalidCharactersCount.call(this as _PhoneNumberFailureInvalidCharactersCount);
  }

  void maybeWhen({
    void Function(_PhoneNumberFailureInvalidCharactersCount)? invalidCharactersCount,
    void Function(_PhoneNumberFailureInvalidFormat)? invalidFormat,
    required void Function() orElse,
  }) {
    if (this is _PhoneNumberFailureInvalidCharactersCount && invalidCharactersCount != null) {
      invalidCharactersCount.call(this as _PhoneNumberFailureInvalidCharactersCount);
    }

    if (this is _PhoneNumberFailureInvalidFormat && invalidFormat != null) {
      invalidFormat.call(this as _PhoneNumberFailureInvalidFormat);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_PhoneNumberFailureInvalidCharactersCount)? invalidCharactersCount,
    R Function(_PhoneNumberFailureInvalidFormat)? invalidFormat,
    required R Function() orElse,
  }) {
    if (this is _PhoneNumberFailureInvalidCharactersCount && invalidCharactersCount != null) {
      return invalidCharactersCount.call(this as _PhoneNumberFailureInvalidCharactersCount);
    }

    if (this is _PhoneNumberFailureInvalidFormat && invalidFormat != null) {
      return invalidFormat.call(this as _PhoneNumberFailureInvalidFormat);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is _PhoneNumberFailureInvalidCharactersCount) {
      return 'invalidCharactersCount';
    }

    if (this is _PhoneNumberFailureInvalidFormat) {
      return 'invalidFormat';
    }

    return 'invalidCharactersCount';
  }
}

class _PhoneNumberFailureInvalidCharactersCount extends PhoneNumberFailure {
  const _PhoneNumberFailureInvalidCharactersCount();
}

class _PhoneNumberFailureInvalidFormat extends PhoneNumberFailure {
  const _PhoneNumberFailureInvalidFormat();
}
