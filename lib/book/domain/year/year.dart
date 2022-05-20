import 'package:prixz_test/core/core.dart';
import 'package:prixz_test/shared/domain/rules/non_bigger_than_value_number_rule.dart';

import 'year_failure.dart';

class Year extends ValueObject<YearFailure, int, YearValidator> {
  Year._(this.validator);
  factory Year(int value) {
    return Year._(_validate(value));
  }
  static YearValidator _validate(int value) {
    final validator = YearValidator(value);
    return validator;
  }

  @override
  final YearValidator validator;
}

class YearValidator extends Validator<YearFailure, int> {
  static int get _currentYear => DateTime.now().year;
  YearValidator._(int value)
      : super(
          value,
          rules: [
            NonBiggerThanValueNumberRule(
              YearFailure.biggerThanCurrent(_currentYear),
              maxValue: _currentYear,
              value: value,
            ),
          ],
        );

  factory YearValidator(int value) => YearValidator._(value)..validate();
}
