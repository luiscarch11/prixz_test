import '../../../core/rule.dart';

class EmailFormatRule<F> extends Rule<F, String> {
  EmailFormatRule(this.failure, String value) : super(value);

  @override
  final F failure;

  @override
  void validate() {
    final reg = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    isValid = reg.hasMatch(value);
  }
}
