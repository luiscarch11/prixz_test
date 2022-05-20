import './validator.dart';

import 'either.dart';
import 'unexpected_value_failure.dart';

abstract class ValueObject<L, R, V extends Validator<L, R>> {
  ValueObject();
  Either<L, R> get value => validator.valueAfterValidation;
  V get validator;
  bool get isValid => value.isRight;

  bool get isInvalid => value.isLeft;

  R getOrCrash() => value.rightOrElse((l) {
        throw UnexpectedValueError<L>(l);
      });

  R getOrElse(R orElse) => value.rightOrElse((_) => orElse);

  void when({required void Function(L) isLeft, required void Function(R) isRight}) =>
      value.when(isLeft: isLeft, isRight: isRight);

  T map<T>({required T Function(L) isLeft, required T Function(R) isRight}) =>
      value.map(isLeft: isLeft, isRight: isRight);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<L, R, V> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
