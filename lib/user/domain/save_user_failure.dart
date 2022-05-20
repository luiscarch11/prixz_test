import 'package:prixz_test/core/failure.dart';

abstract class SaveUserFailure extends Failure {
  const SaveUserFailure();
  const factory SaveUserFailure.unexpectedError() = _SaveUserFailureUnexpectedError;

  void when({
    required void Function(_SaveUserFailureUnexpectedError) unexpectedError,
  }) {
    if (this is _SaveUserFailureUnexpectedError) {
      unexpectedError.call(this as _SaveUserFailureUnexpectedError);
    }

    unexpectedError.call(this as _SaveUserFailureUnexpectedError);
  }

  R map<R>({
    required R Function(_SaveUserFailureUnexpectedError) unexpectedError,
  }) {
    if (this is _SaveUserFailureUnexpectedError) {
      return unexpectedError.call(this as _SaveUserFailureUnexpectedError);
    }

    return unexpectedError.call(this as _SaveUserFailureUnexpectedError);
  }

  void maybeWhen({
    void Function(_SaveUserFailureUnexpectedError)? unexpectedError,
    required void Function() orElse,
  }) {
    if (this is _SaveUserFailureUnexpectedError && unexpectedError != null) {
      unexpectedError.call(this as _SaveUserFailureUnexpectedError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_SaveUserFailureUnexpectedError)? unexpectedError,
    required R Function() orElse,
  }) {
    if (this is _SaveUserFailureUnexpectedError && unexpectedError != null) {
      return unexpectedError.call(this as _SaveUserFailureUnexpectedError);
    }

    return orElse.call();
  }

  factory SaveUserFailure.fromString(String value) {
    if (value == 'unexpectedError') {
      return const SaveUserFailure.unexpectedError();
    }

    return const SaveUserFailure.unexpectedError();
  }

  @override
  String toString() {
    if (this is _SaveUserFailureUnexpectedError) {
      return 'unexpectedError';
    }

    return 'unexpectedError';
  }
}

class _SaveUserFailureUnexpectedError extends SaveUserFailure {
  const _SaveUserFailureUnexpectedError();
}
