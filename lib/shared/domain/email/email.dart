import '../../../core/validator.dart';
import '../../../core/value_object.dart';
import '../rules/email_rule.dart';
import '../rules/required_string_rule.dart';
import 'email_failure.dart';

class Email extends ValueObject<EmailFailure, String, EmailValidator> {
  Email._(this.validator);
  factory Email(String value) {
    return Email._(_validate(value));
  }
  static EmailValidator _validate(String value) {
    final validator = EmailValidator(value);
    return validator;
  }

  String? get validationResult => validator.valueAfterValidation
      .leftOrElseNullable(
        (_) => null,
      )
      ?.map(
        empty: (_) => 'Can\'t be empty',
        invalid: (_) => 'Invalid email format',
      );
  @override
  final EmailValidator validator;
}

class EmailValidator extends Validator<EmailFailure, String> {
  EmailValidator._(String value)
      : super(
          value,
          rules: [
            RequiredStringRule(
              const EmailFailure.empty(),
              value,
            ),
            EmailFormatRule(
              EmailFailure.invalid(value),
              value,
            ),
          ],
        );
  factory EmailValidator(String value) => EmailValidator._(value)..validate();
}
