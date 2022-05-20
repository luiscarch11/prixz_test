import '../../../core/rule.dart';

class NonNegativeNumberRule<F> extends Rule<F, int> {
  NonNegativeNumberRule(this.failure, int value) : super(value);
  factory NonNegativeNumberRule.fromString(F failure, String value) {
    return NonNegativeNumberRule(
      failure,
      int.tryParse(value) ?? 0,
    );
  }
  @override
  final F failure;

  @override
  void validate() {
    isValid = value >= 0;
  }
}
