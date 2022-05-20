import 'package:prixz_test/core/core.dart';

class OnlyLettersRule<F> extends Rule<F, String> {
  OnlyLettersRule(
    this.failure, {
    required String value,
  }) : super(value);
  @override
  final F failure;

  @override
  void validate() {
    isValid = RegExp(r'^[a-z A-Z]+$').hasMatch(value);
  }
}
