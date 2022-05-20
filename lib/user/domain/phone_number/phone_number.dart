import 'package:prixz_test/shared/domain/rules/between_characters_rule.dart';
import 'package:prixz_test/shared/domain/rules/valid_number_rule.dart';

import '../../../core/value_object.dart';
import '../../../core/validator.dart';

import 'phone_number_failure.dart';

class PhoneNumber extends ValueObject<PhoneNumberFailure, String, PhoneNumberValidator> {
  PhoneNumber._(this.validator);
  factory PhoneNumber(String value) {
    return PhoneNumber._(_validate(value));
  }
  static PhoneNumberValidator _validate(String value) {
    final validator = PhoneNumberValidator(value);
    return validator;
  }

  static int get minCharacters => 1;
  static int get maxCharacters => 10;
  @override
  final PhoneNumberValidator validator;
  String? get validationResult => validator.valueAfterValidation
      .leftOrElseNullable(
        (_) => null,
      )
      ?.map(
        invalidFormat: (_) => 'Incorrect format',
        invalidCharactersCount: (f) =>
            'Must have between ${PhoneNumber.minCharacters} and ${PhoneNumber.maxCharacters} characters',
      );
}

class PhoneNumberValidator extends Validator<PhoneNumberFailure, String> {
  PhoneNumberValidator._(String value)
      : super(
          value,
          rules: [
            BetweenCharactersRule(
              const PhoneNumberFailure.invalidCharactersCount(),
              since: PhoneNumber.minCharacters,
              until: PhoneNumber.maxCharacters,
              value: value,
            ),
            ValidNumberRule(
              const PhoneNumberFailure.invalidFormat(),
              value,
            ),
          ],
        );
  factory PhoneNumberValidator(String value) => PhoneNumberValidator._(value)..validate();
}
