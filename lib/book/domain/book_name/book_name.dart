import 'package:prixz_test/shared/domain/rules/between_characters_rule.dart';

import '../../../core/validator.dart';
import '../../../core/value_object.dart';
import '../../../shared/domain/rules/required_string_rule.dart';

import 'book_name_failure.dart';

class BookName extends ValueObject<BookNameFailure, String, BookNameValidator> {
  BookName._(this.validator);
  factory BookName(String input) {
    return BookName._(_validate(input));
  }
  static BookNameValidator _validate(String input) {
    final validator = BookNameValidator(input);
    return validator;
  }

  @override
  final BookNameValidator validator;
}

class BookNameValidator extends Validator<BookNameFailure, String> {
  BookNameValidator._(String value)
      : super(
          value,
          rules: [
            BetweenCharactersRule(
              BookNameFailure.tooLong(value),
              since: 2,
              until: 1000,
              value: value,
            ),
            RequiredStringRule(
              const BookNameFailure.empty(),
              value,
            ),
          ],
        );
  factory BookNameValidator(String value) => BookNameValidator._(value)..validate();
}
