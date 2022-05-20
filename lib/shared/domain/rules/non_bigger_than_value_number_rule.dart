import '../../../core/rule.dart';

class NonBiggerThanValueNumberRule<F> extends Rule<F, num> {
  NonBiggerThanValueNumberRule(
    this.failure, {
    required num value,
    required this.maxValue,
  }) : super(value);
  @override
  final F failure;

  final num maxValue;
  @override
  void validate() {
    isValid = value <= maxValue;
  }
}
