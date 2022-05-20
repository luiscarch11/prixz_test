abstract class FetchUserFailure {
  const FetchUserFailure();
  const factory FetchUserFailure.unknownError() = _FetchUserFailureUnknownError;

  void when({
    required void Function(_FetchUserFailureUnknownError) unknownError,
  }) {
    if (this is _FetchUserFailureUnknownError) {
      unknownError.call(this as _FetchUserFailureUnknownError);
    }

    unknownError.call(this as _FetchUserFailureUnknownError);
  }

  R map<R>({
    required R Function(_FetchUserFailureUnknownError) unknownError,
  }) {
    if (this is _FetchUserFailureUnknownError) {
      return unknownError.call(this as _FetchUserFailureUnknownError);
    }

    return unknownError.call(this as _FetchUserFailureUnknownError);
  }

  void maybeWhen({
    void Function(_FetchUserFailureUnknownError)? unknownError,
    required void Function() orElse,
  }) {
    if (this is _FetchUserFailureUnknownError && unknownError != null) {
      unknownError.call(this as _FetchUserFailureUnknownError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_FetchUserFailureUnknownError)? unknownError,
    required R Function() orElse,
  }) {
    if (this is _FetchUserFailureUnknownError && unknownError != null) {
      return unknownError.call(this as _FetchUserFailureUnknownError);
    }

    return orElse.call();
  }

  factory FetchUserFailure.fromString(String value) {
    if (value == 'unknownError') {
      return const FetchUserFailure.unknownError();
    }

    return const FetchUserFailure.unknownError();
  }

  @override
  String toString() {
    if (this is _FetchUserFailureUnknownError) {
      return 'unknownError';
    }

    return 'unknownError';
  }
}

class _FetchUserFailureUnknownError extends FetchUserFailure {
  const _FetchUserFailureUnknownError();
}
