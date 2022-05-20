abstract class BookSearchFailure {
  const BookSearchFailure();
  const factory BookSearchFailure.serverError() = _BookSearchFailureServerError;

  void when({
    required void Function(_BookSearchFailureServerError) serverError,
  }) {
    if (this is _BookSearchFailureServerError) {
      serverError.call(this as _BookSearchFailureServerError);
    }

    serverError.call(this as _BookSearchFailureServerError);
  }

  R map<R>({
    required R Function(_BookSearchFailureServerError) serverError,
  }) {
    if (this is _BookSearchFailureServerError) {
      return serverError.call(this as _BookSearchFailureServerError);
    }

    return serverError.call(this as _BookSearchFailureServerError);
  }

  void maybeWhen({
    void Function(_BookSearchFailureServerError)? serverError,
    required void Function() orElse,
  }) {
    if (this is _BookSearchFailureServerError && serverError != null) {
      serverError.call(this as _BookSearchFailureServerError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_BookSearchFailureServerError)? serverError,
    required R Function() orElse,
  }) {
    if (this is _BookSearchFailureServerError && serverError != null) {
      return serverError.call(this as _BookSearchFailureServerError);
    }

    return orElse.call();
  }

  factory BookSearchFailure.fromString(String value) {
    if (value == 'serverError') {
      return const BookSearchFailure.serverError();
    }

    return const BookSearchFailure.serverError();
  }

  @override
  String toString() {
    if (this is _BookSearchFailureServerError) {
      return 'serverError';
    }

    return 'serverError';
  }
}

class _BookSearchFailureServerError extends BookSearchFailure {
  const _BookSearchFailureServerError();
}
