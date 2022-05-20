import '../../../core/rule.dart';

class ValidNumberRule<F> extends Rule<F, String> {
  ValidNumberRule(this.failure, String value) : super(value);
  @override
  final F failure;

  @override
  void validate() {
    final transformedInt = int.tryParse(value);
    isValid = transformedInt != null;
  }
}
