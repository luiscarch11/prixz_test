import 'package:prixz_test/shared/domain/rules/between_characters_rule.dart';

import '../../../core/validator.dart';
import '../../../core/value_object.dart';
import 'generic_name_failure.dart';

class GenericName extends ValueObject<GenericNameFailure, String, GenericNameValidator> {
  GenericName._(this.validator);
  factory GenericName(String value) {
    return GenericName._(_validate(value));
  }
  static GenericNameValidator _validate(String value) {
    final validator = GenericNameValidator(value);
    return validator;
  }

  static int get minCharacters => 2;
  static int get maxCharacters => 100;
  @override
  final GenericNameValidator validator;
  String? get validationResult => validator.valueAfterValidation
      .leftOrElseNullable(
        (_) => null,
      )
      ?.map(
        invalidLength: (f) =>
            'Must have between ${GenericName.minCharacters} and ${GenericName.maxCharacters} characters',
      );
}

class GenericNameValidator extends Validator<GenericNameFailure, String> {
  GenericNameValidator._(String value)
      : super(
          value,
          rules: [
            BetweenCharactersRule(
              GenericNameFailure.invalidLength(value),
              value: value,
              since: GenericName.minCharacters,
              until: GenericName.maxCharacters,
            ),
          ],
        );

  factory GenericNameValidator(String value) => GenericNameValidator._(value)..validate();
}
