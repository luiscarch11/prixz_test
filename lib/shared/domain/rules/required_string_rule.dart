import '../../../core/rule.dart';

class RequiredStringRule<F> extends Rule<F, String> {
  RequiredStringRule(this._failure, String value) : super(value);
  final F _failure;
  @override
  F get failure => _failure;
  @override
  void validate() {
    isValid = value.isNotEmpty;
  }
}
