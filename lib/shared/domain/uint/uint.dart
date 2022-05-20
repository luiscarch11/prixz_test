import '../../../core/validator.dart';
import '../../../core/value_object.dart';
import '../../../shared/domain/rules/non_negative_number_rule.dart';
import '../../../shared/domain/rules/valid_number_rule.dart';
import 'uint_failure.dart';

class Uint extends ValueObject<UintFailure, int, UintValidator> {
  Uint._(this.validator);
  @override
  final UintValidator validator;
  factory Uint(int input) {
    return Uint._(_validate(input));
  }
  factory Uint.fromString(String input) {
    final validator = UintValidator.fromString(input);
    return Uint._(validator);
  }
  static UintValidator _validate(int input) {
    final validator = UintValidator(input);
    return validator;
  }
}

class UintValidator extends Validator<UintFailure, int> {
  UintValidator._(int value, {String? stringValue})
      : super(
          value,
          rules: [
            ValidNumberRule(UintFailure.invalid(stringValue ?? value.toString()), stringValue ?? value.toString()),
            NonNegativeNumberRule(
              UintFailure.negative(value),
              value,
            ),
          ],
        );
  factory UintValidator(int value) => UintValidator._(value)..validate();
  factory UintValidator.fromString(String value) {
    return UintValidator._(
      0,
      stringValue: value,
    )..validate();
  }
}
